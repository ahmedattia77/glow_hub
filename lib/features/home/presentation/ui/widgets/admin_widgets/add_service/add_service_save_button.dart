import 'package:flutter/material.dart';
import 'package:glow_hub/core/common_widgets/custom_app_button.dart';

class AddServiceSaveButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const AddServiceSaveButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppButton(
      text: 'Save Service',
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}

