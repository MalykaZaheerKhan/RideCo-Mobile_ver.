import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../services/auth_service.dart';
import '../../utils/helpers.dart';
import '../../widgets/bottom_nav.dart';
import 'ride_request_screen.dart';
import 'earning_screen.dart';
import 'profile_screen.dart';
import '../passenger/login_screen.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  bool _online = false;
  int _navIndex = 0;
  final _authService = AuthService();              // ✅ auth service

  Future<void> _handleLogout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.dkCard,
        title: const Text('Log Out',
            style: TextStyle(color: AppColors.dkText, fontFamily: 'Syne')),
        content: const Text('Are you sure you want to log out?',
            style: TextStyle(color: AppColors.dkSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.dkSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Log Out',
                style: TextStyle(
                    color: AppColors.dkDanger,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _authService.signOut();       // ✅ updated
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _handleLogout();
      },
      child: Scaffold(
        backgroundColor: AppColors.dkBg,
        body: _navIndex == 0 ? _buildHome() : const SizedBox(),
        bottomNavigationBar: AppBottomNav(
          currentIndex: _navIndex,
          isDriver: true,
          onTap: (i) {
            if (i == 2) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const EarningsScreen()));
            } else if (i == 3) {
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (_) => const DriverProfileScreen()));
            } else {
              setState(() => _navIndex = i);
            }
          },
        ),
      ),
    );
  }

  Widget _buildHome() {
    return Column(
      children: [
        // ── Top bar ──────────────────────────────────────────────
        SafeArea(
          bottom: false,
          child: Container(
            color: AppColors.dkBg,
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        fontFamily: 'Syne',
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.dkText),
                    children: [
                      const TextSpan(text: 'Ride'),
                      TextSpan(
                          text: 'Co',
                          style: TextStyle(
                              color: _online
                                  ? AppColors.dkSuccess
                                  : AppColors.dkAccent)),
                    ],
                  ),
                ),
                const Spacer(),
                Helpers.buildAvatar('DR'),
                // ✅ Logout → Firebase signOut
                IconButton(
                  icon: const Icon(Icons.logout,
                      color: AppColors.dkSecondary, size: 20),
                  onPressed: _handleLogout,
                ),
              ],
            ),
          ),
        ),

        // ── Map + bottom sheet ────────────────────────────────────
        Expanded(
          child: Stack(
            children: [
              Helpers.mapPlaceholder(label: 'DRIVER MAP VIEW'),
              Positioned(
                left: 0, right: 0, bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.dkCard,
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(28)),
                    border:
                    Border(top: BorderSide(color: AppColors.dkBorder)),
                  ),
                  padding:
                  const EdgeInsets.fromLTRB(24, 16, 24, 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Container(
                          width: 40, height: 4,
                          decoration: BoxDecoration(
                              color: AppColors.dkBorder,
                              borderRadius: BorderRadius.circular(2)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _online
                                      ? AppStrings.youAreOnline
                                      : AppStrings.youAreOffline,
                                  style: TextStyle(
                                    fontFamily: 'Syne',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: _online
                                        ? AppColors.dkSuccess
                                        : AppColors.dkText,
                                  ),
                                ),
                                Text(
                                  _online
                                      ? 'Ready to accept rides'
                                      : 'Toggle to start earning',
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.dkSecondary),
                                ),
                              ]),
                          GestureDetector(
                            onTap: () =>
                                setState(() => _online = !_online),
                            child: Container(
                              width: 60, height: 32,
                              decoration: BoxDecoration(
                                color: _online
                                    ? AppColors.dkSuccess
                                    : AppColors.dkBorder,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: _online
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              padding: const EdgeInsets.all(3),
                              child: Container(
                                width: 26, height: 26,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _StatBox(label: "Today's Trips", value: '12'),
                          const SizedBox(width: 10),
                          _StatBox(
                              label: "Today's Earning",
                              value: 'Rs 2,840'),
                          const SizedBox(width: 10),
                          _StatBox(label: 'Rating', value: '4.8 ⭐'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (_online)
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                  const RideRequestScreen())),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.dkSuccess.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: AppColors.dkSuccess
                                      .withOpacity(0.3)),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.notifications_active,
                                    color: AppColors.dkSuccess, size: 20),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text('New Ride Request!',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: AppColors.dkSuccess)),
                                      Text('Tap to view details',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                              AppColors.dkSecondary)),
                                    ],
                                  ),
                                ),
                                Icon(Icons.chevron_right,
                                    color: AppColors.dkSuccess, size: 18),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label, value;
  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.dkBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.dkBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 10, color: AppColors.dkSecondary)),
            const SizedBox(height: 4),
            Text(value,
                style: const TextStyle(
                    fontFamily: 'Syne',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.dkText)),
          ],
        ),
      ),
    );
  }
}