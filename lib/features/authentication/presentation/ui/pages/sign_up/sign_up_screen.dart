import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/common_widgets/custom_app_button.dart';
import 'package:glow_hub/core/routing/routes.dart';
import 'package:glow_hub/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:glow_hub/features/authentication/presentation/ui/widgest/custom_text_field.dart';
import 'package:glow_hub/features/authentication/presentation/ui/widgest/user_role.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _salonNameController = TextEditingController();
  final _salonCategoryController = TextEditingController();

  UserRole _selectedRole = UserRole.client; // default value
  bool _isPasswordObscure = true;
  bool _acceptTerms = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _salonNameController.dispose();
    _salonCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: theme.colorScheme.onSurface),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.initialRoute,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Register",
                      style: theme.textTheme.displayLarge?.copyWith(
                        fontSize: 28.sp,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    RoleSelectorWidget(
                      selectedRole: _selectedRole,
                      onRoleSelected: (role) {
                        setState(() {
                          _selectedRole = role;
                        });
                      },
                    ),
                    SizedBox(height: 20.h),

                    CustomTextField(
                      label: "First Name",
                      hintText: "First Name",
                      controller: _firstNameController,
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? "First name is required"
                          : null,
                    ),
                    SizedBox(height: 16.h),

                    CustomTextField(
                      label: "Last Name",
                      hintText: "Last Name",
                      controller: _lastNameController,
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? "Last name is required"
                          : null,
                    ),
                    SizedBox(height: 16.h),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _selectedRole == UserRole.admin
                          ? Column(
                              key: const ValueKey('salon_fields'),
                              children: [
                                CustomTextField(
                                  label: "Salon Name",
                                  hintText: "e.g., Faten Beauty Center",
                                  controller: _salonNameController,
                                  validator: (value) {
                                    if (_selectedRole == UserRole.admin &&
                                        (value == null ||
                                            value.trim().isEmpty)) {
                                      return "Salon name is required";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16.h),
                                CustomTextField(
                                  label: "Salon Category",
                                  hintText: "e.g., Hair, Makeup & Spa",
                                  controller: _salonCategoryController,
                                  validator: (value) {
                                    if (_selectedRole == UserRole.admin &&
                                        (value == null ||
                                            value.trim().isEmpty)) {
                                      return "Salon category is required";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16.h),
                              ],
                            )
                          : const SizedBox.shrink(
                              key: ValueKey('empty_fields'),
                            ),
                    ),

                    CustomTextField(
                      label: "Email",
                      hintText: "Email address",
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Email address is required";
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return "Enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),

                    CustomTextField(
                      label: "Password",
                      hintText: "Create password",
                      controller: _passwordController,
                      isPassword: _isPasswordObscure,
                      validator: (value) => value == null || value.length < 6
                          ? "Password must be at least 6 characters"
                          : null,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20.sp,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordObscure = !_isPasswordObscure;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16.h),

                    Row(
                      children: [
                        SizedBox(
                          height: 24.h,
                          width: 24.w,
                          child: Checkbox(
                            value: _acceptTerms,
                            activeColor: theme.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            onChanged: (val) {
                              setState(() {
                                _acceptTerms = val ?? false;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            "I agree to the Terms of Service and Privacy Policy.",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 11.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    CustomAppButton(
                      text: "Register",
                      isLoading: isLoading,
                      onPressed: () {
                        if (!_acceptTerms) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Please accept the terms and conditions",
                              ),
                            ),
                          );
                          return;
                        }

                        if (_formKey.currentState!.validate()) {
                          String roleString = (_selectedRole == UserRole.admin)
                              ? 'admin'
                              : 'customer';

                          context.read<AuthCubit>().register(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            role: roleString,
                            salonName: _selectedRole == UserRole.admin
                                ? _salonNameController.text
                                : null,
                            salonCategory: _selectedRole == UserRole.admin
                                ? _salonCategoryController.text
                                : null,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 16.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.login);
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
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
