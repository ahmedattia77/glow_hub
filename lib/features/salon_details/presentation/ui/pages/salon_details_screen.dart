import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/features/salon_details/presentation/cubit/salon_details_cubit.dart';
import 'package:glow_hub/features/salon_details/presentation/ui/widgest/booking_bottom_bar.dart';
import 'package:glow_hub/features/salon_details/presentation/ui/widgest/calendar_picker_widget.dart';
import 'package:glow_hub/features/salon_details/presentation/ui/widgest/salon_categories_row.dart';
import 'package:glow_hub/features/salon_details/presentation/ui/widgest/salon_image_header.dart';
import 'package:glow_hub/features/salon_details/presentation/ui/widgest/salon_info_section.dart';
import 'package:glow_hub/features/salon_details/presentation/ui/widgest/salon_services_list.dart';
import 'package:glow_hub/features/salon_details/presentation/ui/widgest/service_type_toggle.dart';
import 'package:glow_hub/features/salon_details/presentation/ui/widgest/time_slots_grid.dart';

class SalonDetailsScreen extends StatelessWidget {
  final String salonId;

  const SalonDetailsScreen({super.key, required this.salonId});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: BlocBuilder<SalonDetailsCubit, SalonDetailsState>(
        builder: (context, state) {
          if (state is SalonDetailsLoading) {
            return Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            );
          } else if (state is SalonDetailsError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: Colors.red, fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
            );
          } else if (state is SalonDetailsLoaded) {
            final salon = state.salonDetails;

            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SalonImageHeader(imageUrl: salon.imageUrl),
                ),

                Positioned(
                  top: 240.h,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 12,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 100.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SalonInfoSection(
                              name: salon.name,
                              rating: salon.rating,
                            ),
                            SizedBox(height: 20.h),
                            SalonCategoriesRow(categories: salon.categories),
                            SizedBox(height: 20.h),
                            SalonServicesList(services: salon.services),
                            SizedBox(height: 20.h),
                            const CalendarPickerWidget(),
                            SizedBox(height: 20.h),
                            const TimeSlotsGrid(),
                            SizedBox(height: 20.h),
                            const ServiceTypeToggle(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BookingBottomBar(salon: salon),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
