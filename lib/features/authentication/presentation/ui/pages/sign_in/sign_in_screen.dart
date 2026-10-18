import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/common_widgets/custom_app_button.dart';
import 'package:glow_hub/core/routing/routes.dart';
import 'package:glow_hub/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:glow_hub/features/authentication/presentation/ui/widgest/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordObscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is AuthSuccess) {
              if (state.role == 'admin') {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.adminHomeScreen,
                  (route) => false,
                );
              } else {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.clientHomeScreen,
                  (route) => false,
                );
              }
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30.h),
                    Text(
                      "Sign In",
                      style: theme.textTheme.displayLarge?.copyWith(
                        fontSize: 28.sp,
                      ),
                    ),
                    SizedBox(height: 40.h),

                    CustomTextField(
                      label: "Email",
                      hintText: "Email",
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? "Please enter your email"
                          : null,
                    ),
                    SizedBox(height: 20.h),

                    CustomTextField(
                      label: "Password",
                      hintText: "Password",
                      controller: _passwordController,
                      isPassword: _isPasswordObscure,
                      validator: (value) => value == null || value.isEmpty
                          ? "Please enter your password"
                          : null,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20.sp,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordObscure = !_isPasswordObscure;
                          });
                        },
                      ),
                    ),

                    SizedBox(height: 28.h),

                    CustomAppButton(
                      text: "Sign In",
                      isLoading: isLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().signIn(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 20.h),

                    OutlinedButton.icon(
                      onPressed: isLoading ? null : () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        side: BorderSide(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.2,
                          ),
                        ),
                      ),
                      icon: Icon(Icons.g_mobiledata, size: 28.sp),
                      label: Text(
                        "Sign in with Google",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot or Reset Password?",
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.signUp);
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
