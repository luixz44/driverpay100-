import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  List<dynamic> _vehicles = [];
  List<dynamic> _expenses = [];
  dynamic _selectedVehicleId;
  bool _loading = false;

  final currencyFmt = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  final expenseTypes = {
    'combustivel': '⛽ Combustível',
    'manutencao': '🔧 Manutenção',
    'lavagem': '🫧 Lavagem',
    'seguro': '🛡️ Seguro',
    'ipva': '📋 IPVA',
    'multa': '⚠️ Multa',
    'outros': '📦 Outros',
  };

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  Future<void> _loadVehicles() async {
    try {
      final list = await ApiService.listVehicles();
      setState(() {
        _vehicles = list;
        if (list.isNotEmpty) {
          _selectedVehicleId = list[0]['id'];
          _loadExpenses();
        }
      });
    } catch (_) {}
  }

  Future<void> _loadExpenses() async {
    if (_selectedVehicleId == null) return;
    setState(() => _loading = true);
    try {
      final expenses = await ApiService.listExpensesByVehicle(_selectedVehicleId);
      setState(() => _expenses = expenses);
    } finally {
      setState(() => _loading = false);
    }
  }

  void _openExpenseModal([Map<String, dynamic>? expense]) {
    final valueCtrl = TextEditingController(text: expense?['value']?.toString() ?? '');
    final notesCtrl = TextEditingController(text: expense?['notes'] ?? '');
    String type = expense?['type'] ?? 'combustivel';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 16, right: 16, top: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(expense == null ? 'Nova Despesa' : 'Editar Despesa', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: type,
              decoration: const InputDecoration(labelText: 'Tipo'),
              items: expenseTypes.entries
                  .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                  .toList(),
              onChanged: (v) => type = v!,
            ),
            TextField(controller: valueCtrl, decoration: const InputDecoration(labelText: 'Valor (R\$)'), keyboardType: TextInputType.number),
            TextField(controller: notesCtrl, decoration: const InputDecoration(labelText: 'Observações')),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final payload = {
                  'vehicle_id': _selectedVehicleId,
                  'type': type,
                  'value': double.tryParse(valueCtrl.text) ?? 0.0,
                  'date': DateTime.now().toIso8601String(),
                  'notes': notesCtrl.text,
                };
                if (expense == null) {
                  await ApiService.createExpense(payload);
                } else {
                  await ApiService.updateExpense(expense['id'], payload);
                }
                if (mounted) Navigator.pop(ctx);
                _loadExpenses();
              },
              child: const Text('Salvar'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalExpense = _expenses.fold<double>(0, (s, e) => s + (e['value'] ?? 0));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () => _openExpenseModal()),
        ],
      ),
      body: Column(
        children: [
          if (_vehicles.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButton<dynamic>(
                      value: _selectedVehicleId,
                      isExpanded: true,
                      items: _vehicles.map((v) {
                        return DropdownMenuItem(
                          value: v['id'],
                          child: Text('${v['brand']} ${v['model']} - ${v['plate']}'),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() => _selectedVehicleId = val);
                        _loadExpenses();
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Chip(label: Text('Total: ${currencyFmt.format(totalExpense)}'), backgroundColor: Colors.red.shade100),
                ],
              ),
            ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _expenses.length,
                    itemBuilder: (ctx, i) {
                      final e = _expenses[i];
                      return ListTile(
                        title: Text('${expenseTypes[e['type']] ?? e['type']} - ${currencyFmt.format(e['value'])}'),
                        subtitle: Text(e['notes'] ?? ''),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await ApiService.deleteExpense(e['id']);
                            _loadExpenses();
                          },
                        ),
                        onTap: () => _openExpenseModal(e),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}