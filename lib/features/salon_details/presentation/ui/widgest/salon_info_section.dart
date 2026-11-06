import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SalonInfoSection extends StatelessWidget {
  final String name;
  final double rating;

  const SalonInfoSection({super.key, required this.name, required this.rating});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 4.w),
                Text(
                  '$rating · Salons & Rooms',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.bookmark_border_rounded,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
