class OBD2RecordModel {
  final int id;
  final int vehicleId;
  final DateTime? timestamp;
  final double? rpm;
  final double? speedKmh;
  final double? engineTempC;
  final double? instantConsumption;
  final double? odometerKm;
  final double? engineRuntimeS;

  OBD2RecordModel({
    required this.id,
    required this.vehicleId,
    this.timestamp,
    this.rpm,
    this.speedKmh,
    this.engineTempC,
    this.instantConsumption,
    this.odometerKm,
    this.engineRuntimeS,
  });

  factory OBD2RecordModel.fromJson(Map<String, dynamic> json) {
    return OBD2RecordModel(
      id: json['id'],
      vehicleId: json['vehicle_id'],
      timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
      rpm: (json['rpm'] as num?)?.toDouble(),
      speedKmh: (json['speed_kmh'] as num?)?.toDouble(),
      engineTempC: (json['engine_temp_c'] as num?)?.toDouble(),
      instantConsumption: (json['instant_consumption'] as num?)?.toDouble(),
      odometerKm: (json['odometer_km'] as num?)?.toDouble(),
      engineRuntimeS: (json['engine_runtime_s'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicle_id': vehicleId,
      'rpm': rpm,
      'speed_kmh': speedKmh,
      'engine_temp_c': engineTempC,
      'instant_consumption': instantConsumption,
      'odometer_km': odometerKm,
      'engine_runtime_s': engineRuntimeS,
    };
  }
}