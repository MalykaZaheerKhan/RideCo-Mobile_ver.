import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool isDriver;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.isDriver = false,
  });

  @override
  Widget build(BuildContext context) {
    final items = isDriver
        ? const [
      BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.navigation_outlined), activeIcon: Icon(Icons.navigation), label: 'Navigate'),
      BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), activeIcon: Icon(Icons.bar_chart), label: 'Earnings'),
      BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
    ]
        : const [
      BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.history), activeIcon: Icon(Icons.history), label: 'History'),
      BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.dkCard,
        border: Border(top: BorderSide(color: AppColors.dkBorder)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.dkAccent,
        unselectedItemColor: AppColors.dkSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, fontFamily: 'DMSans'),
        unselectedLabelStyle: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, fontFamily: 'DMSans'),
        items: items,
      ),
    );
  }
}