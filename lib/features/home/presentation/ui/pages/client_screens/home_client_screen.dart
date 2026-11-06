import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glow_hub/core/common_widgets/curved_app_header.dart';
import 'package:glow_hub/core/common_widgets/popular_salons.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/client_widgets/category_item.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/client_widgets/home_client_offers_banner.dart';
import 'package:glow_hub/features/home/data/repo/salon_repo.dart';
import 'package:glow_hub/features/home/presentation/ui/cubit/home_client_cubit.dart';
import 'package:glow_hub/features/home/presentation/ui/widgets/salon_item_card.dart';
import '../../../../../../core/theme/app_colors.dart';

class HomeClientScreen extends StatefulWidget {
  const HomeClientScreen({super.key});

  @override
  State<HomeClientScreen> createState() => _HomeClientScreenState();
}

class _HomeClientScreenState extends State<HomeClientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurvedAppHeader(
              showNotification: true,
              notificationCount: 3,
              titleWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.white70,
                        size: 18.sp,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Location',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white70,
                        size: 18,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Cairo, Egypt',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              bottomChild: TextField(
                onTap: () => null,
                decoration: InputDecoration(
                  hintText: 'Search salons, services...',
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 90,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        CategoryItem(icon: Icons.face, label: 'Hair'),
                        CategoryItem(
                          icon: Icons.back_hand_outlined,
                          label: 'Nails',
                        ),
                        CategoryItem(
                          icon: Icons.brush_outlined,
                          label: 'Makeup',
                        ),
                        CategoryItem(icon: Icons.spa_outlined, label: 'Spa'),
                        CategoryItem(
                          icon: Icons.local_offer_outlined,
                          label: 'Offers',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),
            HomeClientOffersBanner(),
            SizedBox(height: 25.w),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Salons',
                    style: TextStyle(
                      fontSize: 18.sp,
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

            PopularSalons(),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
