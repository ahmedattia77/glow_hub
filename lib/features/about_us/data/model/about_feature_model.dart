import 'package:flutter/material.dart';

class AboutFeatureModel {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const AboutFeatureModel({
    required this.icon,
    required this.title,
    this.onTap,
  });
}
