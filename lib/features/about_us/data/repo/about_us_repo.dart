import 'package:flutter/material.dart';
import 'package:glow_hub/features/about_us/data/model/about_feature_model.dart';

class AboutUsRepo {
  const AboutUsRepo();

  final String title = "About Us";

  final String description =
      "Two lorem ipsum dolor sit amet consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim.";

  final List<AboutFeatureModel> features = const [
    AboutFeatureModel(
      icon: Icons.person_outline_rounded,
      title: "Contact\nUs",
    ),
    AboutFeatureModel(
      icon: Icons.favorite_border_rounded,
      title: "Share\nStories",
    ),
    AboutFeatureModel(
      icon: Icons.info_outline_rounded,
      title: "About\nMission",
    ),
  ];
}
