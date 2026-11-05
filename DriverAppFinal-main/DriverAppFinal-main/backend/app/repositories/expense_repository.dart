import '../api/api_client.dart';
import '../api/api_endpoints.dart';
import '../models/expense_model.dart';

class ExpenseRepository {
  Future<List<ExpenseModel>> getAllByVehicle(int vehicleId) async {
    final List<dynamic> data = await ApiClient.get(ApiEndpoints.expensesByVehicle(vehicleId));
    return data.map((json) => ExpenseModel.fromJson(json)).toList();
  }

  Future<ExpenseModel> getById(int id) async {
    final data = await ApiClient.get(ApiEndpoints.expenseById(id));
    return ExpenseModel.fromJson(data);
  }

  Future<ExpenseModel> create(Map<String, dynamic> expenseData) async {
    final data = await ApiClient.post(ApiEndpoints.expenses, expenseData);
    return ExpenseModel.fromJson(data);
  }

  Future<ExpenseModel> update(int id, Map<String, dynamic> expenseData) async {
    final data = await ApiClient.put(ApiEndpoints.expenseById(id), expenseData);
    return ExpenseModel.fromJson(data);
  }

  Future<void> delete(int id) async {
    await ApiClient.delete(ApiEndpoints.expenseById(id));
  }
}