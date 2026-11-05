import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'add_service_input_card.dart';

class AddServiceDescriptionField extends StatelessWidget {
  final TextEditingController controller;

  const AddServiceDescriptionField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF241816);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            fontSize: 18.5.sp,
            fontWeight: FontWeight.w800,
            color: primaryTextColor,
          ),
        ),
        SizedBox(height: 8.h),
        AddServiceInputCard(
          icon: Icons.article_outlined,
          iconLabel: 'Note',
          child: TextField(
            controller: controller,
            maxLines: 2,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: primaryTextColor,
            ),
            decoration: InputDecoration(
              hintText: 'Full wash, styling, and finish.',
              hintStyle: TextStyle(
                fontSize: 14.5.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.hintTextWarm,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}

