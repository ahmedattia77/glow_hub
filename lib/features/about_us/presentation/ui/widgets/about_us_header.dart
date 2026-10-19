import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';

class AboutUsHeader extends StatelessWidget {
  const AboutUsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 230.h,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // Curved Rose Gold Gradient Header Background
          ClipPath(
            clipper: _HeaderCurveClipper(),
            child: Container(
              height: 195.h,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: isDark
                    ? AppColors.buttonGradientDark
                    : AppColors.buttonGradientLight,
              ),
            ),
          ),

          // Circular Logo Badge Overlapping the Curve
          Positioned(
            top: 135.h,
            child: Container(
              width: 96.w,
              height: 96.w,
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
              padding: EdgeInsets.all(7.w),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  border: Border.all(
                    color: (isDark ? AppColors.primaryDark : AppColors.primaryLight).withValues(alpha: 0.4),
                    width: 1.5.w,
                  ),
                ),
                child: Center(
                  child: CustomPaint(
                    size: Size(44.w, 44.w),
                    painter: _GlobeEmblemPainter(
                      color: isDark ? AppColors.primaryDark : AppColors.primaryLight,
                    ),
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

class _HeaderCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 35.h);

    // Smooth convex curve dipping in the center
    final controlPoint = Offset(size.width / 2, size.height + 15.h);
    final endPoint = Offset(size.width, size.height - 35.h);

    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      endPoint.dx,
      endPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
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

    // Organic stylized lines representing the brand globe / beauty elements
    final path1 = Path();
    path1.moveTo(center.dx - radius * 0.7, center.dy - radius * 0.2);
    path1.quadraticBezierTo(
      center.dx - radius * 0.1,
      center.dy - radius * 0.7,
      center.dx + radius * 0.2,
      center.dy - radius * 0.85,
    );
    canvas.drawPath(path1, paint);

    final path2 = Path();
    path2.moveTo(center.dx - radius * 0.85, center.dy + radius * 0.2);
    path2.cubicTo(
      center.dx - radius * 0.3,
      center.dy + radius * 0.1,
      center.dx + radius * 0.1,
      center.dy + radius * 0.6,
      center.dx + radius * 0.4,
      center.dy + radius * 0.8,
    );
    canvas.drawPath(path2, paint);

    final path3 = Path();
    path3.moveTo(center.dx + radius * 0.1, center.dy - radius * 0.4);
    path3.quadraticBezierTo(
      center.dx + radius * 0.6,
      center.dy - radius * 0.2,
      center.dx + radius * 0.75,
      center.dy + radius * 0.3,
    );
    canvas.drawPath(path3, paint);

    // Subtle meridian arc
    final meridianPath = Path();
    meridianPath.moveTo(center.dx, center.dy - radius);
    meridianPath.cubicTo(
      center.dx + radius * 0.5,
      center.dy - radius * 0.5,
      center.dx + radius * 0.5,
      center.dy + radius * 0.5,
      center.dx,
      center.dy + radius,
    );
    canvas.drawPath(meridianPath, paint..color = color.withValues(alpha: 0.6));
  }

  @override
  bool shouldRepaint(covariant _GlobeEmblemPainter oldDelegate) =>
      oldDelegate.color != color;
}
