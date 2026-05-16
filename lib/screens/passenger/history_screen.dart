import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/ride_card.dart';

class RideHistoryScreen extends StatelessWidget {
  const RideHistoryScreen({super.key});

  static const _rides = [
    {'from': 'Model Town', 'to': 'Gulberg III', 'date': 'Today, 10:30 AM', 'fare': '223', 'status': 'completed'},
    {'from': 'DHA Phase 5', 'to': 'Allama Iqbal Airport', 'date': 'Yesterday, 6:15 AM', 'fare': '580', 'status': 'completed'},
    {'from': 'Liberty Market', 'to': 'Johar Town', 'date': '14 Apr, 3:00 PM', 'fare': '195', 'status': 'cancelled'},
    {'from': 'Bahria Town', 'to': 'Model Town', 'date': '13 Apr, 9:20 AM', 'fare': '410', 'status': 'completed'},
    {'from': 'Gulberg', 'to': 'Fortress Stadium', 'date': '12 Apr, 7:45 PM', 'fare': '130', 'status': 'completed'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dkBg,
      appBar: AppCustomBar(title: AppStrings.rideHistory),
      body: Column(
        children: [
          // Filter chips
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: [
                _FilterChip(label: 'All', active: true),
                const SizedBox(width: 8),
                _FilterChip(label: 'Completed'),
                const SizedBox(width: 8),
                _FilterChip(label: 'Cancelled'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _rides.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final r = _rides[i];
                return RideCard(
                  from: r['from']!,
                  to: r['to']!,
                  date: r['date']!,
                  fare: r['fare']!,
                  status: r['status']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool active;
  const _FilterChip({required this.label, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: active ? AppColors.dkAccent : AppColors.dkCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: active ? AppColors.dkAccent : AppColors.dkBorder),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: active ? Colors.white : AppColors.dkSecondary)),
    );
  }
}