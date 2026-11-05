import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';

class RidesPage extends StatefulWidget {
  const RidesPage({super.key});

  @override
  State<RidesPage> createState() => _RidesPageState();
}

class _RidesPageState extends State<RidesPage> {
  List<dynamic> _vehicles = [];
  List<dynamic> _rides = [];
  dynamic _selectedVehicleId;
  bool _loading = false;

  final currencyFmt = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

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
          _loadRides();
        }
      });
    } catch (_) {}
  }

  Future<void> _loadRides() async {
    if (_selectedVehicleId == null) return;
    setState(() => _loading = true);
    try {
      final rides = await ApiService.listRidesByVehicle(_selectedVehicleId);
      setState(() => _rides = rides);
    } finally {
      setState(() => _loading = false);
    }
  }

  void _openRideModal([Map<String, dynamic>? ride]) {
    final valueCtrl = TextEditingController(text: ride?['value']?.toString() ?? '');
    final distCtrl = TextEditingController(text: ride?['distance_km']?.toString() ?? '');
    final notesCtrl = TextEditingController(text: ride?['notes'] ?? '');
    String appUsed = ride?['app_used'] ?? 'Uber';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 16, right: 16, top: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(ride == null ? 'Nova Corrida' : 'Editar Corrida', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: appUsed,
              decoration: const InputDecoration(labelText: 'Aplicativo'),
              items: ['Uber', '99', 'InDrive', 'Chofer', 'Outros']
                  .map((a) => DropdownMenuItem(value: a, child: Text(a)))
                  .toList(),
              onChanged: (v) => appUsed = v!,
            ),
            TextField(controller: valueCtrl, decoration: const InputDecoration(labelText: 'Valor (R\$)'), keyboardType: TextInputType.number),
            TextField(controller: distCtrl, decoration: const InputDecoration(labelText: 'Distância (km)'), keyboardType: TextInputType.number),
            TextField(controller: notesCtrl, decoration: const InputDecoration(labelText: 'Observações')),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final payload = {
                  'vehicle_id': _selectedVehicleId,
                  'app_used': appUsed,
                  'value': double.tryParse(valueCtrl.text) ?? 0.0,
                  'distance_km': double.tryParse(distCtrl.text) ?? 0.0,
                  'notes': notesCtrl.text,
                };
                if (ride == null) {
                  await ApiService.createRide(payload);
                } else {
                  await ApiService.updateRide(ride['id'], payload);
                }
                if (mounted) Navigator.pop(ctx);
                _loadRides();
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
    final totalRevenue = _rides.fold<double>(0, (s, r) => s + (r['value'] ?? 0));
    final totalKm = _rides.fold<double>(0, (s, r) => s + (r['distance_km'] ?? 0));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Corridas'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () => _openRideModal()),
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
                        _loadRides();
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Chip(label: Text(currencyFmt.format(totalRevenue)), backgroundColor: Colors.green.shade100),
                  const SizedBox(width: 4),
                  Chip(label: Text('${totalKm.toStringAsFixed(0)} km'), backgroundColor: Colors.blue.shade100),
                ],
              ),
            ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _rides.length,
                    itemBuilder: (ctx, i) {
                      final r = _rides[i];
                      return ListTile(
                        title: Text('${r['app_used']} - ${currencyFmt.format(r['value'])}'),
                        subtitle: Text('${r['distance_km']} km • ${r['notes'] ?? ''}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await ApiService.deleteRide(r['id']);
                            _loadRides();
                          },
                        ),
                        onTap: () => _openRideModal(r),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}