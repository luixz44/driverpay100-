import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Meu Perfil', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Center(
            child: CircleAvatar(
              radius: 40,
              child: Text('M', style: TextStyle(fontSize: 32)),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            initialValue: 'Motorista',
            decoration: const InputDecoration(labelText: 'Nome completo', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          TextFormField(
            initialValue: 'motorista@email.com',
            enabled: false,
            decoration: const InputDecoration(labelText: 'E-mail', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.save),
            label: const Text('Salvar alterações'),
          ),
        ],
      ),
    );
  }
}