class Routes {
  const Routes._();

  // 1. Auth & Onboarding
  static const String initialRoute = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String roleSelection = '/roleSelection';
  static const String otpVerification = '/otpVerification';

  // 2. Admin / Owner Routes
  static const String adminHomeScreen = '/adminHomeScreen';
  static const String adminCenterSetupScreen =
      '/adminCenterSetupScreen'; // تأسيس الصالون لأول مرة
  static const String adminCenterSettingsScreen =
      '/adminCenterSettingsScreen'; // إعدادات وتعديل بيانات الصالون للأدمن
  static const String adminAddServiceScreen = '/adminAddServiceScreen';
  static const String adminManageServicesScreen = '/adminManageServicesScreen';

  // 3. Customer Routes
  static const String userHomeScreen = '/userHomeScreen';
  static const String salonDetailsScreen = '/salonDetailsScreen';
  static const String bookingScreen = '/bookingScreen';
  static const String myAppointmentsScreen = '/myAppointmentsScreen';
  static const String userPreferencesSettingsScreen =
      '/userPreferencesSettingsScreen'; // إعدادات وتفضيلات العميل

  // 4. Shared Routes (Notifications Only)
  static const String notificationsScreen = '/notificationsScreen';
}
