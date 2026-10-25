import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';

class CurvedHeaderBackground extends StatelessWidget {
  final double? height;
  final double? backgroundHeight;
  final Gradient? gradient;
  final Widget? floatingWidget;
  final bool showLogo;

  const CurvedHeaderBackground({
    super.key,
    this.height,
    this.backgroundHeight,
    this.gradient,
    this.floatingWidget,
    this.showLogo = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColors.primaryDark : AppColors.primaryLight;
    final bgHeight = backgroundHeight ?? 195.h;
    final totalHeight = height ?? (showLogo || floatingWidget != null ? 230.h : bgHeight);

    return SizedBox(
      height: totalHeight,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Curved Rose Gold Gradient Background
          ClipPath(
            clipper: const CurvedHeaderClipper(),
            child: Container(
              height: bgHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: gradient ??
                    (isDark
                        ? AppColors.buttonGradientDark
                        : AppColors.buttonGradientLight),
              ),
            ),
          ),

          // Overlapping Floating Badge / Brand Logo
          if (floatingWidget != null)
            Positioned(
              top: 135.h,
              child: floatingWidget!,
            )
          else if (showLogo)
            Positioned(
              top: 135.h,
              child: Container(
                width: 96.w,
                height: 96.w,
                padding: EdgeInsets.all(7.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (isDark ? AppColors.surfaceDark : Colors.white).withValues(alpha: 0.6),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryLight.withValues(alpha: 0.18),
                      blurRadius: 18.r,
                      offset: Offset(0, 8.h),
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark ? AppColors.surfaceDark : Colors.white,
                    border: Border.all(
                      color: primaryColor.withValues(alpha: 0.4),
                      width: 1.5.w,
                    ),
                  ),
                  child: Center(
                    child: CustomPaint(
                      size: Size(44.w, 44.w),
                      painter: _GlobeEmblemPainter(color: primaryColor),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CurvedHeaderClipper extends CustomClipper<Path> {
  const CurvedHeaderClipper();

  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height - 35.h)
      ..quadraticBezierTo(
        size.width / 2,
        size.height + 15.h,
        size.width,
        size.height - 35.h,
      )
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _GlobeEmblemPainter extends CustomPainter {
  final Color color;

  _GlobeEmblemPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Outer circle
    canvas.drawCircle(center, radius, paint);

    // Brand emblem stylized arcs
    final path = Path()
      ..moveTo(center.dx - radius * 0.7, center.dy - radius * 0.2)
      ..quadraticBezierTo(center.dx - radius * 0.1, center.dy - radius * 0.7, center.dx + radius * 0.2, center.dy - radius * 0.85)
      ..moveTo(center.dx - radius * 0.85, center.dy + radius * 0.2)
      ..cubicTo(center.dx - radius * 0.3, center.dy + radius * 0.1, center.dx + radius * 0.1, center.dy + radius * 0.6, center.dx + radius * 0.4, center.dy + radius * 0.8)
      ..moveTo(center.dx + radius * 0.1, center.dy - radius * 0.4)
      ..quadraticBezierTo(center.dx + radius * 0.6, center.dy - radius * 0.2, center.dx + radius * 0.75, center.dy + radius * 0.3)
      ..moveTo(center.dx, center.dy - radius)
      ..cubicTo(center.dx + radius * 0.5, center.dy - radius * 0.5, center.dx + radius * 0.5, center.dy + radius * 0.5, center.dx, center.dy + radius);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _GlobeEmblemPainter oldDelegate) =>
      oldDelegate.color != color;
}
