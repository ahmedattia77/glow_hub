import 'package:flutter_test/flutter_test.dart';
import 'package:glow_hub/features/home/data/repo/admin_dashboard_repo.dart';

void main() {
  test('Admin dashboard repo smoke test', () {
    const repo = AdminDashboardRepo();
    expect(repo.salonName, 'Faten Salon');
    expect(repo.todayAppointments.isNotEmpty, true);
    expect(repo.earningsBars.length, 5);
  });
}
