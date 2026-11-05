import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static String? _authToken;

  static void setToken(String token) {
    _authToken = token;
  }

  static void clearToken() {
    _authToken = null;
  }

  static Map<String, String> _headers() {
    final headers = {'Content-Type': 'application/json'};
    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }
    return headers;
  }

  static Future<dynamic> get(String url) async {
    final response = await http.get(Uri.parse(url), headers: _headers());
    return _handleResponse(response);
  }

  static Future<dynamic> post(String url, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse(url),
      headers: _headers(),
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  static Future<dynamic> put(String url, Map<String, dynamic> body) async {
    final response = await http.put(
      Uri.parse(url),
      headers: _headers(),
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  static Future<dynamic> delete(String url) async {
    final response = await http.delete(Uri.parse(url), headers: _headers());
    return _handleResponse(response);
  }

  static Future<List<int>> getBytes(String url) async {
    final response = await http.get(Uri.parse(url), headers: _headers());
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Erro ao descarregar ficheiro (${response.statusCode})');
    }
  }

  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    } else {
      final errorData = response.body.isNotEmpty ? jsonDecode(response.body) : {};
      throw Exception(errorData['detail'] ?? 'Erro no servidor: ${response.statusCode}');
    }
  }
}