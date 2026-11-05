enum FuelType {
  gasolina,
  etanol,
  flex,
  diesel,
  eletrico;

  String toJson() => name;

  static FuelType fromJson(String json) {
    return FuelType.values.firstWhere(
      (e) => e.name == json.toLowerCase(),
      orElse: () => FuelType.flex,
    );
  }
}

enum AppType {
  uber('Uber'),
  noventaENeve('99'),
  indrive('InDrive'),
  chofer('Chofer'),
  outros('Outros');

  final String label;
  const AppType(this.label);

  String toJson() => label;

  static AppType fromJson(String json) {
    return AppType.values.firstWhere(
      (e) => e.label.toLowerCase() == json.toLowerCase(),
      orElse: () => AppType.outros,
    );
  }
}

enum ExpenseType {
  combustivel,
  manutencao,
  lavagem,
  seguro,
  ipva,
  multa,
  outros;

  String toJson() => name;

  static ExpenseType fromJson(String json) {
    return ExpenseType.values.firstWhere(
      (e) => e.name == json.toLowerCase(),
      orElse: () => ExpenseType.outros,
    );
  }
}