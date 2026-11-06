import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/routing/routes.dart';
import 'package:glow_hub/features/home/data/model/salone_model.dart';

class SalonItemCard extends StatelessWidget {
  final SalonModel salon;

  const SalonItemCard({super.key, required this.salon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () {
        print("salonId" + salon.salonId);
        Navigator.pushNamed(
          context,
          Routes.salonDetailsScreen,
          arguments: salon.salonId,
        );
      },
      child: Container(
        width: 180.w,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  height: 110.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: salon.imageUrl.isNotEmpty
                      ? ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: Image.network(
                            salon.imageUrl,
                            fit: BoxFit.fill,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                          ),
                        )
                      : const Center(
                          child: Icon(
                            Icons.storefront_rounded,
                            size: 35,
                            color: Colors.grey,
                          ),
                        ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    height: 28.h,
                    width: 28.w,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.favorite_rounded,
                        color: colorScheme.primary,
                        size: 16,
                      ),
                      onPressed: () {
                        // Add to favorites logic
                      },
                    ),
                  ),
                ),
                // Rating Badge (Bottom Right over image)
                Positioned(
                  bottom: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 12),
                        const SizedBox(width: 3),
                        Text(
                          '${salon.rating}',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Details Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    salon.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 3.h),

                  // Rating Stars
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) =>
                            Icon(Icons.star, color: Colors.amber, size: 11.sp),
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        '${salon.rating}',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  // Services Row
                  Row(
                    children: [
                      Icon(
                        Icons.spa_outlined,
                        size: 12,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          'Services',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(fontSize: 12.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  Wrap(
                    spacing: 3,
                    runSpacing: 3,
                    children: salon.categories.take(3).map((category) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          category,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(fontSize: 12.sp),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
