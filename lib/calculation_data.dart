class CalculationData {
  String name;
  String value;

  CalculationData({required this.name, required this.value});

  factory CalculationData.fromJson(Map<String, dynamic> json) {
    return CalculationData(
      name: json['name'] ?? '',
      value: json['value'] ?? '',
    );
  }
}
