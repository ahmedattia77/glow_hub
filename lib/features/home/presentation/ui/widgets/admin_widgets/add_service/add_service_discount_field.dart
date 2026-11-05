import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'add_service_input_card.dart';

class AddServiceDiscountField extends StatelessWidget {
  final TextEditingController controller;

  const AddServiceDiscountField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF241816);

    return AddServiceInputCard(
      icon: Icons.local_offer_outlined,
      iconLabel: 'Tag',
      topLabel: 'Discount (EGP)',
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
        ),
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: primaryTextColor,
        ),
        decoration: InputDecoration(
          hintText: '50 EGP (Optional)',
          hintStyle: TextStyle(
            fontSize: 15.sp,
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

