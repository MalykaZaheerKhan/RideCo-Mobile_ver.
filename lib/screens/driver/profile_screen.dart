import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../utils/helpers.dart';
import '../../widgets/app_bar.dart';

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dkBg,
      appBar: AppCustomBar(title: 'Driver Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Avatar & name
            Helpers.buildAvatar('AH', size: 80),
            const SizedBox(height: 12),
            const Text('Ahmad Hassan',
                style: TextStyle(fontFamily: 'Syne', fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.dkText)),
            const SizedBox(height: 4),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.star, color: AppColors.dkWarn, size: 16),
              const SizedBox(width: 4),
              const Text('4.8 · 843 trips',
                  style: TextStyle(fontSize: 14, color: AppColors.dkSecondary)),
            ]),
            const SizedBox(height: 6),
            Helpers.buildTag('Verified Driver', type: 'success'),
            const SizedBox(height: 24),
            // Vehicle card
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
                  const Text('Vehicle Details',
                      style: TextStyle(fontFamily: 'Syne', fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.dkText)),
                  const SizedBox(height: 14),
                  _ProfileRow(icon: Icons.directions_car_outlined, label: 'Model', value: 'Toyota Corolla 2020'),
                  _ProfileRow(icon: Icons.palette_outlined, label: 'Color', value: 'Silver'),
                  _ProfileRow(icon: Icons.confirmation_number_outlined, label: 'Plate', value: 'LEA-2847'),
                  _ProfileRow(icon: Icons.category_outlined, label: 'Type', value: 'Eco / Comfort'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Stats
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
                  const Text('Performance',
                      style: TextStyle(fontFamily: 'Syne', fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.dkText)),
                  const SizedBox(height: 14),
                  _ProfileRow(icon: Icons.bar_chart, label: 'Total Trips', value: '843'),
                  _ProfileRow(icon: Icons.access_time, label: 'Member Since', value: 'Jan 2024'),
                  _ProfileRow(icon: Icons.cancel_outlined, label: 'Cancellation Rate', value: '2.1%'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _ProfileRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.dkSecondary),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontSize: 13, color: AppColors.dkSecondary)),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.dkText)),
        ],
      ),
    );
  }
}