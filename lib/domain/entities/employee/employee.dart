import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String position;
  final double salary;

  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.position,
    required this.salary,
  });

  Employee copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? position,
    double? salary,
  }) {
    return Employee(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      position: position ?? this.position,
      salary: salary ?? this.salary,
    );
  }

  // empty
  static Employee empty() {
    return Employee(
      id: '',
      firstName: '',
      lastName: '',
      email: '',
      position: '',
      salary: 0.0,
    );
  }
  
  @override
  List<Object?> get props => [id, firstName, lastName, email, position, salary];
}