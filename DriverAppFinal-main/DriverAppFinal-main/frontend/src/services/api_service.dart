import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'https://sua-api.com/api'; // Substitua pelo seu URL base

  static Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // --- Auth & Users ---
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (res.statusCode >= 400) throw jsonDecode(res.body)['detail'] ?? 'Erro no login';
    return jsonDecode(res.body);
  }

  static Future<void> register(Map<String, dynamic> data) async {
    final res = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (res.statusCode >= 400) throw jsonDecode(res.body)['detail'] ?? 'Erro no registo';
  }

  static Future<void> resetPassword(Map<String, dynamic> data) async {
    final res = await http.post(
      Uri.parse('$baseUrl/auth/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (res.statusCode >= 400) throw jsonDecode(res.body)['detail'] ?? 'Erro ao redefinir';
  }

  static Future<Map<String, dynamic>> getMe(String? token) async {
    final headers = await _getHeaders();
    final res = await http.get(Uri.parse('$baseUrl/users/me'), headers: headers);
    if (res.statusCode >= 400) throw Exception('Falha ao obter dados do utilizador');
    return jsonDecode(res.body);
  }

  static Future<void> updateMe(Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    final res = await http.put(Uri.parse('$baseUrl/users/me'), headers: headers, body: jsonEncode(data));
    if (res.statusCode >= 400) throw Exception('Erro ao atualizar perfil');
  }

  // --- Vehicles ---
  static Future<List<dynamic>> listVehicles() async {
    final headers = await _getHeaders();
    final res = await http.get(Uri.parse('$baseUrl/vehicles'), headers: headers);
    return jsonDecode(res.body);
  }

  static Future<void> createVehicle(Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    await http.post(Uri.parse('$baseUrl/vehicles'), headers: headers, body: jsonEncode(data));
  }

  static Future<void> updateVehicle(int id, Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    await http.put(Uri.parse('$baseUrl/vehicles/$id'), headers: headers, body: jsonEncode(data));
  }

  static Future<void> deleteVehicle(int id) async {
    final headers = await _getHeaders();
    await http.delete(Uri.parse('$baseUrl/vehicles/$id'), headers: headers);
  }

  // --- Rides ---
  static Future<List<dynamic>> listRidesByVehicle(dynamic vehicleId) async {
    final headers = await _getHeaders();
    final res = await http.get(Uri.parse('$baseUrl/rides?vehicle_id=$vehicleId'), headers: headers);
    return jsonDecode(res.body);
  }

  static Future<void> createRide(Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    await http.post(Uri.parse('$baseUrl/rides'), headers: headers, body: jsonEncode(data));
  }

  static Future<void> updateRide(int id, Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    await http.put(Uri.parse('$baseUrl/rides/$id'), headers: headers, body: jsonEncode(data));
  }

  static Future<void> deleteRide(int id) async {
    final headers = await _getHeaders();
    await http.delete(Uri.parse('$baseUrl/rides/$id'), headers: headers);
  }

  // --- Expenses ---
  static Future<List<dynamic>> listExpensesByVehicle(dynamic vehicleId) async {
    final headers = await _getHeaders();
    final res = await http.get(Uri.parse('$baseUrl/expenses?vehicle_id=$vehicleId'), headers: headers);
    return jsonDecode(res.body);
  }

  static Future<void> createExpense(Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    await http.post(Uri.parse('$baseUrl/expenses'), headers: headers, body: jsonEncode(data));
  }

  static Future<void> updateExpense(int id, Map<String, dynamic> data) async {
    final headers = await _getHeaders();
    await http.put(Uri.parse('$baseUrl/expenses/$id'), headers: headers, body: jsonEncode(data));
  }

  static Future<void> deleteExpense(int id) async {
    final headers = await _getHeaders();
    await http.delete(Uri.parse('$baseUrl/expenses/$id'), headers: headers);
  }

  // --- Reports ---
  static Future<Uint8List> downloadReport(String endpoint) async {
    final headers = await _getHeaders();
    final res = await http.get(Uri.parse('$baseUrl/reports/$endpoint'), headers: headers);
    return res.bodyBytes;
  }
}




static Future<Uint8List> downloadReport(String endpoint) async {
  final headers = await _getHeaders();
  final res = await http.get(Uri.parse('$baseUrl/reports/$endpoint'), headers: headers);
  return res.bodyBytes;
}