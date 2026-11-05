import 'enums.dart';

// --- AUTENTICAÇÃO E UTILIZADORES ---

class TokenDto {
  final String accessToken;
  final String refreshToken;
  final String tokenType;

  TokenDto({
    required this.accessToken,
    required this.refreshToken,
    this.tokenType = 'bearer',
  });

  factory TokenDto.fromJson(Map<String, dynamic> json) {
    return TokenDto(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      tokenType: json['token_type'] ?? 'bearer',
    );
  }
}

class LoginRequestDto {
  final String email;
  final String password;

  LoginRequestDto({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

class UserCreateDto {
  final String name;
  final String email;
  final String password;
  final String? phone;

  UserCreateDto({
    required this.name,
    required this.email,
    required this.password,
    this.phone,
  }) {
    if (password.length < 6) {
      throw Exception('Senha deve ter pelo menos 6 caracteres');
    }
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      };
}

class UserUpdateDto {
  final String? name;
  final String? phone;

  UserUpdateDto({this.name, this.phone});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (name != null) map['name'] = name;
    if (phone != null) map['phone'] = phone;
    return map;
  }
}

// --- VEÍCULOS ---

class VehicleCreateDto {
  final String brand;
  final String model;
  final int year;
  final String plate;
  final FuelType fuelType;
  final double currentKm;

  VehicleCreateDto({
    required this.brand,
    required this.model,
    required this.year,
    required this.plate,
    required this.fuelType,
    this.currentKm = 0.0,
  });

  Map<String, dynamic> toJson() => {
        'brand': brand,
        'model': model,
        'year': year,
        'plate': plate,
        'fuel_type': fuelType.toJson(),
        'current_km': currentKm,
      };
}

class VehicleUpdateDto {
  final String? brand;
  final String? model;
  final int? year;
  final String? plate;
  final FuelType? fuelType;
  final double? currentKm;

  VehicleUpdateDto({
    this.brand,
    this.model,
    this.year,
    this.plate,
    this.fuelType,
    this.currentKm,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (brand != null) map['brand'] = brand;
    if (model != null) map['model'] = model;
    if (year != null) map['year'] = year;
    if (plate != null) map['plate'] = plate;
    if (fuelType != null) map['fuel_type'] = fuelType!.toJson();
    if (currentKm != null) map['current_km'] = currentKm;
    return map;
  }
}

// --- CORRIDAS / VIAGENS ---

class RideCreateDto {
  final int vehicleId;
  final double value;
  final double distanceKm;
  final AppType appUsed;
  final String? notes;

  RideCreateDto({
    required this.vehicleId,
    required this.value,
    required this.distanceKm,
    required this.appUsed,
    this.notes,
  }) {
    if (value < 0) {
      throw Exception('Valor não pode ser negativo');
    }
    if (distanceKm <= 0) {
      throw Exception('Distância deve ser maior que zero');
    }
  }

  Map<String, dynamic> toJson() => {
        'vehicle_id': vehicleId,
        'value': value,
        'distance_km': distanceKm,
        'app_used': appUsed.toJson(),
        'notes': notes,
      };
}

class RideUpdateDto {
  final DateTime? date;
  final String? origin;
  final String? destination;
  final double? value;
  final double? distanceKm;
  final AppType? appUsed;
  final String? notes;

  RideUpdateDto({
    this.date,
    this.origin,
    this.destination,
    this.value,
    this.distanceKm,
    this.appUsed,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (date != null) map['date'] = date!.toIso8601String();
    if (origin != null) map['origin'] = origin;
    if (destination != null) map['destination'] = destination;
    if (value != null) map['value'] = value;
    if (distanceKm != null) map['distance_km'] = distanceKm;
    if (appUsed != null) map['app_used'] = appUsed!.toJson();
    if (notes != null) map['notes'] = notes;
    return map;
  }
}

// --- DESPESAS ---

class ExpenseCreateDto {
  final int vehicleId;
  final DateTime date;
  final ExpenseType type;
  final double value;
  final String? notes;

  ExpenseCreateDto({
    required this.vehicleId,
    required this.date,
    required this.type,
    required this.value,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
        'vehicle_id': vehicleId,
        'date': date.toIso8601String(),
        'type': type.toJson(),
        'value': value,
        'notes': notes,
      };
}

class ExpenseUpdateDto {
  final DateTime? date;
  final ExpenseType? type;
  final double? value;
  final String? notes;

  ExpenseUpdateDto({this.date, this.type, this.value, this.notes});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (date != null) map['date'] = date!.toIso8601String();
    if (type != null) map['type'] = type!.toJson();
    if (value != null) map['value'] = value;
    if (notes != null) map['notes'] = notes;
    return map;
  }
}

// --- OBD2 ---

class OBD2RecordCreateDto {
  final int vehicleId;
  final double? rpm;
  final double? speedKmh;
  final double? engineTempC;
  final double? instantConsumption;
  final double? odometerKm;
  final double? engineRuntimeS;

  OBD2RecordCreateDto({
    required this.vehicleId,
    this.rpm,
    this.speedKmh,
    this.engineTempC,
    this.instantConsumption,
    this.odometerKm,
    this.engineRuntimeS,
  });

  Map<String, dynamic> toJson() => {
        'vehicle_id': vehicleId,
        'rpm': rpm,
        'speed_kmh': speedKmh,
        'engine_temp_c': engineTempC,
        'instant_consumption': instantConsumption,
        'odometer_km': odometerKm,
        'engine_runtime_s': engineRuntimeS,
      };
}