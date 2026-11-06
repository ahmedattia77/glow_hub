import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/features/home/data/model/service_model.dart';
import 'admin_service_card.dart';

class AdminServicesListView extends StatelessWidget {
  final List<ServiceModel> services;
  final ValueChanged<ServiceModel> onDeleteService;

  const AdminServicesListView({
    super.key,
    required this.services,
    required this.onDeleteService,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 24.h),
      physics: const BouncingScrollPhysics(),
      itemCount: services.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final service = services[index];
        return AdminServiceCard(
          service: service,
          onDelete: () => onDeleteService(service),
        );
      },
    );
  }
}

