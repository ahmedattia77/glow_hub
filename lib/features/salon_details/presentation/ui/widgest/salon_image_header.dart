import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SalonImageHeader extends StatelessWidget {
  final String imageUrl;

  const SalonImageHeader({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 280.h,
      width: double.infinity,
      child: Stack(
        children: [
          imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 280.h,
                )
              : Image.network(
                  'https://images.unsplash.com/photo-1560066984-138dadb4c035',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 280.h,
                ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: colorScheme.surface,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: colorScheme.onSurface,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: colorScheme.surface,
                    child: IconButton(
                      icon: Icon(
                        Icons.grid_view_rounded,
                        size: 18,
                        color: colorScheme.onSurface,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
