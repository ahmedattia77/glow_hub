import 'package:flutter/material.dart';
import 'package:glow_hub/core/routing/routes.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/authentication/data/repo/on_boarding_repo.dart';

class GradientMainButton extends StatelessWidget {
  final int _currentIndex;
  final OnBoardingRepo _pages;
  final PageController _pageController;
  const GradientMainButton({
    super.key,
    required int currentIndex,
    required OnBoardingRepo pages,
    required PageController pageController,
  }) : _currentIndex = currentIndex,
       _pages = pages,
       _pageController = pageController;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final buttonGradient = isDark
        ? AppColors.buttonGradientDark
        : AppColors.buttonGradientLight;

    return ElevatedButton(
      onPressed: () {
        if (_currentIndex == _pages.onBoardingPagesData.length - 1) {
          Navigator.pushReplacementNamed(context, Routes.login);
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.zero,
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: buttonGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(minWidth: 88, minHeight: 48),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          child: Text(
            // index 2 3-1 == 2 then we at last index
            _currentIndex == _pages.onBoardingPagesData.length - 1
                ? "Get Started"
                : "Next",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
