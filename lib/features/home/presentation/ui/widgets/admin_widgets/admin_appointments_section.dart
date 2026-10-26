import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/home/data/model/admin_dashboard_models.dart';

class AdminAppointmentsSection extends StatelessWidget {
  final int total;
  final int confirmed;
  final int completed;
  final int cancelled;
  final List<AppointmentItem> appointments;
  final ValueChanged<AppointmentItem>? onAppointmentTap;

  const AdminAppointmentsSection({
    super.key,
    required this.total,
    required this.confirmed,
    required this.completed,
    required this.cancelled,
    required this.appointments,
    this.onAppointmentTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            "Today's Appointments",
            style: TextStyle(
              fontSize: 16.5.sp,
              fontWeight: FontWeight.bold,
              color: primaryTextColor,
              letterSpacing: 0.1,
            ),
          ),

          SizedBox(height: 10.h),

          // Summary Statistics Card
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : const Color(0xFFFBF1EC),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : const Color(0xFFF2DFD7),
                width: 0.8.w,
              ),
            ),
            child: Row(
              children: [
                // Left: TOTAL & Large Number
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'TOTAL:',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : const Color(0xFF706A68),
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        '$total',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 12.w),

                // Vertical Divider
                Container(
                  height: 32.h,
                  width: 0.9.w,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.12)
                      : const Color(0xFFE5D5CE),
                ),

                SizedBox(width: 12.w),

                // Right: 2 Columns with vertical divider
                Expanded(
                  child: Row(
                    children: [
                      // Column 1: TOTAL & Completed
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildStatItem('TOTAL', total, isDark),
                            SizedBox(height: 4.h),
                            _buildStatItem('Completed', completed, isDark),
                          ],
                        ),
                      ),

                      // Vertical Line
                      Container(
                        height: 24.h,
                        width: 0.9.w,
                        margin: EdgeInsets.symmetric(horizontal: 6.w),
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.12)
                            : const Color(0xFFE5D5CE),
                      ),

                      // Column 2: Confirmed & Cancelled
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildStatItem('Confirmed', confirmed, isDark),
                            SizedBox(height: 4.h),
                            _buildStatItem('Cancelled', cancelled, isDark),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 6.h),

          // Appointments List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: appointments.length,
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => Divider(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : const Color(0xFFEFEFEF),
              height: 1.h,
              thickness: 0.8.h,
            ),
            itemBuilder: (context, index) {
              final item = appointments[index];
              return _AppointmentItemTile(
                appointment: item,
                onTap: onAppointmentTap != null
                    ? () => onAppointmentTap!(item)
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int count, bool isDark) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : const Color(0xFF706A68),
            ),
          ),
          TextSpan(
            text: '$count',
            style: TextStyle(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.bold,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
        ],
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _AppointmentItemTile extends StatelessWidget {
  final AppointmentItem appointment;
  final VoidCallback? onTap;

  const _AppointmentItemTile({
    required this.appointment,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isConfirmed = appointment.status == AppointmentStatus.confirmed;

    final indicatorColor = isConfirmed
        ? const Color(0xFF2E7D32)
        : const Color(0xFF757575);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Container(
              width: 3.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: indicatorColor,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(width: 10.w),
            _ClientAvatar(type: appointment.avatarType, size: 38.w),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    appointment.clientName,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${appointment.service}, ${appointment.time}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : const Color(0xFF777777),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 4.5.h),
              decoration: BoxDecoration(
                color: indicatorColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                appointment.statusText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClientAvatar extends StatelessWidget {
  final ClientAvatarType type;
  final double size;

  const _ClientAvatar({required this.type, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getBackgroundColor(),
      ),
      child: ClipOval(
        child: CustomPaint(
          size: Size(size, size),
          painter: _SoftAvatarPainter(type: type),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (type) {
      case ClientAvatarType.sarah:
        return const Color(0xFFFDE8E9);
      case ClientAvatarType.maria:
        return const Color(0xFFFFF3E0);
      case ClientAvatarType.fatima:
        return const Color(0xFFECEFF1);
    }
  }
}

class _SoftAvatarPainter extends CustomPainter {
  final ClientAvatarType type;

  _SoftAvatarPainter({required this.type});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final skinPaint = Paint()
      ..color = type == ClientAvatarType.fatima
          ? const Color(0xFFD49B72)
          : const Color(0xFFFFD1B3)
      ..style = PaintingStyle.fill;

    if (type == ClientAvatarType.fatima) {
      final hijabPaint = Paint()
        ..color = const Color(0xFF78909C)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(w / 2, h * 0.44), w * 0.35, hijabPaint);

      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(w / 2, h * 0.46),
          width: w * 0.36,
          height: h * 0.42,
        ),
        skinPaint,
      );

      final capPaint = Paint()
        ..color = const Color(0xFF455A64)
        ..style = PaintingStyle.fill;
      final capPath = Path()
        ..moveTo(w * 0.32, h * 0.3)
        ..quadraticBezierTo(w * 0.5, h * 0.24, w * 0.68, h * 0.3)
        ..quadraticBezierTo(w * 0.5, h * 0.34, w * 0.32, h * 0.3);
      canvas.drawPath(capPath, capPaint);

      final clothesPaint = Paint()
        ..color = const Color(0xFF546E7A)
        ..style = PaintingStyle.fill;
      final bodyPath = Path()
        ..moveTo(w * 0.1, h)
        ..quadraticBezierTo(w * 0.5, h * 0.65, w * 0.9, h)
        ..close();
      canvas.drawPath(bodyPath, clothesPaint);
      return;
    }

    final hairColor = type == ClientAvatarType.sarah
        ? const Color(0xFF9E5E4E)
        : const Color(0xFF422E26);

    final clothesColor = type == ClientAvatarType.sarah
        ? const Color(0xFFE57373)
        : const Color(0xFFFF8A65);

    final hairPaint = Paint()
      ..color = hairColor
      ..style = PaintingStyle.fill;

    final clothesPaint = Paint()
      ..color = clothesColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(w / 2, h * 0.42), w * 0.36, hairPaint);

    final bodyPath = Path()
      ..moveTo(w * 0.1, h)
      ..quadraticBezierTo(w * 0.5, h * 0.66, w * 0.9, h)
      ..close();
    canvas.drawPath(bodyPath, clothesPaint);

    final neckPaint = Paint()
      ..color = skinPaint.color
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(w / 2, h * 0.62),
        width: w * 0.15,
        height: h * 0.16,
      ),
      neckPaint,
    );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w / 2, h * 0.44),
        width: w * 0.4,
        height: h * 0.42,
      ),
      skinPaint,
    );

    final bangsPath = Path()
      ..moveTo(w * 0.26, h * 0.38)
      ..quadraticBezierTo(w * 0.36, h * 0.22, w * 0.5, h * 0.27)
      ..quadraticBezierTo(w * 0.64, h * 0.22, w * 0.74, h * 0.38)
      ..quadraticBezierTo(w * 0.5, h * 0.16, w * 0.26, h * 0.38);
    canvas.drawPath(bangsPath, hairPaint);
  }

  @override
  bool shouldRepaint(covariant _SoftAvatarPainter oldDelegate) =>
      oldDelegate.type != type;
}
