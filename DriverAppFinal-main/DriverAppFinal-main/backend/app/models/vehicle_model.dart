import 'enums.dart';

class VehicleModel {
  final int id;
  final int userId;
  final String brand;
  final String model;
  final int year;
  final String plate;
  final FuelType fuelType;
  final double currentKm;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  VehicleModel({
    required this.id,
    required this.userId,
    required this.brand,
    required this.model,
    required this.year,
    required this.plate,
    required this.fuelType,
    this.currentKm = 0.0,
    this.createdAt,
    this.updatedAt,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'],
      userId: json['user_id'],
      brand: json['brand'],
      model: json['model'],
      year: json['year'],
      plate: json['plate'],
      fuelType: FuelType.fromJson(json['fuel_type']),
      currentKm: (json['current_km'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'brand': brand,
      'model': model,
      'year': year,
      'plate': plate,
      'fuel_type': fuelType.toJson(),
      'current_km': currentKm,
    };
  }
}