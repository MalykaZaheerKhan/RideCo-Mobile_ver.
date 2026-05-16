import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

class DriverCard extends StatelessWidget {
  final String name;
  final String vehicleModel;
  final String plate;
  final double rating;
  final String eta;
  final VoidCallback? onContact;
  final VoidCallback? onCancel;

  const DriverCard({
    super.key,
    required this.name,
    required this.vehicleModel,
    required this.plate,
    required this.rating,
    required this.eta,
    this.onContact,
    this.onCancel,
  });

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
            children: [
              // Avatar
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.avatarGradientDark,
                ),
                alignment: Alignment.center,
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : 'D',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.dkText,
                        fontFamily: 'DMSans',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      vehicleModel,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.dkSecondary,
                        fontFamily: 'DMSans',
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.dkBg,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.dkBorder),
                          ),
                          child: Text(
                            plate,
                            style: const TextStyle(
                              fontFamily: 'JetBrainsMono',
                              fontSize: 11,
                              color: AppColors.dkSecondary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.star, color: AppColors.dkWarn, size: 13),
                        const SizedBox(width: 2),
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.dkText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // ETA
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    eta,
                    style: const TextStyle(
                      fontFamily: 'Syne',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.dkAccent,
                    ),
                  ),
                  const Text(
                    'away',
                    style: TextStyle(fontSize: 11, color: AppColors.dkSecondary),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onContact,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.dkBorder),
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone, size: 14, color: AppColors.dkText),
                        SizedBox(width: 6),
                        Text('Contact',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.dkText)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: onCancel,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.dkDanger.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.dkDanger.withOpacity(0.3)),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.dkDanger),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}