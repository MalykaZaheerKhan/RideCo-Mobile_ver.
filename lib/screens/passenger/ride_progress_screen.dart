import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../utils/helpers.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/custom_button.dart';
import 'payment_screen.dart';

class RideProgressScreen extends StatelessWidget {
  const RideProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dkBg,
      appBar: AppCustomBar(
        title: AppStrings.rideInProgress,
        showBack: false,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.dkDanger.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.dkDanger.withOpacity(0.4)),
            ),
            child: const Text('SOS',
                style: TextStyle(color: AppColors.dkDanger, fontWeight: FontWeight.w700, fontSize: 12)),
          ),
        ],
      ),
      body: Column(
        children: [
          // Map with route
          SizedBox(
            height: 320,
            child: Stack(
              children: [
                Helpers.mapPlaceholder(label: 'LIVE ROUTE', height: 320),
                // Route line visual
                Positioned(
                  top: 100, left: 120,
                  child: Container(
                    width: 100, height: 2,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [AppColors.dkSuccess, AppColors.dkAccent]),
                    ),
                  ),
                ),
                const Positioned(top: 90, left: 115,
                    child: Text('📍', style: TextStyle(fontSize: 16))),
                const Positioned(top: 90, right: 115,
                    child: Text('🚗', style: TextStyle(fontSize: 20))),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Progress card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.dkCard,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.dkBorder),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              const Text('ETA', style: TextStyle(fontSize: 11, color: AppColors.dkSecondary)),
                              const Text('12 min',
                                  style: TextStyle(fontFamily: 'Syne', fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.dkAccent)),
                            ]),
                            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                              const Text('Distance', style: TextStyle(fontSize: 11, color: AppColors.dkSecondary)),
                              const Text('4.2 km',
                                  style: TextStyle(fontFamily: 'Syne', fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.dkText)),
                            ]),
                          ],
                        ),
                        const SizedBox(height: 14),
                        // Progress bar
                        Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.dkBorder,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: 0.45,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.dkAccent,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Pickup', style: TextStyle(fontSize: 11, color: AppColors.dkSecondary)),
                            Text('45% complete', style: TextStyle(fontSize: 11, color: AppColors.dkAccent)),
                            Text('Drop', style: TextStyle(fontSize: 11, color: AppColors.dkSecondary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Driver info row
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.dkCard,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.dkBorder),
                    ),
                    child: Row(
                      children: [
                        Helpers.buildAvatar('AH'),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ahmad Hassan', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.dkText)),
                              Text('Toyota Corolla · LEA-2847', style: TextStyle(fontSize: 12, color: AppColors.dkSecondary)),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(
                              color: AppColors.dkAccent.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.dkAccent.withOpacity(0.3)),
                            ),
                            child: const Icon(Icons.phone, color: AppColors.dkAccent, size: 16),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(
                              color: AppColors.dkBg,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.dkBorder),
                            ),
                            child: const Icon(Icons.chat_bubble_outline, color: AppColors.dkSecondary, size: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Share location
                  CustomButton(
                    label: '📍  Share Location',
                    variant: ButtonVariant.outline,
                    onTap: () {},
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    label: 'Complete Ride →',
                    variant: ButtonVariant.accent,
                    onTap: () => Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => const PaymentScreen())),
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