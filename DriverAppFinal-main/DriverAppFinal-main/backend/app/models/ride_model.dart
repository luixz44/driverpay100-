import 'enums.dart';

class RideModel {
  final int id;
  final int vehicleId;
  final double value;
  final double distanceKm;
  final AppType appUsed;
  final String? notes;
  final DateTime? createdAt;

  RideModel({
    required this.id,
    required this.vehicleId,
    required this.value,
    required this.distanceKm,
    required this.appUsed,
    this.notes,
    this.createdAt,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['id'],
      vehicleId: json['vehicle_id'],
      value: (json['value'] as num).toDouble(),
      distanceKm: (json['distance_km'] as num).toDouble(),
      appUsed: AppType.fromJson(json['app_used']),
      notes: json['notes'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicle_id': vehicleId,
      'value': value,
      'distance_km': distanceKm,
      'app_used': appUsed.toJson(),
      'notes': notes,
    };
  }
}