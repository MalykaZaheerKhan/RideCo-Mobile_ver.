import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../utils/helpers.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/custom_button.dart';
import 'navigation_screen.dart';

class RideRequestScreen extends StatelessWidget {
  const RideRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dkBg,
      appBar: AppCustomBar(title: AppStrings.newRideRequest),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Passenger info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.dkCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.dkBorder),
              ),
              child: Row(
                children: [
                  Helpers.buildAvatar('AK'),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ayesha Khan',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.dkText)),
                        SizedBox(height: 2),
                        Row(children: [
                          Icon(Icons.star, color: AppColors.dkWarn, size: 12),
                          SizedBox(width: 4),
                          Text('4.6 · 23 trips',
                              style: TextStyle(fontSize: 12, color: AppColors.dkSecondary)),
                        ]),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.dkAccent.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Eco',
                        style: TextStyle(color: AppColors.dkAccent, fontWeight: FontWeight.w600, fontSize: 13)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Route & Fare
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
                    children: [
                      Column(
                        children: [
                          Container(width: 10, height: 10,
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.dkSuccess)),
                          Container(width: 1, height: 28, color: AppColors.dkBorder,
                              margin: const EdgeInsets.symmetric(vertical: 3)),
                          Container(width: 10, height: 10,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColors.dkAccent)),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Pickup', style: TextStyle(fontSize: 11, color: AppColors.dkSecondary)),
                            const Text('Model Town, Lahore',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.dkText)),
                            const SizedBox(height: 18),
                            const Text('Drop', style: TextStyle(fontSize: 11, color: AppColors.dkSecondary)),
                            const Text('Gulberg III, Lahore',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.dkText)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(color: AppColors.dkBorder),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _InfoCol(label: 'Distance', value: '4.2 km'),
                      _InfoCol(label: 'ETA Pickup', value: '5 min'),
                      _InfoCol(label: 'Fare', value: 'Rs 220'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Accept / Decline
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    label: AppStrings.decline,
                    variant: ButtonVariant.outline,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    label: AppStrings.accept,
                    variant: ButtonVariant.success,
                    onTap: () => Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => const NavigationScreen())),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCol extends StatelessWidget {
  final String label, value;
  const _InfoCol({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.dkSecondary)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontFamily: 'Syne', fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.dkText)),
      ],
    );
  }
}