import 'enums.dart';

class ExpenseModel {
  final int id;
  final int vehicleId;
  final DateTime date;
  final ExpenseType type;
  final double value;
  final String? notes;
  final DateTime? createdAt;

  ExpenseModel({
    required this.id,
    required this.vehicleId,
    required this.date,
    required this.type,
    required this.value,
    this.notes,
    this.createdAt,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      vehicleId: json['vehicle_id'],
      date: DateTime.parse(json['date']),
      type: ExpenseType.fromJson(json['type']),
      value: (json['value'] as num).toDouble(),
      notes: json['notes'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicle_id': vehicleId,
      'date': date.toIso8601String(),
      'type': type.toJson(),
      'value': value,
      'notes': notes,
    };
  }
}