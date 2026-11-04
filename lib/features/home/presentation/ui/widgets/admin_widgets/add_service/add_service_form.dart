import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/theme/app_colors.dart';
import 'package:glow_hub/features/home/data/model/service_model.dart';
import 'package:glow_hub/features/home/presentation/ui/cubit/add_service_cubit.dart';
import 'add_service_availability_switch.dart';
import 'add_service_category_section.dart';
import 'add_service_description_field.dart';
import 'add_service_discount_field.dart';
import 'add_service_name_field.dart';
import 'add_service_pricing_fields.dart';
import 'add_service_save_button.dart';

class AddServiceForm extends StatefulWidget {
  const AddServiceForm({super.key});

  @override
  State<AddServiceForm> createState() => _AddServiceFormState();
}

class _AddServiceFormState extends State<AddServiceForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _durationController = TextEditingController();
  final _discountController = TextEditingController();

  final Set<String> _selectedCategories = {'Hair'};
  bool _isHomeServiceAvailable = true;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _durationController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        if (_selectedCategories.length > 1) {
          _selectedCategories.remove(category);
        }
      } else {
        _selectedCategories.add(category);
      }
    });
  }

  void _saveService() {
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();
    final priceText = _priceController.text.trim();
    final durationText = _durationController.text.trim();
    final discountText = _discountController.text.trim();

    if (name.isEmpty) {
      _showWarningSnackBar('Please enter a service name');
      return;
    }

    final price = double.tryParse(priceText);
    if (price == null || price <= 0) {
      _showWarningSnackBar('Please enter a valid price');
      return;
    }

    final durationMinutes = int.tryParse(durationText);
    if (durationMinutes == null || durationMinutes <= 0) {
      _showWarningSnackBar('Please enter duration in minutes');
      return;
    }

    if (_selectedCategories.isEmpty) {
      _showWarningSnackBar('Please select at least one category');
      return;
    }

    double? discount;
    if (discountText.isNotEmpty) {
      discount = double.tryParse(discountText);
    }

    final service = ServiceModel(
      id: '',
      name: name,
      description: description,
      price: price,
      durationMinutes: durationMinutes,
      category: _selectedCategories.join(', '),
      isHomeServiceAvailable: _isHomeServiceAvailable,
      discount: discount,
    );

    context.read<AddServiceCubit>().addService(service);
  }

  void _showWarningSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.errorRed,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor =
        isDark ? AppColors.textPrimaryDark : const Color(0xFF241816);

    return BlocBuilder<AddServiceCubit, AddServiceState>(
      builder: (context, state) {
        final isLoading = state is AddServiceLoading;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Screen Title
                Text(
                  'Add New Service',
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w800,
                    color: primaryTextColor,
                    letterSpacing: -0.2,
                  ),
                ),

                SizedBox(height: 18.h),

                // Service Name Field
                AddServiceNameField(controller: _nameController),

                SizedBox(height: 16.h),

                // Description Field
                AddServiceDescriptionField(controller: _descriptionController),

                SizedBox(height: 16.h),

                // Category Section
                AddServiceCategorySection(
                  selectedCategories: _selectedCategories,
                  onCategoryToggle: _toggleCategory,
                ),

                SizedBox(height: 16.h),

                // Price and Duration Fields Row
                AddServicePricingFields(
                  priceController: _priceController,
                  durationController: _durationController,
                ),

                SizedBox(height: 16.h),

                // Discount Field
                AddServiceDiscountField(controller: _discountController),

                SizedBox(height: 16.h),

                // Availability Switch
                AddServiceAvailabilitySwitch(
                  isAvailable: _isHomeServiceAvailable,
                  onChanged: (val) {
                    setState(() {
                      _isHomeServiceAvailable = val;
                    });
                  },
                ),

                SizedBox(height: 28.h),

                // Save Service Button
                AddServiceSaveButton(
                  isLoading: isLoading,
                  onPressed: _saveService,
                ),

                SizedBox(height: 32.h),
              ],
            ),
          ),
        );
      },
    );
  }
}

