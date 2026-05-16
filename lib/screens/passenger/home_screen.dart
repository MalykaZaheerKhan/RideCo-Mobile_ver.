import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../services/auth_service.dart';
import '../../utils/helpers.dart';
import '../../widgets/bottom_nav.dart';
import 'search_driver_screen.dart';
import 'history_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;
  final _authService = AuthService();          // ✅ auth service instance

  final List<Map<String, String>> _quickDests = const [
    {'label': 'Home', 'address': 'DHA Phase 5, Lahore', 'icon': '🏠'},
    {'label': 'Work', 'address': 'Gulberg III, Lahore',  'icon': '💼'},
    {'label': 'Gym',  'address': 'Liberty Market',        'icon': '🏋'},
  ];

  // ✅ Firebase logout
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
                style: TextStyle(color: AppColors.dkDanger,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _authService.signOut();              // ✅ Firebase sign out
      if (!mounted) return;
      // ✅ Clear entire stack and go to LoginScreen
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
        body: Column(
          children: [
            // ── Top bar ──────────────────────────────────────────
            SafeArea(
              bottom: false,
              child: Container(
                color: AppColors.dkBg,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontFamily: 'Syne',
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.dkText),
                        children: [
                          TextSpan(text: 'Ride'),
                          TextSpan(
                              text: 'Co',
                              style: TextStyle(color: AppColors.dkAccent)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Helpers.buildAvatar('AR'),
                    // ✅ Logout icon — calls Firebase signOut
                    IconButton(
                      icon: const Icon(Icons.logout,
                          color: AppColors.dkSecondary, size: 20),
                      onPressed: _handleLogout,
                    ),
                  ],
                ),
              ),
            ),

            // ── Map + bottom sheet ────────────────────────────────
            Expanded(
              child: Stack(
                children: [
                  Helpers.mapPlaceholder(label: 'MAP VIEW · LAHORE'),
                  Positioned(
                    left: 0, right: 0, bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.dkCard,
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(28)),
                        border: Border(
                            top: BorderSide(color: AppColors.dkBorder)),
                      ),
                      padding:
                      const EdgeInsets.fromLTRB(24, 16, 24, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          Text(AppStrings.whereToGo,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontSize: 22)),
                          const SizedBox(height: 14),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                    const SearchDriverScreen())),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              decoration: BoxDecoration(
                                color: AppColors.dkBg,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                Border.all(color: AppColors.dkBorder),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.search,
                                      color: AppColors.dkSecondary,
                                      size: 18),
                                  SizedBox(width: 10),
                                  Text(AppStrings.searchDest,
                                      style: TextStyle(
                                          color: AppColors.dkSecondary,
                                          fontSize: 14)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _RideTypeRow(),
                          const SizedBox(height: 20),
                          const Text(AppStrings.quickDestinations,
                              style: TextStyle(
                                  fontFamily: 'DMSans',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.dkSecondary)),
                          const SizedBox(height: 12),
                          ..._quickDests.map((d) => _QuickDestTile(
                            icon: d['icon']!,
                            label: d['label']!,
                            address: d['address']!,
                          )),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: AppBottomNav(
          currentIndex: _navIndex,
          onTap: (i) {
            if (i == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const RideHistoryScreen()));
            } else {
              setState(() => _navIndex = i);
            }
          },
        ),
      ),
    );
  }
}

class _RideTypeRow extends StatefulWidget {
  @override
  State<_RideTypeRow> createState() => _RideTypeRowState();
}

class _RideTypeRowState extends State<_RideTypeRow> {
  int _selected = 0;
  final _types = const [
    {'icon': '🛵', 'name': 'Moto',    'price': 'Rs 80+'},
    {'icon': '🚗', 'name': 'Eco',     'price': 'Rs 150+'},
    {'icon': '🚙', 'name': 'Comfort', 'price': 'Rs 250+'},
    {'icon': '✨', 'name': 'Luxury',  'price': 'Rs 450+'},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_types.length, (i) {
        final active = i == _selected;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selected = i),
            child: Container(
              margin: EdgeInsets.only(right: i < 3 ? 8 : 0),
              padding: const EdgeInsets.symmetric(
                  vertical: 12, horizontal: 4),
              decoration: BoxDecoration(
                color: active
                    ? AppColors.dkAccent.withOpacity(0.08)
                    : AppColors.dkBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: active
                        ? AppColors.dkAccent
                        : AppColors.dkBorder),
              ),
              child: Column(
                children: [
                  Text(_types[i]['icon']!,
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 4),
                  Text(_types[i]['name']!,
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.dkText)),
                  Text(_types[i]['price']!,
                      style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.dkSecondary)),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _QuickDestTile extends StatelessWidget {
  final String icon, label, address;
  const _QuickDestTile(
      {required this.icon,
        required this.label,
        required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: AppColors.dkBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.dkBorder),
            ),
            alignment: Alignment.center,
            child: Text(icon, style: const TextStyle(fontSize: 18)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.dkText)),
                Text(address,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.dkSecondary)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right,
              color: AppColors.dkSecondary, size: 18),
        ],
      ),
    );
  }
}