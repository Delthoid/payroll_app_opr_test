class PayrollPeriod {
  final String id;
  final String remarks;
  final bool isPaid;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? createdAt;

  PayrollPeriod({
    required this.id,
    required this.remarks,
    this.isPaid = false,
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
      remarks: '',
      isPaid: false,
      startDate: DateTime(1970, 1, 1),
      endDate: DateTime(1970, 1, 1),
      createdAt: null,
    );
  }
}