import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/features/home/data/model/service_model.dart';
import 'package:glow_hub/features/salon_details/presentation/cubit/salon_details_cubit.dart';

class SalonServicesList extends StatelessWidget {
  final List<ServiceModel> services;

  const SalonServicesList({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<SalonDetailsCubit, SalonDetailsState>(
      builder: (context, state) {
        final selectedIndices = (state is SalonDetailsLoaded)
            ? state.selectedServiceIndices
            : <int>[];

        final homeIndices = (state is SalonDetailsLoaded)
            ? state.homeServiceIndices
            : <int>[];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Services',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 10.h),
            ...services.asMap().entries.map((entry) {
              final index = entry.key;
              final ServiceModel service = entry.value;
              final isSelected = selectedIndices.contains(index);
              final isHomeChecked = homeIndices.contains(index);

              final bool isHomeAvailable = service.isHomeServiceAvailable;
              final double originalPrice = service.price;
              final double? discount = service.discount;

              final double finalPrice = (discount != null && discount > 0)
                  ? (originalPrice - discount)
                  : originalPrice;

              return InkWell(
                onTap: () {
                  context.read<SalonDetailsCubit>().toggleServiceSelection(
                    index,
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 4.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colorScheme.primary.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.check_box_rounded
                                  : Icons.check_box_outline_blank_rounded,
                              size: 18,
                              color: isSelected
                                  ? colorScheme.primary
                                  : colorScheme.onSurfaceVariant,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                service.name,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.onSurface,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Row(
                        children: [
                          if (isHomeAvailable) ...[
                            InkWell(
                              onTap: () {
                                final isCurrentlyHome = homeIndices.contains(
                                  index,
                                );
                                context
                                    .read<SalonDetailsCubit>()
                                    .toggleServiceHome(index, !isCurrentlyHome);
                              },
                              borderRadius: BorderRadius.circular(4),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                  vertical: 2.h,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 16.sp,
                                      width: 16.sp,
                                      child: Checkbox(
                                        value: isHomeChecked,
                                        activeColor: Colors.green,
                                        onChanged: (bool? value) {
                                          context
                                              .read<SalonDetailsCubit>()
                                              .toggleServiceHome(
                                                index,
                                                value ?? false,
                                              );
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      'Home',
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                          ] else ...[
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Salon Only',
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                          ],

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (discount != null && discount > 0) ...[
                                Text(
                                  '\$${originalPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                              Text(
                                '\$${finalPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
