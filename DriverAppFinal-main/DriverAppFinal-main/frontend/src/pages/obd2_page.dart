import 'package:flutter/material.dart';

class OBD2Page extends StatefulWidget {
  const OBD2Page({super.key});

  @override
  State<OBD2Page> createState() => _OBD2PageState();
}

class _OBD2PageState extends State<OBD2Page> {
  bool _connected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('OBD2 Bluetooth', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Chip(
                label: Text(_connected ? 'Conectado' : 'Desconectado'),
                backgroundColor: _connected ? Colors.green.shade100 : Colors.red.shade100,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => setState(() => _connected = !_connected),
            icon: Icon(_connected ? Icons.bluetooth_disabled : Icons.bluetooth),
            label: Text(_connected ? 'Desconectar' : 'Conectar OBD2'),
          ),
          const SizedBox(height: 24),
          if (_connected) ...[
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: const [
                _ObdMetricCard(label: 'RPM', value: '2.500'),
                _ObdMetricCard(label: 'Velocidade', value: '60 km/h'),
                _ObdMetricCard(label: 'Temp. Motor', value: '90 °C'),
                _ObdMetricCard(label: 'Consumo', value: '8.5 L/100km'),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ObdMetricCard extends StatelessWidget {
  final String label;
  final String value;

  const _ObdMetricCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}