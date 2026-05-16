import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../widgets/app_bar.dart';

class ManageRidesScreen extends StatelessWidget {
  const ManageRidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rides = [
      {'id': '#R-1041', 'passenger': 'Ali Raza', 'driver': 'Usman K.', 'from': 'Gulberg', 'to': 'DHA', 'status': 'Active', 'fare': 'Rs 320'},
      {'id': '#R-1040', 'passenger': 'Sara M.', 'driver': 'Bilal A.', 'from': 'Johar Town', 'to': 'Bahria', 'status': 'Completed', 'fare': 'Rs 510'},
      {'id': '#R-1039', 'passenger': 'Hamza T.', 'driver': 'Kamran S.', 'from': 'Model Town', 'to': 'Cantt', 'status': 'Cancelled', 'fare': 'Rs 280'},
      {'id': '#R-1038', 'passenger': 'Nida F.', 'driver': 'Asad R.', 'from': 'Iqbal Town', 'to': 'Gulberg', 'status': 'Active', 'fare': 'Rs 190'},
      {'id': '#R-1037', 'passenger': 'Omar S.', 'driver': 'Tariq M.', 'from': 'DHA', 'to': 'Airport', 'status': 'Completed', 'fare': 'Rs 640'},
    ];

    return Scaffold(
      backgroundColor: AppColors.ltBg,
      appBar: AppCustomBar(title: 'Ride Monitoring', isLight: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Stats row
          Row(
            children: [
              _StatCard(label: 'Active Rides', value: '2', color: AppColors.ltPrimary),
              const SizedBox(width: 10),
              _StatCard(label: 'Today Total', value: '41', color: AppColors.ltSuccess),
              const SizedBox(width: 10),
              _StatCard(label: 'Cancelled', value: '3', color: AppColors.ltDanger),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Live & Recent Rides',
              style: TextStyle(
                  fontFamily: 'Syne',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ltText)),
          const SizedBox(height: 12),
          ...rides.map((r) => _RideRow(ride: r)),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label, value;
  final Color color;
  const _StatCard({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.ltCard,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.ltBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value,
                style: TextStyle(
                    fontFamily: 'Syne',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: color)),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.ltSecondary,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class _RideRow extends StatelessWidget {
  final Map<String, String> ride;
  const _RideRow({required this.ride});

  Color get _statusColor {
    switch (ride['status']) {
      case 'Active': return AppColors.ltPrimary;
      case 'Completed': return AppColors.ltSuccess;
      case 'Cancelled': return AppColors.ltDanger;
      default: return AppColors.ltSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.ltCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.ltBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(ride['id']!,
                  style: const TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontSize: 11,
                      color: AppColors.ltSecondary)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(ride['status']!,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _statusColor)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 13, color: AppColors.ltSecondary),
              const SizedBox(width: 4),
              Text(ride['passenger']!,
                  style: const TextStyle(fontSize: 12, color: AppColors.ltText, fontWeight: FontWeight.w600)),
              const SizedBox(width: 12),
              const Icon(Icons.drive_eta_outlined, size: 13, color: AppColors.ltSecondary),
              const SizedBox(width: 4),
              Text(ride['driver']!,
                  style: const TextStyle(fontSize: 12, color: AppColors.ltText, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.radio_button_checked, size: 11, color: AppColors.ltSuccess),
              const SizedBox(width: 4),
              Text(ride['from']!,
                  style: const TextStyle(fontSize: 11, color: AppColors.ltSecondary)),
              const SizedBox(width: 6),
              const Icon(Icons.arrow_forward, size: 11, color: AppColors.ltSecondary),
              const SizedBox(width: 6),
              const Icon(Icons.location_on_outlined, size: 11, color: AppColors.ltDanger),
              const SizedBox(width: 4),
              Text(ride['to']!,
                  style: const TextStyle(fontSize: 11, color: AppColors.ltSecondary)),
              const Spacer(),
              Text(ride['fare']!,
                  style: const TextStyle(
                      fontFamily: 'Syne',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ltText)),
            ],
          ),
        ],
      ),
    );
  }
}