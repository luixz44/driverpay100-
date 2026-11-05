import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../api/api_client.dart';
import '../api/api_endpoints.dart';

class ReportService {
  /// Guarda os bytes descarregados no armazenamento do Android e abre o ficheiro
  Future<void> _downloadAndOpenFile(String endpoint, String fileName) async {
    final bytes = await ApiClient.getBytes(endpoint);

    // Obtém o diretório de documentos do Android
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');

    await file.writeAsBytes(bytes);

    // Abre o ficheiro PDF ou Excel com o leitor predefinido do sistema Android
    await OpenFile.open(file.path);
  }

  /// Descarrega e abre o relatório de corridas em Excel
  Future<void> exportRidesExcel() async {
    await _downloadAndOpenFile(ApiEndpoints.exportRidesExcel, 'corridas.xlsx');
  }

  /// Descarrega e abre o relatório de despesas em Excel[cite: 28]
  Future<void> exportExpensesExcel() async {
    await _downloadAndOpenFile(ApiEndpoints.exportExpensesExcel, 'despesas.xlsx');
  }

  /// Descarrega e abre o relatório de corridas em PDF[cite: 28]
  Future<void> exportRidesPdf() async {
    await _downloadAndOpenFile(ApiEndpoints.exportRidesPdf, 'corridas.pdf');
  }
}import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../api/api_client.dart';
import '../api/api_endpoints.dart';

class ReportService {
  /// Guarda os bytes descarregados no armazenamento do Android e abre o ficheiro
  Future<void> _downloadAndOpenFile(String endpoint, String fileName) async {
    final bytes = await ApiClient.getBytes(endpoint);

    // Obtém o diretório de documentos do Android
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');

    await file.writeAsBytes(bytes);

    // Abre o ficheiro PDF ou Excel com o leitor predefinido do sistema Android
    await OpenFile.open(file.path);
  }

  /// Descarrega e abre o relatório de corridas em Excel
  Future<void> exportRidesExcel() async {
    await _downloadAndOpenFile(ApiEndpoints.exportRidesExcel, 'corridas.xlsx');
  }

  /// Descarrega e abre o relatório de despesas em Excel[cite: 28]
  Future<void> exportExpensesExcel() async {
    await _downloadAndOpenFile(ApiEndpoints.exportExpensesExcel, 'despesas.xlsx');
  }

  /// Descarrega e abre o relatório de corridas em PDF[cite: 28]
  Future<void> exportRidesPdf() async {
    await _downloadAndOpenFile(ApiEndpoints.exportRidesPdf, 'corridas.pdf');
  }
}