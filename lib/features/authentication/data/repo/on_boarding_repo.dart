import 'package:glow_hub/features/authentication/data/model/on_boarding_model.dart';

class OnBoardingRepo {
  final List<OnboardingModel> onBoardingPagesData = [
    OnboardingModel(
      title: "Welcome to GlowHub",
      description:
          "Chic beauty art, elite centers, and seamless booking for your ultimate look.",
      image: "assets/images/onboarding_1.png",
    ),
    OnboardingModel(
      title: "Book Best Salons",
      description:
          "Discover top-rated beauty centers and choose services inside the salon or at home.",
      image: "assets/images/onboarding_1.png",
    ),
    OnboardingModel(
      title: "Manage & Glow",
      description:
          "Track your appointments easily with instant notifications and QR confirmations.",
      image: "assets/images/onboarding_1.png",
    ),
  ];
}
