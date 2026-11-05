import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'add_service_input_card.dart';

class AddServiceNameField extends StatelessWidget {
  final TextEditingController controller;

  const AddServiceNameField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF241816);

    return AddServiceInputCard(
      icon: Icons.edit_outlined,
      iconLabel: 'Name',
      topLabel: 'Service Name',
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: primaryTextColor,
        ),
        decoration: InputDecoration(
          hintText: 'Hair Styling & Blowout',
          hintStyle: TextStyle(
            fontSize: 15.5.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.hintTextWarm,
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

