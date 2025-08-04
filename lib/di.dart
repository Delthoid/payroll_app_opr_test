import 'package:get_it/get_it.dart';
import 'package:payroll_app_opr_test/data/repositories/auth_repository_impl.dart';
import 'package:payroll_app_opr_test/data/services/auth_service.dart';
import 'package:payroll_app_opr_test/domain/repositories/auth_repository.dart';
import 'package:payroll_app_opr_test/domain/use_cases/auth/auth_request.dart';

final getIt = GetIt.instance;

void setup() {
  // Use cases
  getIt.registerLazySingleton<AuthRequest>(() => AuthRequest(getIt<AuthRepository>()));

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt<AuthService>()));

  // Services
  getIt.registerLazySingleton<AuthService>(() => AuthService());
}