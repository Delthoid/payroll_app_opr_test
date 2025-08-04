import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:payroll_app_opr_test/core/utils/validators.dart';
import 'package:payroll_app_opr_test/core/widgets/error_container.dart';
import 'package:payroll_app_opr_test/data/services/session_service.dart';
import 'package:payroll_app_opr_test/presentation/auth/bloc/auth_bloc.dart';
import 'package:payroll_app_opr_test/presentation/auth/bloc/auth_bloc_extension.dart';
import 'package:payroll_app_opr_test/router/router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _showPassword = false;

  @override
  void initState() {
    final getSession = GetIt.instance<SessionService>();
    getSession.getCurrentSession().then((session) {
      if (session != null) {
        context.pushReplacementNamed(RouteNames.home);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.pushReplacementNamed(RouteNames.home);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12,
            children: [
              Text('Payroll App', style: theme.textTheme.displaySmall, textAlign: TextAlign.center),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if (state is AuthFailure) ...[
                        ErrorContainer(errorMessage: state.error),
                        const SizedBox(height: 12),
                      ],

                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => Validators.validateEmail(value),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty ? 'Please enter your password' : null,
                        obscureText: !_showPassword,
                      ),
                      SizedBox(height: 12),

                      if (state.isLoading) ...[
                        CircularProgressIndicator(),
                      ] else ...[
                        FilledButton(
                          onPressed: state.isLoading
                              ? null
                              : () {
                                  if (formKey.currentState?.validate() ?? false) {
                                    context.read<AuthBloc>().add(
                                      AuthLoginRequest(email: emailController.text, password: passwordController.text),
                                    );
                                  }
                                },
                          child: Text('Login'),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
