import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/common_widgets/custom_app_button.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/home/data/model/service_model.dart';
import 'package:glow_hub/features/home/data/repo/services_repo.dart';

class AddServiceScreen extends StatefulWidget {
  final ServicesRepo servicesRepo;

  const AddServiceScreen({
    super.key,
    this.servicesRepo = const ServicesRepo(),
  });

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _durationController = TextEditingController();
  final _discountController = TextEditingController();

  final Set<String> _selectedCategories = {'Hair'};
  bool _isHomeServiceAvailable = true;
  bool _isLoading = false;
  String _salonName = 'Dois Salon';

  // Warm rose gold header gradient matching the design image
  static const LinearGradient roseGoldGradient = LinearGradient(
    colors: [
      Color(0xFFE5AAA0),
      Color(0xFFD6948A),
      Color(0xFFC77E73),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  void initState() {
    super.initState();
    _loadSalonName();
  }

  Future<void> _loadSalonName() async {
    try {
      final name = await widget.servicesRepo.getOwnerSalonName();
      if (mounted) {
        setState(() {
          _salonName = name;
        });
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _durationController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        if (_selectedCategories.length > 1) {
          _selectedCategories.remove(category);
        }
      } else {
        _selectedCategories.add(category);
      }
    });
  }

  Future<void> _saveService() async {
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();
    final priceText = _priceController.text.trim();
    final durationText = _durationController.text.trim();
    final discountText = _discountController.text.trim();

    if (name.isEmpty) {
      _showWarningSnackBar('Please enter a service name');
      return;
    }

    final price = double.tryParse(priceText);
    if (price == null || price <= 0) {
      _showWarningSnackBar('Please enter a valid price');
      return;
    }

    final durationMinutes = int.tryParse(durationText);
    if (durationMinutes == null || durationMinutes <= 0) {
      _showWarningSnackBar('Please enter duration in minutes');
      return;
    }

    if (_selectedCategories.isEmpty) {
      _showWarningSnackBar('Please select at least one category');
      return;
    }

    double? discount;
    if (discountText.isNotEmpty) {
      discount = double.tryParse(discountText);
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final service = ServiceModel(
        id: '', // Will be assigned by ServicesRepo
        name: name,
        description: description,
        price: price,
        durationMinutes: durationMinutes,
        category: _selectedCategories.join(', '),
        isHomeServiceAvailable: _isHomeServiceAvailable,
        discount: discount,
      );

      await widget.servicesRepo.addService(service);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Service added successfully!'),
          backgroundColor: Color(0xFF2E7D32),
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      _showWarningSnackBar('Error saving service: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showWarningSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Palette matching the uploaded target image
    final screenBg =
        isDark ? AppColors.backgroundDark : const Color(0xFFFAF2ED);
    final primaryTextColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF241816);
    final secondaryTextColor =
        isDark ? AppColors.textSecondaryDark : const Color(0xFF88736E);
    final cardBg = isDark ? AppColors.surfaceDark : const Color(0xFFF6E7DE);
    final cardBorder = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xFFEBD4C7);
    final iconColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF382320);

    return Scaffold(
      backgroundColor: screenBg,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Curved Rose Gold Header with graceful aligned curve
            _buildTopHeader(isDark),

            SizedBox(height: 12.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Screen Title (Large & Bold)
                    Text(
                      'Add New Service',
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w800,
                        color: primaryTextColor,
                        letterSpacing: -0.2,
                      ),
                    ),

                    SizedBox(height: 18.h),

                    // Service Name Card
                    _buildInputCard(
                      icon: Icons.edit_outlined,
                      iconLabel: 'Name',
                      topLabel: 'Service Name',
                      child: TextField(
                        controller: _nameController,
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
                            color: const Color(0xFF9E8A84),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      cardBg: cardBg,
                      cardBorder: cardBorder,
                      iconColor: iconColor,
                      secondaryTextColor: secondaryTextColor,
                    ),

                    SizedBox(height: 16.h),

                    // Description Section Title
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18.5.sp,
                        fontWeight: FontWeight.w800,
                        color: primaryTextColor,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Description Card
                    _buildInputCard(
                      icon: Icons.article_outlined,
                      iconLabel: 'Note',
                      child: TextField(
                        controller: _descriptionController,
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
                            color: const Color(0xFF9E8A84),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      cardBg: cardBg,
                      cardBorder: cardBorder,
                      iconColor: iconColor,
                      secondaryTextColor: secondaryTextColor,
                    ),

                    SizedBox(height: 16.h),

                    // Category Section Title
                    Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 18.5.sp,
                        fontWeight: FontWeight.w800,
                        color: primaryTextColor,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // Category Chips (Hair, Nails, Makeup, Skincare)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCategoryChip(
                          label: 'Hair',
                          icon: Icons.face_3_rounded,
                          isSelected: _selectedCategories.contains('Hair'),
                          isDark: isDark,
                          onTap: () => _toggleCategory('Hair'),
                        ),
                        _buildCategoryChip(
                          label: 'Nails',
                          icon: Icons.back_hand_rounded,
                          isSelected: _selectedCategories.contains('Nails'),
                          isDark: isDark,
                          onTap: () => _toggleCategory('Nails'),
                        ),
                        _buildCategoryChip(
                          label: 'Makeup',
                          icon: Icons.brush_rounded,
                          isSelected: _selectedCategories.contains('Makeup'),
                          isDark: isDark,
                          onTap: () => _toggleCategory('Makeup'),
                        ),
                        _buildCategoryChip(
                          label: 'Skincare',
                          icon: Icons.spa_outlined,
                          isSelected: _selectedCategories.contains('Skincare'),
                          isDark: isDark,
                          onTap: () => _toggleCategory('Skincare'),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    // Selected Categories Indicator
                    Text(
                      'Selected: ${_selectedCategories.join(', ')}',
                      style: TextStyle(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.primaryDark
                            : const Color(0xFF382320),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Row: Price (EGP) & Duration (Min...)
                    Row(
                      children: [
                        // Price Field
                        Expanded(
                          child: _buildInputCard(
                            icon: Icons.payments_outlined,
                            iconLabel: 'Cash',
                            topLabel: 'Price (EGP)',
                            child: TextField(
                              controller: _priceController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
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
                                  color: const Color(0xFF9E8A84),
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                            cardBg: cardBg,
                            cardBorder: cardBorder,
                            iconColor: iconColor,
                            secondaryTextColor: secondaryTextColor,
                          ),
                        ),

                        SizedBox(width: 12.w),

                        // Duration Field
                        Expanded(
                          child: _buildInputCard(
                            icon: Icons.access_time_rounded,
                            iconLabel: 'Clock',
                            topLabel: 'Duration (Min...',
                            child: TextField(
                              controller: _durationController,
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
                                  color: const Color(0xFF9E8A84),
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                            cardBg: cardBg,
                            cardBorder: cardBorder,
                            iconColor: iconColor,
                            secondaryTextColor: secondaryTextColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Discount (EGP) Field
                    _buildInputCard(
                      icon: Icons.local_offer_outlined,
                      iconLabel: 'Tag',
                      topLabel: 'Discount (EGP)',
                      child: TextField(
                        controller: _discountController,
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
                            color: const Color(0xFF9E8A84),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      cardBg: cardBg,
                      cardBorder: cardBorder,
                      iconColor: iconColor,
                      secondaryTextColor: secondaryTextColor,
                    ),

                    SizedBox(height: 16.h),

                    // Availability Card with Pill Switch
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: cardBorder, width: 1.w),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Availability',
                                  style: TextStyle(
                                    fontSize: 12.5.sp,
                                    color: secondaryTextColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Home Service Availability',
                                  style: TextStyle(
                                    fontSize: 15.5.sp,
                                    fontWeight: FontWeight.w800,
                                    color: primaryTextColor,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  "Option for 'Available as Home Service'",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: secondaryTextColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _buildPillSwitch(
                            value: _isHomeServiceAvailable,
                            onChanged: (val) {
                              setState(() {
                                _isHomeServiceAvailable = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 28.h),

                    // Save Service Button
                    CustomAppButton(
                      text: 'Save Service',
                      isLoading: _isLoading,
                      onPressed: _saveService,
                    ),

                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Top Header with beautifully aligned gentle curve and spacious content layout
  Widget _buildTopHeader(bool isDark) {
    final headerTextColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF2C1E1C);

    return SizedBox(
      height: 148.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background with custom gentle curve clipper
          ClipPath(
            clipper: AddServiceHeaderClipper(),
            child: Container(
              decoration: BoxDecoration(
                gradient: isDark
                    ? AppColors.buttonGradientDark
                    : roseGoldGradient,
              ),
            ),
          ),

          // Content Row: Back, Salon Name, Bell Icon
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  children: [
                    // Back Button
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(10.r),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 6.h,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 18.sp,
                              color: headerTextColor,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Back',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                                color: headerTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Center Salon Name
                    Expanded(
                      child: Center(
                        child: Text(
                          _salonName,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            color: headerTextColor,
                            letterSpacing: 0.3,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    // Notification Bell Icon
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(20.r),
                      child: Padding(
                        padding: EdgeInsets.all(6.w),
                        child: Icon(
                          Icons.notifications_none_rounded,
                          size: 25.sp,
                          color: headerTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Reusable Input Card matching the design image with clear labels and bold text
  Widget _buildInputCard({
    required IconData icon,
    required String iconLabel,
    String? topLabel,
    required Widget child,
    required Color cardBg,
    required Color cardBorder,
    required Color iconColor,
    required Color secondaryTextColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: cardBorder, width: 1.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Icon Column
          SizedBox(
            width: 44.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 23.sp, color: iconColor),
                SizedBox(height: 3.h),
                Text(
                  iconLabel,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: iconColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Vertical Separator
          Container(
            height: 32.h,
            width: 1.w,
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            color: const Color(0xFFDFCCC2),
          ),

          // Right Content Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (topLabel != null) ...[
                  Text(
                    topLabel,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      color: secondaryTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Category Selection Chip with larger icons and bold labels
  Widget _buildCategoryChip({
    required String label,
    required IconData icon,
    required bool isSelected,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    final selectedBg =
        isDark ? AppColors.primaryDark : const Color(0xFF382320);
    final selectedTextColor = isDark ? Colors.black : Colors.white;
    final unselectedBg =
        isDark ? AppColors.surfaceDark : const Color(0xFFF6E7DE);
    final unselectedTextColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF382320);
    final unselectedBorder = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xFFEBD4C7);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 75.w,
        height: 75.w,
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : unselectedBg,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? selectedBg : unselectedBorder,
            width: 1.w,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: selectedBg.withValues(alpha: 0.28),
                    blurRadius: 8.r,
                    offset: Offset(0, 3.h),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28.sp,
              color: isSelected ? selectedTextColor : unselectedTextColor,
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: isSelected ? selectedTextColor : unselectedTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Custom Pill Switch matching the design image (Rich Green ON / Gray OFF)
  Widget _buildPillSwitch({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 62.w,
        height: 30.h,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: value ? const Color(0xFF2E7D32) : const Color(0xFF8E8E93),
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Text Label (ON on left, OFF on right)
            Align(
              alignment: value ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(
                  left: value ? 5.w : 0,
                  right: value ? 0 : 5.w,
                ),
                child: Text(
                  value ? 'ON' : 'OFF',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Sliding White Circular Thumb
            Align(
              alignment:
                  value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 22.w,
                height: 22.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom Clipper for AddServiceScreen header:
/// Produces a gentle, balanced curve dipping slightly in the center,
/// leaving generous headroom and padding around the Back button and salon title.
class AddServiceHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Start at top-left
    path.lineTo(0, size.height - 24);

    // Smooth quadratic curve dipping slightly in the center
    final controlPoint = Offset(size.width / 2, size.height + 12);
    final endPoint = Offset(size.width, size.height - 24);

    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      endPoint.dx,
      endPoint.dy,
    );

    // Up to top-right and close
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
