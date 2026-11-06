import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/firebase_helper/firebase_initial.dart';
import 'package:glow_hub/core/routing/routes.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/client_widgets/profile_menu_item.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/header_curved_clipper.dart';
import 'package:glow_hub/features/profile/presentation/cubit/edit_profile_cubit.dart';

class ClientProfileScreen extends StatelessWidget {
  const ClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: BlocBuilder<EditProfileCubit, EditProfileState>(
        builder: (context, state) {
          if (state is EditProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EditProfileLoaded) {
            final user = state.user;

            return SingleChildScrollView(
              child: Column(
                children: [
                  CurvedProfileHeader(
                    gradient: isDarkMode
                        ? AppColors.buttonGradientDark
                        : AppColors.buttonGradientLight,
                    appBarWidget: Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'User Profile',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    floatingChild: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 45.r,
                            backgroundImage: user.profileImage.isNotEmpty
                                ? NetworkImage(user.profileImage)
                                : const NetworkImage(
                                    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500',
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 15.h),

                  Text(
                    user.fullName.isNotEmpty ? user.fullName : 'User Photo',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),

                  Text(
                    user.email,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.hintColor,
                    ),
                  ),

                  SizedBox(height: 25.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        ProfileMenuItem(
                          icon: Icons.person_outline_rounded,
                          title: 'Edit Profile',
                          onTap: () {
                            // Navigator.pushNamed(
                            //   context,
                            //   Routes.editProfileScreen,
                            //   arguments: user,
                            // );
                          },
                        ),
                        Divider(thickness: 0.3.h, indent: 16, endIndent: 16),
                        ProfileMenuItem(
                          icon: Icons.favorite_border_rounded,
                          title: 'Favorites',
                          onTap: () {},
                        ),
                        Divider(thickness: 0.3.h, indent: 16, endIndent: 16),
                        ProfileMenuItem(
                          icon: Icons.payment_rounded,
                          title: 'Payment Methods',
                          onTap: () {},
                        ),
                        Divider(thickness: 0.3.h, indent: 16, endIndent: 16),
                        ProfileMenuItem(
                          icon: Icons.info_outline_rounded,
                          title: 'About Us',
                          onTap: () => Navigator.pushNamed(
                            context,
                            Routes.aboutUsScreen,
                          ),
                        ),
                        Divider(thickness: 0.3.h, indent: 16, endIndent: 16),
                        ProfileMenuItem(
                          icon: Icons.logout_rounded,
                          title: 'Logout',
                          isLogout: true,
                          onTap: () {
                            FireBaseInitial.auth.signOut();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text('Failed to load profile data'));
        },
      ),
    );
  }
}

class CurvedProfileHeader extends StatelessWidget {
  final Widget? appBarWidget;
  final Widget floatingChild;
  final Gradient gradient;
  final double headerHeight;

  const CurvedProfileHeader({
    super.key,
    this.appBarWidget,
    required this.floatingChild,
    required this.gradient,
    this.headerHeight = 170,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: headerHeight + 50,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: HeaderCurvedClipper(),
              child: Container(
                height: headerHeight,
                decoration: BoxDecoration(gradient: gradient),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: appBarWidget ?? const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ),

          Positioned(bottom: 0, child: floatingChild),
        ],
      ),
    );
  }
}
