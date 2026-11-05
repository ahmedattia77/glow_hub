import 'package:flutter/material.dart';
import 'package:glow_hub/features/home/data/repo/admin_dashboard_repo.dart';
import 'home_admin_curved_header.dart';
import 'salon_details_modal.dart';

class HomeAdminHeader extends StatelessWidget {
  final AdminDashboardRepo repo;

  const HomeAdminHeader({
    super.key,
    required this.repo,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: repo.ownerSalonNameStream,
      initialData: repo.salonName,
      builder: (context, snapshot) {
        final currentSalonName = snapshot.data ?? repo.salonName;

        return HomeAdminCurvedHeader(
          salonName: currentSalonName,
          onSalonTap: () => showSalonDetailsModal(context, currentSalonName),
          onNotificationsTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No new notifications today'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        );
      },
    );
  }
}

