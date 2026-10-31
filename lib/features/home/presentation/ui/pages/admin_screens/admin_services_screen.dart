import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/routing/routes.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/home/data/model/service_model.dart';
import 'package:glow_hub/features/home/data/repo/services_repo.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/header_curved_clipper.dart';

class AdminServicesScreen extends StatefulWidget {
  final ServicesRepo servicesRepo;

  const AdminServicesScreen({
    super.key,
    this.servicesRepo = const ServicesRepo(),
  });

  @override
  State<AdminServicesScreen> createState() => _AdminServicesScreenState();
}

class _AdminServicesScreenState extends State<AdminServicesScreen> {
  String _salonName = 'Salon Services';
  String _selectedCategory = 'All';

  static const LinearGradient roseGoldGradient = LinearGradient(
    colors: [Color(0xFFE8B7B0), Color(0xFFD89B92), Color(0xFFC7847B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
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

  void _navigateToAddService() {
    Navigator.pushNamed(context, Routes.adminAddServiceScreen);
  }

  Future<void> _confirmDeleteService(ServiceModel service) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const Text('Delete Service'),
        content: Text(
          'Are you sure you want to remove "${service.name}" from your services?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && service.id.isNotEmpty) {
      await widget.servicesRepo.deleteService(service.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Service "${service.name}" removed.'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF222222);
    final secondaryTextColor =
        isDark ? AppColors.textSecondaryDark : const Color(0xFF8E8E93);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: Column(
        children: [
          // 1. Top Curved Rose Gold Header
          _buildTopHeader(isDark),

          // 2. Services Header & Add Service Action Button
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Admin Services',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: primaryTextColor,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Manage your salon offers & pricing',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
                // Prominent "Add Service" Button
                InkWell(
                  onTap: _navigateToAddService,
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: isDark
                          ? AppColors.buttonGradientDark
                          : roseGoldGradient,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFC7847B).withValues(alpha: 0.3),
                          blurRadius: 8.r,
                          offset: Offset(0, 3.h),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add_rounded,
                          size: 18.sp,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Add Service',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. Category Filter Chips (All, Hair, Nails, Makeup, Skincare)
          _buildFilterChips(isDark),

          SizedBox(height: 8.h),

          // 4. Real-time Services Stream List
          Expanded(
            child: StreamBuilder<List<ServiceModel>>(
              stream: widget.servicesRepo.getOwnerServicesStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Text(
                        'Error loading services: ${snapshot.error}',
                        style: TextStyle(color: Colors.redAccent, fontSize: 13.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                final allServices = snapshot.data ?? [];
                final services = _selectedCategory == 'All'
                    ? allServices
                    : allServices
                        .where((s) => s.category
                            .toLowerCase()
                            .contains(_selectedCategory.toLowerCase()))
                        .toList();

                if (services.isEmpty) {
                  return _buildEmptyState(isDark);
                }

                return ListView.separated(
                  padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 24.h),
                  physics: const BouncingScrollPhysics(),
                  itemCount: services.length,
                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return _buildServiceCard(service, isDark);
                  },
                );
              },
            ),
          ),
        ],
      ),
      // Floating Action Button for instant access
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToAddService,
        backgroundColor:
            isDark ? AppColors.primaryDark : const Color(0xFFC7847B),
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text(
          'Add Service',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /// Top Curved Rose Gold Header
  Widget _buildTopHeader(bool isDark) {
    final headerTextColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF2A2323);

    return SizedBox(
      height: 120.h,
      child: Stack(
        children: [
          ClipPath(
            clipper: HeaderCurvedClipper(),
            child: Container(
              height: 105.h,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: isDark
                    ? AppColors.buttonGradientDark
                    : roseGoldGradient,
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _salonName,
                          style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.bold,
                            color: headerTextColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Services Management',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: headerTextColor.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.tune_rounded,
                      size: 20.sp,
                      color: headerTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Horizontal category filter chips
  Widget _buildFilterChips(bool isDark) {
    const categories = ['All', 'Hair', 'Nails', 'Makeup', 'Skincare'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: categories.map((cat) {
          final isSelected = _selectedCategory == cat;
          final selectedBg =
              isDark ? AppColors.primaryDark : const Color(0xFF4A3531);
          final selectedText = isDark ? Colors.black : Colors.white;
          final unselectedBg =
              isDark ? AppColors.surfaceDark : const Color(0xFFFBF1EC);
          final unselectedText =
              isDark ? AppColors.textPrimaryDark : const Color(0xFF4A3531);

          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedCategory = cat;
                });
              },
              borderRadius: BorderRadius.circular(20.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: isSelected ? selectedBg : unselectedBg,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? selectedBg
                        : (isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : const Color(0xFFF2DFD7)),
                    width: 0.8.w,
                  ),
                ),
                child: Text(
                  cat,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? selectedText : unselectedText,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Service Card Widget
  Widget _buildServiceCard(ServiceModel service, bool isDark) {
    final cardBg = isDark ? AppColors.surfaceDark : const Color(0xFFFBF1EC);
    final cardBorder = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : const Color(0xFFF2DFD7);
    final primaryTextColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF222222);
    final secondaryTextColor =
        isDark ? AppColors.textSecondaryDark : const Color(0xFF8E8E93);

    final IconData categoryIcon = _getCategoryIcon(service.category);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: cardBorder, width: 0.8.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Icon Container
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.primaryDark.withValues(alpha: 0.15)
                      : const Color(0xFFE8B7B0).withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  categoryIcon,
                  size: 22.sp,
                  color: isDark
                      ? AppColors.primaryDark
                      : const Color(0xFF8A4F46),
                ),
              ),

              SizedBox(width: 12.w),

              // Title and Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: primaryTextColor,
                      ),
                    ),
                    if (service.description.isNotEmpty) ...[
                      SizedBox(height: 2.h),
                      Text(
                        service.description,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: secondaryTextColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              // Delete Menu Option
              IconButton(
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.redAccent.withValues(alpha: 0.8),
                  size: 20.sp,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => _confirmDeleteService(service),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Details Row: Price, Duration, Category badge, Home service badge
          Wrap(
            spacing: 8.w,
            runSpacing: 6.h,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Price
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '${service.price.toStringAsFixed(0)} EGP',
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2E7D32),
                  ),
                ),
              ),

              // Discount (if any)
              if (service.discount != null && service.discount! > 0)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '-${service.discount!.toStringAsFixed(0)} EGP',
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                ),

              // Duration
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 13.sp,
                    color: secondaryTextColor,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    '${service.durationMinutes} min',
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      color: secondaryTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              // Category Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : const Color(0xFF4A3531).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  service.category,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : const Color(0xFF4A3531),
                  ),
                ),
              ),

              // Home Service Available
              if (service.isHomeServiceAvailable)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.home_outlined,
                      size: 13.sp,
                      color: const Color(0xFF2E7D32),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Home Service',
                      style: TextStyle(
                        fontSize: 10.5.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2E7D32),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  /// Empty state when no services are registered
  Widget _buildEmptyState(bool isDark) {
    final primaryTextColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF222222);
    final secondaryTextColor =
        isDark ? AppColors.textSecondaryDark : const Color(0xFF8E8E93);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: const Color(0xFFC7847B).withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.spa_outlined,
                size: 50.sp,
                color: const Color(0xFFC7847B),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'No Services Added Yet',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: primaryTextColor,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Start showcasing your beauty services, pricing, and timing to your clients.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: secondaryTextColor,
                height: 1.4,
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton.icon(
              onPressed: _navigateToAddService,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC7847B),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: 22.w,
                  vertical: 12.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 3,
              ),
              icon: const Icon(Icons.add_rounded),
              label: Text(
                'Add Your First Service',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    final cat = category.toLowerCase();
    if (cat.contains('hair')) {
      return Icons.face_retouching_natural_rounded;
    } else if (cat.contains('nail')) {
      return Icons.back_hand_outlined;
    } else if (cat.contains('makeup')) {
      return Icons.brush_rounded;
    } else if (cat.contains('skin')) {
      return Icons.spa_outlined;
    }
    return Icons.auto_awesome_rounded;
  }
}
