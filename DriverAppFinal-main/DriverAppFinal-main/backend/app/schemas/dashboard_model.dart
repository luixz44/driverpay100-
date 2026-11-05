class MonthlyData {
  final String month;
  final double total;

  MonthlyData({required this.month, required this.total});

  factory MonthlyData.fromJson(Map<String, dynamic> json) {
    return MonthlyData(
      month: json['month'].toString(),
      total: (json['total'] as num).toDouble(),
    );
  }
}

class DashboardModel {
  final double totalRevenue;
  final double totalExpenses;
  final double netProfit;
  final double? avgConsumption;
  final double totalKm;
  final List<MonthlyData> monthlyRevenue;
  final List<MonthlyData> monthlyExpenses;
  final List<MonthlyData> monthlyProfit;
  final List<MonthlyData> monthlyKm;

  DashboardModel({
    required this.totalRevenue,
    required this.totalExpenses,
    required this.netProfit,
    this.avgConsumption,
    required this.totalKm,
    required this.monthlyRevenue,
    required this.monthlyExpenses,
    required this.monthlyProfit,
    required this.monthlyKm,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalRevenue: (json['total_revenue'] as num).toDouble(),
      totalExpenses: (json['total_expenses'] as num).toDouble(),
      netProfit: (json['net_profit'] as num).toDouble(),
      avgConsumption: (json['avg_consumption'] as num?)?.toDouble(),
      totalKm: (json['total_km'] as num).toDouble(),
      monthlyRevenue: (json['monthly_revenue'] as List)
          .map((item) => MonthlyData.fromJson(item))
          .toList(),
      monthlyExpenses: (json['monthly_expenses'] as List)
          .map((item) => MonthlyData.fromJson(item))
          .toList(),
      monthlyProfit: (json['monthly_profit'] as List)
          .map((item) => MonthlyData.fromJson(item))
          .toList(),
      monthlyKm: (json['monthly_km'] as List)
          .map((item) => MonthlyData.fromJson(item))
          .toList(),
    );
  }
}