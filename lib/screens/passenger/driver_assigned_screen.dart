import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../utils/helpers.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/driver_card.dart';
import 'ride_progress_screen.dart';

class DriverAssignedScreen extends StatelessWidget {
  const DriverAssignedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dkBg,
      appBar: AppCustomBar(title: AppStrings.driverAssigned),
      body: Column(
        children: [
          // Map
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                Helpers.mapPlaceholder(label: 'LIVE TRACKING', height: 300),
                const Positioned(
                  bottom: 16, left: 0, right: 0,
                  child: Center(
                    child: Text('🚗',
                        style: TextStyle(fontSize: 28)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status badge
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.dkSuccess.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.dkSuccess.withOpacity(0.3)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle, color: AppColors.dkSuccess, size: 14),
                          SizedBox(width: 6),
                          Text(AppStrings.driverAssigned,
                              style: TextStyle(color: AppColors.dkSuccess, fontSize: 13, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DriverCard(
                    name: 'Ahmad Hassan',
                    vehicleModel: 'Toyota Corolla · Silver',
                    plate: 'LEA-2847',
                    rating: 4.8,
                    eta: '5 min',
                    onContact: () {},
                    onCancel: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 16),
                  // OTP
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.dkCard,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.dkBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Share OTP with driver',
                            style: TextStyle(fontSize: 12, color: AppColors.dkSecondary)),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: ['4', '7', '2', '9'].map((d) => Container(
                            width: 52, height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.dkBg,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: d == '4' ? AppColors.dkAccent : AppColors.dkBorder),
                            ),
                            alignment: Alignment.center,
                            child: Text(d,
                                style: const TextStyle(
                                    fontFamily: 'JetBrainsMono',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.dkText)),
                          )).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    label: 'Ride Started →',
                    variant: ButtonVariant.accent,
                    onTap: () => Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => const RideProgressScreen())),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}