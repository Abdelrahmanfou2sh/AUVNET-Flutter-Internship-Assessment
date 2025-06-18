import 'package:auvnet/core/constants/app_assets.dart';
import 'package:auvnet/core/theme/app_colors.dart';
import 'package:auvnet/core/theme/app_text_styles.dart';
import 'package:auvnet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auvnet/features/auth/presentation/bloc/auth_events.dart';
import 'package:auvnet/features/auth/presentation/bloc/auth_states.dart';
import 'package:auvnet/features/auth/presentation/screens/utils/input_validators.dart';
import 'package:auvnet/features/auth/presentation/screens/widgets/build_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.go('/home'); // Navigate to home screen on successful login
        } else if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 61.h),
                    Image.asset(AppAssets.logo),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          buildTextField(
                            controller: _emailController,
                            hint: 'mail',
                            prefix: Icons.email,
                            validator: InputValidators.validateEmail,
                          ),
                          SizedBox(height: 18.h),
                          buildTextField(
                            controller: _passwordController,
                            hint: 'password',
                            prefix: Icons.lock,
                            validator: InputValidators.validatePassword,
                            obscure: _obscurePassword ? true : false,
                            suffix: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 26.h),
                          ElevatedButton(
                            onPressed: state is AuthLoading
                                ? null
                                : () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      context.read<AuthBloc>().add(
                                        SignInEvent(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        ),
                                      );
                                      context.go('/home');
                                    }
                                  },
                            child: state is AuthLoading
                                ? SizedBox(
                                    width: 24.h,
                                    height: 24.h,
                                    child: const CircularProgressIndicator(),
                                  )
                                : Text('Log in'),
                          ),
                          SizedBox(height: 32.h),
                          InkWell(
                            onTap: () {
                              GoRouter.of(context).go('/signup');
                            },
                            child: Text(
                              'Create an account',
                              style: AppTextStyles.dmSansBold14.copyWith(
                                color: AppColors.blueColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
