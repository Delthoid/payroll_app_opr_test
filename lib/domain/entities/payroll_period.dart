class PayrollPeriod {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? createdAt;

  PayrollPeriod({
    required this.id,
    required this.startDate,
    required this.endDate,
    this.createdAt,
  });

  @override
  String toString() {
    return 'PayrollPeriod(startDate: $startDate, endDate: $endDate, createdAt: $createdAt)';
  }

  static PayrollPeriod empty() {
    return PayrollPeriod(
      id: '',
      startDate: DateTime(1970, 1, 1),
      endDate: DateTime(1970, 1, 1),
      createdAt: null,
    );
  }
}