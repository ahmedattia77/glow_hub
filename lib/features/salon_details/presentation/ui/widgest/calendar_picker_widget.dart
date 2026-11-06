import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/features/salon_details/presentation/cubit/salon_details_cubit.dart';

class CalendarPickerWidget extends StatelessWidget {
  const CalendarPickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final days = [
      {'day': 'Su', 'date': '15'},
      {'day': 'Mo', 'date': '16'},
      {'day': 'Tu', 'date': '17'},
      {'day': 'We', 'date': '18'},
      {'day': 'Th', 'date': '19'},
    ];

    return BlocBuilder<SalonDetailsCubit, SalonDetailsState>(
      builder: (context, state) {
        final selectedDayIndex = (state is SalonDetailsLoaded)
            ? state.selectedDayIndex
            : 1;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Calendar Picker',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.chevron_left,
                      size: 20,
                      color: colorScheme.onSurface,
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: colorScheme.onSurface,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: days.asMap().entries.map((entry) {
                  final index = entry.key;
                  final d = entry.value;
                  final isSelected = selectedDayIndex == index;

                  return GestureDetector(
                    onTap: () {
                      context.read<SalonDetailsCubit>().selectDay(index);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Text(
                            d['day']!,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: isSelected
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSurfaceVariant,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            d['date']!,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
