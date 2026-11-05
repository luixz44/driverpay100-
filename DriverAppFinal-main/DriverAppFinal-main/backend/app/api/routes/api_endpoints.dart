class ApiEndpoints {
  // Use '10.0.2.2:8000' para aceder ao servidor local a partir do emulador Android
  static const String baseUrl = 'http://10.0.2.2:8000';

  // Autenticação
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
  static const String refresh = '$baseUrl/auth/refresh';
  static const String recover = '$baseUrl/auth/recover';

  // Utilizadores
  static const String me = '$baseUrl/users/me';

  // Veículos
  static const String vehicles = '$baseUrl/vehicles';
  static String vehicleById(int id) => '$baseUrl/vehicles/$id';

  // Corridas / Viagens
  static const String rides = '$baseUrl/rides';
  static String ridesByVehicle(int vehicleId) => '$baseUrl/rides/vehicle/$vehicleId';
  static String rideById(int id) => '$baseUrl/rides/$id';

  // Despesas
  static const String expenses = '$baseUrl/expenses';
  static String expensesByVehicle(int vehicleId) => '$baseUrl/expenses/vehicle/$vehicleId';
  static String expenseById(int id) => '$baseUrl/expenses/$id';

  // OBD2
  static const String obd2Record = '$baseUrl/obd2/record';
  static String obd2History(int vehicleId, {int limit = 100}) => '$baseUrl/obd2/history/$vehicleId?limit=$limit';
  static const String obd2Status = '$baseUrl/obd2/status';

  // Painel de Controlo e Relatórios
  static String dashboard({int? year}) => year != null ? '$baseUrl/dashboard/?year=$year' : '$baseUrl/dashboard/';
  static const String exportRidesExcel = '$baseUrl/reports/rides/excel';
  static const String exportExpensesExcel = '$baseUrl/reports/expenses/excel';
  static const String exportRidesPdf = '$baseUrl/reports/rides/pdf';
}