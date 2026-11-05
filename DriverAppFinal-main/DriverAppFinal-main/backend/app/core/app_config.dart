class AppConfig {
  // URL base para o emulador Android (10.0.2.2 mapeia para o localhost do computador)
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  // Chaves de armazenamento seguro no dispositivo
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';

  // Tempos de expiração por defeito
  static const int accessTokenExpireMinutes = 30; //[cite: 11, 14]
  static const int refreshTokenExpireDays = 7; //[cite: 11, 14]
}