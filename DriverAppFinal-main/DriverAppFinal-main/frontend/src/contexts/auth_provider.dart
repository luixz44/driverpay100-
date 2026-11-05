import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../services/api_service.dart'; // A sua camada de serviço API

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  bool _loading = true;

  UserModel? get user => _user;
  bool get loading => _loading;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _checkInitialAuth();
  }

  /// Verifica se existe um token guardado ao iniciar a aplicação[cite: 18]
  Future<void> _checkInitialAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token != null && token.isNotEmpty) {
      try {
        // Equivale ao usersApi.getMe()[cite: 18]
        final userData = await ApiService.getMe(token);
        _user = UserModel.fromJson(userData);
      } catch (e) {
        // Se o token for inválido, limpa o armazenamento[cite: 18]
        await prefs.clear();
        _user = null;
      }
    }

    _loading = false;
    notifyListeners();
  }

  /// Efetua o login do utilizador[cite: 18]
  Future<void> login(String email, String password) async {
    final response = await ApiService.login(email, password);
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('access_token', response['access_token']);
    await prefs.setString('refresh_token', response['refresh_token']);

    final userData = await ApiService.getMe(response['access_token']);
    _user = UserModel.fromJson(userData);

    notifyListeners();
  }

  /// Encerra a sessão do utilizador[cite: 18]
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _user = null;
    notifyListeners();
  }
}