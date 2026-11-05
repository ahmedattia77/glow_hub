import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'add_service_input_card.dart';

class AddServicePricingFields extends StatelessWidget {
  final TextEditingController priceController;
  final TextEditingController durationController;

  const AddServicePricingFields({
    super.key,
    required this.priceController,
    required this.durationController,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF241816);

    return Row(
      children: [
        // Price Field
        Expanded(
          child: AddServiceInputCard(
            icon: Icons.payments_outlined,
            iconLabel: 'Cash',
            topLabel: 'Price (EGP)',
            child: TextField(
              controller: priceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: primaryTextColor,
              ),
              decoration: InputDecoration(
                hintText: '350 EGP',
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
          ),
        ),

        SizedBox(width: 12.w),

        // Duration Field
        Expanded(
          child: AddServiceInputCard(
            icon: Icons.access_time_rounded,
            iconLabel: 'Clock',
            topLabel: 'Duration (Min)',
            child: TextField(
              controller: durationController,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: primaryTextColor,
              ),
              decoration: InputDecoration(
                hintText: '45 Mins',
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
          ),
        ),
      ],
    );
  }
}

