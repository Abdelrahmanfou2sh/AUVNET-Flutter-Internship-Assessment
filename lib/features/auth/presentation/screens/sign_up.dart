import 'package:auvnet/core/constants/app_assets.dart';
import 'package:auvnet/core/theme/app_colors.dart';
import 'package:auvnet/core/theme/app_text_styles.dart';
import 'package:auvnet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auvnet/features/auth/presentation/bloc/auth_events.dart';
import 'package:auvnet/features/auth/presentation/bloc/auth_states.dart';
import 'package:auvnet/features/auth/presentation/screens/utils/input_validators.dart';
import 'package:auvnet/features/auth/presentation/screens/widgets/build_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.go('/home'); // Navigate to home screen on successful sign up
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
                          SizedBox(height: 7.h),
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
                          SizedBox(height: 7.h),
                          buildTextField(
                            controller: _confirmPasswordController,
                            hint: 'confirm password',
                            prefix: Icons.lock,
                            validator: (value) =>
                                InputValidators.validateConfirmPassword(
                                  value,
                                  _passwordController.text,
                                ),
                            obscure: _obscureConfirmPassword ? true : false,
                            suffix: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
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
                                        SignUpEvent(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        ),
                                      );
                                      context.go('/home');
                                    }
                                  },
                            child: state is AuthLoading
                                ? SizedBox(
                                    width: 24.w,
                                    height: 24.h,
                                    child: CircularProgressIndicator(),
                                  )
                                : Text('Sign Up'),
                          ),
                          SizedBox(height: 32.h),
                          RichText(
                            text: TextSpan(
                              text: 'Already have an account? ',
                              style: AppTextStyles.dmSansMedium14,
                              children: [
                                TextSpan(
                                  text: 'Log in',
                                  style: AppTextStyles.dmSansBold14.copyWith(
                                    color: AppColors.blueColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.go('/login');
                                    },
                                ),
                              ],
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
