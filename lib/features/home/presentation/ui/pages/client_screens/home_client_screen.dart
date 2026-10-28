import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/features/home/data/repo/salon_repo.dart';
import 'package:glow_hub/features/home/presentation/ui/cubit/home_client_cubit.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/curved_home_header.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/salon_item_card.dart';
import '../../../../../../core/theme/app_colors.dart';

class HomeClientScreen extends StatefulWidget {
  const HomeClientScreen({super.key});

  @override
  State<HomeClientScreen> createState() => _HomeClientScreenState();
}

class _HomeClientScreenState extends State<HomeClientScreen> {
  late final HomeClientCubit _homeClientCubit;
  @override
  void initState() {
    super.initState();
    _homeClientCubit = HomeClientCubit(SalonRepo())..fetchSalons();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeClientCubit,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CurvedHomeHeader(),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 90,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          _CategoryItem(icon: Icons.face, label: 'Hair'),
                          _CategoryItem(
                            icon: Icons.back_hand_outlined,
                            label: 'Nails',
                          ),
                          _CategoryItem(
                            icon: Icons.brush_outlined,
                            label: 'Makeup',
                          ),
                          _CategoryItem(icon: Icons.spa_outlined, label: 'Spa'),
                          _CategoryItem(
                            icon: Icons.local_offer_outlined,
                            label: 'Offers',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: AppColors.buttonGradientLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '50% OFF',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'GLOW HUB SPECIAL',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Valid this week',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.auto_awesome,
                        size: 60,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular Near Salons',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(color: AppColors.primaryLight),
                      ),
                    ),
                  ],
                ),
              ),

              BlocBuilder<HomeClientCubit, HomeClientState>(
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return const SizedBox(
                      height: 220,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryLight,
                        ),
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
                      height: 220.h,
                      child: SizedBox(
                        height: 240.h,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(left: 20),
                          scrollDirection: Axis.horizontal,
                          itemCount: state.salons.length,
                          itemBuilder: (context, index) {
                            final salon = state.salons[index];
                            return SalonItemCard(salon: salon);
                          },
                        ),
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
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _CategoryItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryLight, size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
