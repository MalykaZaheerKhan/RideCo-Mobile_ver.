import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../utils/helpers.dart';
import 'driver_assigned_screen.dart';

class SearchDriverScreen extends StatefulWidget {
  const SearchDriverScreen({super.key});

  @override
  State<SearchDriverScreen> createState() => _SearchDriverScreenState();
}

class _SearchDriverScreenState extends State<SearchDriverScreen>
    with SingleTickerProviderStateMixin {
  bool _searching = false;
  late AnimationController _pulse;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.8, end: 1.2).animate(
        CurvedAnimation(parent: _pulse, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _pulse.dispose(); super.dispose(); }

  void _confirmRide() {
    setState(() => _searching = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const DriverAssignedScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dkBg,
      appBar: AppCustomBar(title: 'Book Ride', showBack: true),
      body: Column(
        children: [
          // Map
          SizedBox(
            height: 260,
            child: Stack(
              children: [
                Helpers.mapPlaceholder(label: 'ROUTE PREVIEW', height: 260),
                // pins
                Positioned(top: 100, left: 130,
                    child: _MapPin(color: AppColors.dkSuccess)),
                Positioned(top: 150, right: 100,
                    child: _MapPin(color: AppColors.dkAccent, isSquare: true)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Route
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.dkCard,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.dkBorder),
                    ),
                    child: Column(
                      children: [
                        _RouteRow(
                          dot: Container(width: 10, height: 10,
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.dkSuccess)),
                          label: AppStrings.pickupLocation,
                          value: 'Model Town, Lahore',
                        ),
                        Container(
                            width: 1, height: 20, color: AppColors.dkBorder,
                            margin: const EdgeInsets.only(left: 4.5, top: 4, bottom: 4)),
                        _RouteRow(
                          dot: Container(width: 10, height: 10,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColors.dkAccent)),
                          label: AppStrings.dropLocation,
                          value: 'Gulberg III, Lahore',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Fare estimate
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.dkCard,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.dkBorder),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Estimated Fare',
                                style: TextStyle(fontSize: 12, color: AppColors.dkSecondary)),
                            SizedBox(height: 4),
                            Text('Rs 220 – 260',
                                style: TextStyle(fontFamily: 'Syne', fontSize: 18,
                                    fontWeight: FontWeight.w700, color: AppColors.dkText)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('ETA', style: TextStyle(fontSize: 12, color: AppColors.dkSecondary)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Text('~8 min',
                                    style: TextStyle(fontFamily: 'Syne', fontSize: 18,
                                        fontWeight: FontWeight.w700, color: AppColors.dkAccent)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Payment selector
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.dkCard,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.dkBorder),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.payments_outlined, color: AppColors.dkSecondary, size: 20),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Payment Method', style: TextStyle(fontSize: 11, color: AppColors.dkSecondary)),
                            Text('Cash on Delivery', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.dkText)),
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.chevron_right, color: AppColors.dkSecondary, size: 18),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (_searching)
                    Center(
                      child: Column(
                        children: [
                          ScaleTransition(
                            scale: _pulseAnim,
                            child: Container(
                              width: 64, height: 64,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.dkAccent.withOpacity(0.15),
                                border: Border.all(color: AppColors.dkAccent.withOpacity(0.4)),
                              ),
                              child: const Icon(Icons.search, color: AppColors.dkAccent, size: 28),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(AppStrings.searchingDriver,
                              style: TextStyle(color: AppColors.dkSecondary, fontSize: 13)),
                        ],
                      ),
                    )
                  else
                    CustomButton(
                      label: AppStrings.confirmRide,
                      variant: ButtonVariant.accent,
                      onTap: _confirmRide,
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

class _RouteRow extends StatelessWidget {
  final Widget dot;
  final String label, value;
  const _RouteRow({required this.dot, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        dot,
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 11, color: AppColors.dkSecondary)),
              Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.dkText)),
            ],
          ),
        ),
      ],
    );
  }
}

class _MapPin extends StatelessWidget {
  final Color color;
  final bool isSquare;
  const _MapPin({required this.color, this.isSquare = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14, height: 14,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(isSquare ? 2 : 7),
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }
}