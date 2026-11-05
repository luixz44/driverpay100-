import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  Future<void> _handleDownload(BuildContext context, String endpoint, String title) async {
    try {
      await ApiService.downloadReport(endpoint);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title descarregado com sucesso!')),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao descarregar relatório')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relatórios')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Exporte os seus dados em Excel ou PDF para análise externa.', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          _ReportCard(
            title: 'Corridas (Excel)',
            subtitle: 'Todas as corridas em planilha .xlsx',
            icon: Icons.table_chart,
            color: Colors.green,
            onTap: () => _handleDownload(context, 'rides-excel', 'Corridas (Excel)'),
          ),
          _ReportCard(
            title: 'Despesas (Excel)',
            subtitle: 'Todas as despesas em planilha .xlsx',
            icon: Icons.table_chart,
            color: Colors.green,
            onTap: () => _handleDownload(context, 'expenses-excel', 'Despesas (Excel)'),
          ),
          _ReportCard(
            title: 'Corridas (PDF)',
            subtitle: 'Relatório de corridas em formato PDF',
            icon: Icons.picture_as_pdf,
            color: Colors.red,
            onTap: () => _handleDownload(context, 'rides-pdf', 'Corridas (PDF)'),
          ),
        ],
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ReportCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: ElevatedButton(
          onPressed: onTap,
          child: const Text('Baixar'),
        ),
      ),
    );
  }
}