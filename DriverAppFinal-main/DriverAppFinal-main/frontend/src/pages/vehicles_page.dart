import 'package:flutter/material.dart';

class VehiclesPage extends StatefulWidget {
  const VehiclesPage({super.key});

  @override
  State<VehiclesPage> createState() => _VehiclesPageState();
}

class _VehiclesPageState extends State<VehiclesPage> {
  final List<Map<String, dynamic>> _vehicles = [];

  void _openVehicleModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Novo Veículo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(decoration: const InputDecoration(labelText: 'Marca')),
            TextField(decoration: const InputDecoration(labelText: 'Modelo')),
            TextField(decoration: const InputDecoration(labelText: 'Placa')),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
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
    return Scaffold(
      body: _vehicles.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.directions_car, size: 64, color: Colors.grey),
                  const SizedBox(height: 12),
                  const Text('Nenhum veículo cadastrado'),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _openVehicleModal,
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar Veículo'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _vehicles.length,
              itemBuilder: (ctx, idx) => ListTile(
                title: Text(_vehicles[idx]['model']),
                subtitle: Text(_vehicles[idx]['plate']),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openVehicleModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}