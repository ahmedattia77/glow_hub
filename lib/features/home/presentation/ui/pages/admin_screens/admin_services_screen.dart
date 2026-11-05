import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/home/data/repo/services_repo.dart';
import 'package:glow_hub/features/home/presentation/ui/cubit/admin_services_cubit.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/admin_widgets/services_management/admin_add_service_fab.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/admin_widgets/services_management/admin_services_action_bar.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/admin_widgets/services_management/admin_services_body.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/admin_widgets/services_management/admin_services_category_filter.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/admin_widgets/services_management/admin_services_header.dart';

class AdminServicesScreen extends StatelessWidget {
  final ServicesRepo? servicesRepo;

  const AdminServicesScreen({
    super.key,
    this.servicesRepo,
  });

  @override
  Widget build(BuildContext context) {
    final existingCubit = _getExistingCubit(context);
    if (existingCubit != null) {
      return const _AdminServicesScreenContent();
    }

    return BlocProvider(
      create: (context) =>
          AdminServicesCubit(servicesRepo ?? const ServicesRepo())
            ..getServices()
            ..getSalonName(),
      child: const _AdminServicesScreenContent(),
    );
  }

  AdminServicesCubit? _getExistingCubit(BuildContext context) {
    try {
      return BlocProvider.of<AdminServicesCubit>(context, listen: false);
    } catch (_) {
      return null;
    }
  }
}

class _AdminServicesScreenContent extends StatelessWidget {
  const _AdminServicesScreenContent();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: Column(
        children: [
          // 1. Top Curved Rose Gold Header
          BlocBuilder<AdminServicesCubit, AdminServicesState>(
            buildWhen: (prev, curr) {
              final prevName =
                  prev is AdminServicesLoaded ? prev.salonName : '';
              final currName =
                  curr is AdminServicesLoaded ? curr.salonName : '';
              return prevName != currName;
            },
            builder: (context, state) {
              final salonName = state is AdminServicesLoaded
                  ? state.salonName
                  : 'Salon Services';
              return AdminServicesHeader(salonName: salonName);
            },
          ),

          // 2. Services Title & Add Service Action Button
          const AdminServicesActionBar(),

          // 3. Category Filter Chips (All, Hair, Nails, Makeup, Skincare)
          BlocBuilder<AdminServicesCubit, AdminServicesState>(
            buildWhen: (prev, curr) {
              final prevCat =
                  prev is AdminServicesLoaded ? prev.selectedCategory : '';
              final currCat =
                  curr is AdminServicesLoaded ? curr.selectedCategory : '';
              return prevCat != currCat;
            },
            builder: (context, state) {
              final selectedCategory = state is AdminServicesLoaded
                  ? state.selectedCategory
                  : 'All';
              return AdminServicesCategoryFilter(
                selectedCategory: selectedCategory,
                onCategorySelected: (cat) {
                  context.read<AdminServicesCubit>().selectCategory(cat);
                },
              );
            },
          ),

          SizedBox(height: 8.h),

          // 4. Real-time Services Stream Body (Loading, Empty, List)
          const Expanded(
            child: AdminServicesBody(),
          ),
        ],
      ),
      floatingActionButton: const AdminAddServiceFab(),
    );
  }
}
