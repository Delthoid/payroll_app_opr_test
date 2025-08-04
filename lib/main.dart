import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll_app_opr_test/core/bloc_observer.dart';
import 'package:payroll_app_opr_test/di.dart';
import 'package:payroll_app_opr_test/presentation/auth/bloc/auth_bloc.dart';
import 'package:payroll_app_opr_test/presentation/home/cubit/home_page_cubit.dart';
import 'package:payroll_app_opr_test/router/router.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  setup();

  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => HomePageCubit()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Payroll App',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent)),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
