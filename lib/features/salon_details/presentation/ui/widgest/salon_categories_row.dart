import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SalonCategoriesRow extends StatelessWidget {
  final List<String> categories;

  const SalonCategoriesRow({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: categories.map((cat) {
        return Column(
          children: [
            Container(
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.spa, color: colorScheme.primary),
            ),
            SizedBox(height: 6.h),
            Text(
              cat,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
