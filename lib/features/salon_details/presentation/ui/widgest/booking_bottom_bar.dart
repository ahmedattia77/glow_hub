import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/features/salon_details/data/model/salon_details_model.dart';
import 'package:glow_hub/features/salon_details/data/repo/booking_repo.dart';
import 'package:glow_hub/features/salon_details/presentation/cubit/salon_details_cubit.dart';

class BookingBottomBar extends StatelessWidget {
  final SalonDetailsModel salon;

  const BookingBottomBar({super.key, required this.salon});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final bool isSalonOwner = currentUserId == salon.ownerId;

    return BlocBuilder<SalonDetailsCubit, SalonDetailsState>(
      builder: (context, state) {
        double totalPrice = 0.0;
        bool hasSelectedServices = false;
        bool hasSelectedTimeSlot = false;

        if (state is SalonDetailsLoaded) {
          hasSelectedServices = state.selectedServiceIndices.isNotEmpty;
          hasSelectedTimeSlot = state.selectedTimeSlot != null;

          for (var index in state.selectedServiceIndices) {
            if (index < salon.services.length) {
              final service = salon.services[index]; // ServiceModel
              final double originalPrice = service.price;
              final double? discount = service.discount;

              final double finalPrice = (discount != null && discount > 0)
                  ? (originalPrice - discount)
                  : originalPrice;

              totalPrice += finalPrice;
            }
          }
        }

        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),

              isSalonOwner
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'This is your salon',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber[800],
                        ),
                      ),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        padding: EdgeInsets.symmetric(
                          horizontal: 32.w,
                          vertical: 14.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        if (!hasSelectedServices) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please select at least one service!',
                              ),
                            ),
                          );
                          return;
                        }

                        if (!hasSelectedTimeSlot) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a time slot!'),
                            ),
                          );
                          return;
                        }

                        if (state is SalonDetailsLoaded) {
                          context.read<SalonDetailsCubit>().confirmBooking(
                            salonId: salon.salonId,
                            bookingRepo: BookingRepo(),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Booking Confirmed Successfully!'),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Confirm Booking',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
