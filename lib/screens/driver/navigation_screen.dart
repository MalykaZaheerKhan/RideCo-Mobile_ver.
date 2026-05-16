import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../utils/helpers.dart';
import '../../widgets/custom_button.dart';
import 'driver_home_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  bool _arrivedAtPickup = false;
  bool _rideStarted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dkBg,
      body: Stack(
        children: [
          // Full screen map
          Helpers.mapPlaceholder(label: 'TURN-BY-TURN NAVIGATION'),
          // Top instruction bar
          SafeArea(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.dkCard,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.dkBorder),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.dkAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.turn_left, color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _arrivedAtPickup ? 'Heading to Destination' : 'Head to Pickup',
                              style: const TextStyle(fontFamily: 'Syne', fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.dkText),
                            ),
                            Text(
                              _arrivedAtPickup ? 'Gulberg III, Lahore' : 'Model Town, Lahore',
                              style: const TextStyle(fontSize: 12, color: AppColors.dkSecondary),
                            ),
                          ],
                        ),
                      ),
                      const Text('1.2 km',
                          style: TextStyle(fontFamily: 'Syne', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.dkAccent)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Bottom actions
          Positioned(
            left: 0, right: 0, bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
              decoration: const BoxDecoration(
                color: AppColors.dkCard,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                border: Border(top: BorderSide(color: AppColors.dkBorder)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ETA Strip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _NavStat(label: 'ETA', value: '8 min'),
                      _NavStat(label: 'Distance', value: '3.1 km'),
                      _NavStat(label: 'Speed', value: '42 km/h'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (!_arrivedAtPickup)
                    CustomButton(
                      label: AppStrings.arrivedAtPickup,
                      variant: ButtonVariant.accent,
                      onTap: () => setState(() => _arrivedAtPickup = true),
                    )
                  else if (!_rideStarted)
                    CustomButton(
                      label: AppStrings.startRide,
                      variant: ButtonVariant.success,
                      onTap: () => setState(() => _rideStarted = true),
                    )
                  else
                    CustomButton(
                      label: AppStrings.completeRide,
                      variant: ButtonVariant.accent,
                      onTap: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const DriverHomeScreen()),
                              (_) => false),
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

class _NavStat extends StatelessWidget {
  final String label, value;
  const _NavStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.dkSecondary)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(fontFamily: 'Syne', fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.dkText)),
      ],
    );
  }
}