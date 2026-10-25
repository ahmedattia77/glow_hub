import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/admin_home/data/model/earnings_model.dart';

class EarningsSection extends StatelessWidget {
  final EarningsOverviewModel model;

  const EarningsSection({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final secondaryTextColor =
        isDark ? AppColors.textSecondaryDark : const Color(0xFF8E8E93);

    const double maxY = 2500;
    final chartHeight = 115.h;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Earnings Overview',
            style: TextStyle(
              fontSize: 16.5.sp,
              fontWeight: FontWeight.bold,
              color: primaryTextColor,
              letterSpacing: 0.1,
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: chartHeight + 15.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 34.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: model.yAxisMarks.map((mark) {
                      return Text(
                        mark.toInt().toString(),
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: secondaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CustomPaint(
                        size: Size(double.infinity, chartHeight),
                        painter: _DottedGridPainter(
                          marks: model.yAxisMarks,
                          lineColor: isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : const Color(0xFFE5E5EA),
                        ),
                      ),
                      Positioned(
                        left: 8.w,
                        right: 8.w,
                        bottom: 0,
                        height: chartHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: model.bars.map((bar) {
                            final barHeightFraction =
                                (bar.amount / maxY).clamp(0.0, 1.0);
                            final calculatedHeight =
                                chartHeight * barHeightFraction;
                            final barColor = bar.color ??
                                (isDark
                                    ? AppColors.primaryDark
                                    : AppColors.primaryLight);

                            return Container(
                              width: 20.w,
                              height: calculatedHeight,
                              decoration: BoxDecoration(
                                color: barColor,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(3.r),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DottedGridPainter extends CustomPainter {
  final List<double> marks;
  final Color lineColor;

  _DottedGridPainter({
    required this.marks,
    required this.lineColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 0.9;

    const dashWidth = 3.0;
    const dashSpace = 3.0;

    for (int i = 0; i < marks.length; i++) {
      final y = (i / (marks.length - 1)) * size.height;
      double startX = 0;
      while (startX < size.width) {
        canvas.drawLine(
          Offset(startX, y),
          Offset((startX + dashWidth).clamp(0, size.width), y),
          paint,
        );
        startX += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DottedGridPainter oldDelegate) =>
      oldDelegate.lineColor != lineColor || oldDelegate.marks != marks;
}
