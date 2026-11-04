import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/routing/routes.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/home/data/model/service_model.dart';
import 'package:glow_hub/features/home/presentation/ui/cubit/admin_services_cubit.dart';
import 'admin_delete_service_dialog.dart';
import 'admin_services_empty_state.dart';
import 'admin_services_list_view.dart';

class AdminServicesBody extends StatelessWidget {
  const AdminServicesBody({super.key});

  Future<void> _handleDelete(BuildContext context, ServiceModel service) async {
    final confirmed = await showDeleteServiceDialog(context, service);
    if (confirmed == true && service.id.isNotEmpty && context.mounted) {
      await context.read<AdminServicesCubit>().deleteService(service.id);
      if (context.mounted) {
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
    return BlocBuilder<AdminServicesCubit, AdminServicesState>(
      builder: (context, state) {
        if (state is AdminServicesLoading || state is AdminServicesInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AdminServicesError) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Text(
                'Error loading services: ${state.message}',
                style: TextStyle(color: AppColors.errorRed, fontSize: 13.sp),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        if (state is AdminServicesLoaded) {
          final services = state.filteredServices;

          if (services.isEmpty) {
            return AdminServicesEmptyState(
              onAddService: () => Navigator.pushNamed(
                context,
                Routes.adminAddServiceScreen,
              ),
            );
          }

          return AdminServicesListView(
            services: services,
            onDeleteService: (service) => _handleDelete(context, service),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

