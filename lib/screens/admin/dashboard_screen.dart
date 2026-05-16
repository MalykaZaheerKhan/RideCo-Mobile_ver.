import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/theme/app_theme.dart';
import '../../services/auth_service.dart';
import '../../utils/helpers.dart';
import 'manage_users_screen.dart';
import 'manage_drivers_screen.dart';
import 'report_screen.dart';
import 'manage_rides_screen.dart';
import '../passenger/login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _navIndex = 0;
  final _authService = AuthService();              // ✅ auth service

  final _navLabels = ['Dashboard', 'Users', 'Drivers', 'Rides', 'Reports'];
  final _navIcons = [
    Icons.dashboard_outlined,
    Icons.people_outline,
    Icons.drive_eta_outlined,
    Icons.wb_iridescent_outlined,
    Icons.bar_chart_outlined,
  ];

  Future<void> _handleLogout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Log Out',
            style: TextStyle(fontFamily: 'Syne', color: AppColors.ltText)),
        content: const Text('Are you sure you want to log out?',
            style: TextStyle(color: AppColors.ltSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Log Out',
                style: TextStyle(
                    color: AppColors.ltDanger,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _authService.signOut();
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
    return Theme(
      data: AppTheme.lightTheme,
      child: Scaffold(
        backgroundColor: AppColors.ltBg,
        appBar: AppBar(
          backgroundColor: AppColors.ltCard,
          elevation: 0,
          title: RichText(
            text: const TextSpan(
              style: TextStyle(
                  fontFamily: 'Syne',
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ltText),
              children: [
                TextSpan(text: 'Ride'),
                TextSpan(text: 'Co',
                    style: TextStyle(color: AppColors.ltPrimary)),
                TextSpan(text: ' Admin',
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.ltSecondary,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          actions: [
            // ✅ Logout button — calls Firebase signOut
            IconButton(
              icon: const Icon(Icons.logout,
                  color: AppColors.ltSecondary, size: 20),
              onPressed: _handleLogout,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.ltPrimary,
                child: const Text('A',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              color: AppColors.ltCard,
              child: Row(
                children: List.generate(_navLabels.length, (i) => Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (i == 1) Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageUsersScreen()));
                      else if (i == 2) Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageDriversScreen()));
                      else if (i == 3) Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageRidesScreen()));
                      else if (i == 4) Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: _navIndex == i
                                  ? AppColors.ltPrimary
                                  : Colors.transparent,
                              width: 2),
                        ),
                      ),
                      child: Column(children: [
                        Icon(_navIcons[i],
                            size: 16,
                            color: _navIndex == i
                                ? AppColors.ltPrimary
                                : AppColors.ltSecondary),
                        const SizedBox(height: 2),
                        Text(_navLabels[i],
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: _navIndex == i
                                    ? AppColors.ltPrimary
                                    : AppColors.ltSecondary)),
                      ]),
                    ),
                  ),
                )),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.4,
                children: const [
                  _KpiCard(label: 'Total Rides Today', value: '1,052', change: '↑ 8%',  changePositive: true,  icon: Icons.route),
                  _KpiCard(label: 'Active Drivers',    value: '24',    change: '↑ 3 online', changePositive: true,  icon: Icons.drive_eta),
                  _KpiCard(label: "Today's Revenue",   value: 'Rs 2.4L', change: '↑ 12%', changePositive: true,  icon: Icons.payments),
                  _KpiCard(label: 'Cancellations',     value: '3.8%',  change: '↓ 0.3%', changePositive: true,  icon: Icons.cancel),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.ltBorder),
                ),
                clipBehavior: Clip.hardEdge,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      color: AppColors.ltCard,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Live Rides',
                              style: TextStyle(
                                  fontFamily: 'Syne',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.ltText)),
                          Row(children: [
                            CircleAvatar(
                                radius: 5,
                                backgroundColor: AppColors.ltSuccess),
                            SizedBox(width: 6),
                            Text('24 Active',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.ltSuccess,
                                    fontWeight: FontWeight.w600)),
                          ]),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 160,
                      child: Stack(children: [
                        Helpers.mapPlaceholder(
                            isLight: true,
                            label: 'LIVE MAP · 24 RIDES',
                            height: 160),
                        const Positioned(top: 40, left: 80,
                            child: Text('🚗', style: TextStyle(fontSize: 14))),
                        const Positioned(top: 70, left: 180,
                            child: Text('🚗', style: TextStyle(fontSize: 14))),
                        const Positioned(top: 100, right: 80,
                            child: Text('🚗', style: TextStyle(fontSize: 14))),
                      ]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.ltCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.ltBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Recent Activity',
                        style: TextStyle(
                            fontFamily: 'Syne',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.ltText)),
                    const SizedBox(height: 12),
                    ...[
                      {'msg': 'New driver registered: Bilal Khan',  'time': '2 min ago',  'type': 'primary'},
                      {'msg': 'Ride #R4821 completed · Rs 320',     'time': '5 min ago',  'type': 'success'},
                      {'msg': 'User report filed — Salman M.',       'time': '18 min ago', 'type': 'danger'},
                    ].map((a) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(children: [
                        Helpers.buildTag('',
                            type: a['type']!.toString(), isLight: true),
                        const SizedBox(width: 12),
                        Expanded(
                            child: Text(a['msg']!,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.ltText))),
                        Text(a['time']!,
                            style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.ltSecondary)),
                      ]),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String label, value, change;
  final bool changePositive;
  final IconData icon;
  const _KpiCard(
      {required this.label,
        required this.value,
        required this.change,
        required this.changePositive,
        required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Icon(icon, size: 18, color: AppColors.ltSecondary),
              Text(change,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: changePositive
                          ? AppColors.ltSuccess
                          : AppColors.ltDanger)),
            ],
          ),
          const Spacer(),
          Text(value,
              style: const TextStyle(
                  fontFamily: 'Syne',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ltText,
                  letterSpacing: -0.5)),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(
                  fontSize: 11, color: AppColors.ltSecondary)),
        ],
      ),
    );
  }
}