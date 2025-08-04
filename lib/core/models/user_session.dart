class UserSession {
  final String token;
  final String userLogged;
  final String companyName;
  final int companyId;
  final int employeeIdDigits;
  final int employeeId;
  final String rateSettings;
  final List<String> holidays;
  final List<int> workDays;

  UserSession({
    required this.token,
    required this.userLogged,
    required this.companyName,
    required this.companyId,
    required this.employeeIdDigits,
    required this.employeeId,
    required this.rateSettings,
    required this.holidays,
    required this.workDays,
  });

  factory UserSession.fromJson(Map<String, dynamic> json) {
    return UserSession(
      token: json['token'] ?? '',
      userLogged: json['user_logged'] ?? '',
      companyName: json['company_name'] ?? '',
      companyId: json['company_id'] ?? 0,
      employeeIdDigits: json['employee_id_digits'] ?? 0,
      employeeId: json['employee_id'] ?? 0,
      rateSettings: json['rate_settings'] ?? '',
      holidays: List<String>.from(json['holidays'] ?? []),
      workDays: List<int>.from(json['workdays'] ?? []),
    );
  }

  //Empty
  UserSession.empty()
      : token = '',
        userLogged = '',
        companyName = '',
        companyId = 0,
        employeeIdDigits = 0,
        employeeId = 0,
        rateSettings = '',
        holidays = const [],
        workDays = const [];
}