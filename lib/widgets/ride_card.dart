import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../core/constants/strings.dart';

class RideCard extends StatelessWidget {
  final String from;
  final String to;
  final String date;
  final String fare;
  final String status; // 'completed' | 'cancelled' | 'ongoing'

  const RideCard({
    super.key,
    required this.from,
    required this.to,
    required this.date,
    required this.fare,
    required this.status,
  });

  Color get _statusColor {
    switch (status) {
      case 'cancelled': return AppColors.dkDanger;
      case 'ongoing':   return AppColors.dkWarn;
      default:          return AppColors.dkSuccess;
    }
  }

  Color get _statusBg {
    switch (status) {
      case 'cancelled': return AppColors.dkDanger.withOpacity(0.12);
      case 'ongoing':   return AppColors.dkWarn.withOpacity(0.12);
      default:          return AppColors.dkSuccess.withOpacity(0.12);
    }
  }

  String get _statusLabel {
    switch (status) {
      case 'cancelled': return 'Cancelled';
      case 'ongoing':   return 'Ongoing';
      default:          return 'Completed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Text(
                date,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.dkSecondary,
                  fontFamily: 'DMSans',
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: _statusBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _statusColor.withOpacity(0.3)),
                ),
                child: Text(
                  _statusLabel,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Route
          Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 10, height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.dkSuccess,
                    ),
                  ),
                  Container(
                    width: 1, height: 24,
                    color: AppColors.dkBorder,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                  ),
                  Container(
                    width: 10, height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppColors.dkAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      from,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.dkText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      to,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.dkText,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${AppStrings.rupee} $fare',
                style: const TextStyle(
                  fontFamily: 'Syne',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dkText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}