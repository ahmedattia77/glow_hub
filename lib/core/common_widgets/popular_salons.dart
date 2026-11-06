import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/features/home/presentation/ui/cubit/home_client_cubit.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/salon_item_card.dart';
import '../../../../../../core/theme/app_colors.dart';

class PopularSalons extends StatelessWidget {
  const PopularSalons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeClientCubit, HomeClientState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const SizedBox(
            height: 220,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primaryLight),
            ),
          );
        } else if (state is HomeLoadedState) {
          if (state.salons.isEmpty) {
            return const SizedBox(
              height: 150,
              child: Center(
                child: Text(
                  'No salons available right now.',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            );
          }

          return SizedBox(
            height: 200.h,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 20),
              scrollDirection: Axis.horizontal,
              itemCount: state.salons.length,
              itemBuilder: (context, index) {
                final salon = state.salons[index];
                return SalonItemCard(salon: salon);
              },
            ),
          );
        } else if (state is HomeErrorState) {
          return SizedBox(
            height: 150,
            child: Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
