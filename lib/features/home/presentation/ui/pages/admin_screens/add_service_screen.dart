import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/home/data/repo/services_repo.dart';
import 'package:glow_hub/features/home/presentation/ui/cubit/add_service_cubit.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/admin_widgets/add_service/add_service_form.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/admin_widgets/add_service/add_service_header.dart';

class AddServiceScreen extends StatelessWidget {
  final ServicesRepo? servicesRepo;

  const AddServiceScreen({
    super.key,
    this.servicesRepo,
  });

  @override
  Widget build(BuildContext context) {
    final existingCubit = _getExistingCubit(context);
    if (existingCubit != null) {
      return const _AddServiceScreenContent();
    }

    return BlocProvider(
      create: (context) =>
          AddServiceCubit(servicesRepo ?? const ServicesRepo())
            ..loadSalonName(),
      child: const _AddServiceScreenContent(),
    );
  }

  AddServiceCubit? _getExistingCubit(BuildContext context) {
    try {
      return BlocProvider.of<AddServiceCubit>(context, listen: false);
    } catch (_) {
      return null;
    }
  }
}

class _AddServiceScreenContent extends StatelessWidget {
  const _AddServiceScreenContent();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenBg =
        isDark ? AppColors.backgroundDark : const Color(0xFFFAF2ED);

    return BlocListener<AddServiceCubit, AddServiceState>(
      listener: (context, state) {
        if (state is AddServiceSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Service added successfully!'),
              backgroundColor: AppColors.successGreen,
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pop(context, true);
        } else if (state is AddServiceFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error saving service: ${state.errorMessage}'),
              backgroundColor: AppColors.errorRed,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: screenBg,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Curved Rose Gold Header
              BlocBuilder<AddServiceCubit, AddServiceState>(
                buildWhen: (prev, curr) => prev.salonName != curr.salonName,
                builder: (context, state) {
                  return AddServiceHeader(salonName: state.salonName);
                },
              ),

              SizedBox(height: 12.h),

              // 2. Add Service Form (Contains all modular input widgets)
              const AddServiceForm(),
            ],
          ),
        ),
      ),
    );
  }
}
