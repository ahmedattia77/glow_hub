import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glow_hub/features/home/presentation/ui/cubit/home_client_cubit.dart';
import 'header_curved_clipper.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurvedHomeHeader extends StatelessWidget {
  const CurvedHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final TextEditingController controller = TextEditingController();

    return ClipPath(
      clipper: HeaderCurvedClipper(),
      child: Container(
        padding: EdgeInsets.only(
          top: 50.h,
          left: 30.w,
          right: 30.w,
          bottom: 30.h,
        ),
        decoration: BoxDecoration(color: primaryColor),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.white70,
                          size: 18.sp,
                        ),
                        SizedBox(width: 4),
                        Text('Location', style: theme.textTheme.bodySmall),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white70,
                          size: 18,
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Cairo, Egypt',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                badges.Badge(
                  position: badges.BadgePosition.topEnd(top: 4, end: 4),
                  showBadge: true,
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.redAccent,
                    padding: EdgeInsets.all(4),
                  ),
                  badgeContent: Text('3', style: theme.textTheme.bodySmall),
                  child: IconButton(
                    icon: Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                      size: 22.sp,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            TextField(
              onSubmitted: (value) {
                context.read<HomeClientCubit>().fetchSalons(
                  searchQuery: value.trim().isEmpty ? null : value,
                );
                print("value in $value");
              },
              // controller: controller,
              decoration: InputDecoration(
                hintText: 'Search salons, services...',
                hintStyle: TextStyle(
                  color:
                      theme.textTheme.bodyMedium?.color?.withValues(
                        alpha: 0.6,
                      ) ??
                      Colors.grey,
                  fontSize: 14,
                ),
                prefixIcon: Icon(Icons.search_rounded, color: primaryColor),
                filled: true,
                fillColor: theme.colorScheme.surface,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
