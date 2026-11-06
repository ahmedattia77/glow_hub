import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/features/salon_details/presentation/cubit/salon_details_cubit.dart';

class ServiceTypeToggle extends StatelessWidget {
  const ServiceTypeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<SalonDetailsCubit, SalonDetailsState>(
      builder: (context, state) {
        final isHomeService = (state is SalonDetailsLoaded)
            ? state.isHomeService
            : false;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'In-Center / Home Service',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            Switch(
              value: isHomeService,
              activeColor: colorScheme.primary,
              onChanged: (val) {
                context.read<SalonDetailsCubit>().toggleServiceType(val);
              },
            ),
          ],
        );
      },
    );
  }
}
