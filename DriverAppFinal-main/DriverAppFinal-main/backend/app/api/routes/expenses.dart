import 'api_client.dart';
import 'api_endpoints.dart';

class ExpenseService {
  Future<List<dynamic>> listExpensesByVehicle(int vehicleId) async {
    return await ApiClient.get(ApiEndpoints.expensesByVehicle(vehicleId));
  }

  Future<Map<String, dynamic>> createExpense(Map<String, dynamic> data) async {
    return await ApiClient.post(ApiEndpoints.expenses, data);
  }

  Future<Map<String, dynamic>> getExpense(int id) async {
    return await ApiClient.get(ApiEndpoints.expenseById(id));
  }

  Future<Map<String, dynamic>> updateExpense(int id, Map<String, dynamic> data) async {
    return await ApiClient.put(ApiEndpoints.expenseById(id), data);
  }

  Future<void> deleteExpense(int id) async {
    await ApiClient.delete(ApiEndpoints.expenseById(id));
  }
}