import 'package:payroll_app_opr_test/domain/entities/payroll_period.dart';

class PayrollPeriodDto extends PayrollPeriod {
  PayrollPeriodDto({
    required super.id,
    required super.remarks,
    required super.isPaid,
    required super.startDate,
    required super.endDate,
    super.createdAt,
  });

  factory PayrollPeriodDto.fromJson(Map<String, dynamic> json) {
    return PayrollPeriodDto(
      id: json['id']?.toString() ?? '',
      remarks: json['remarks'] ?? '',
      isPaid: json['is_paid'] == 0 ? false : true,
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'remarks': remarks,
      'is_paid': isPaid,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toJsonWithoutId() {
    return {
      'start_date': startDate.toIso8601String(),
      'remarks': remarks,
      'is_paid': isPaid,
      'end_date': endDate.toIso8601String(),
      'created_at': (createdAt ?? DateTime.now()).toIso8601String(),
    };
  }

  PayrollPeriod toEntity() {
    return PayrollPeriod(
      id: id,
      remarks: remarks,
      isPaid: isPaid,
      startDate: startDate,
      endDate: endDate,
      createdAt: createdAt,
    );
  }
}
