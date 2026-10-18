import 'package:flutter/material.dart';
import 'package:glow_hub/core/common_widgets/gradient_main_button.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/authentication/data/repo/on_boarding_repo.dart';

class NextButtonRow extends StatelessWidget {
  final int currentIndex;
  final PageController pageController;
  final OnBoardingRepo pages;

  const NextButtonRow({
    super.key,
    required this.currentIndex,
    required this.pages,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: List.generate(
            pages.onBoardingPagesData.length,
            (index) => Container(
              margin: const EdgeInsets.only(right: 6),
              height: 8,
              width: currentIndex == index ? 24 : 8,
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? AppColors.primaryLight
                    : AppColors.surfaceLight,

                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),

        GradientMainButton(
          currentIndex: currentIndex,
          pages: pages,
          pageController: pageController,
        ),
      ],
    );
  }
}
