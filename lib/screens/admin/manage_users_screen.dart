import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/app_theme.dart';
import '../../utils/helpers.dart';
import '../../widgets/app_bar.dart';

class ManageUsersScreen extends StatelessWidget {
  const ManageUsersScreen({super.key});

  static const _users = [
    {'name': 'Ayesha Khan', 'phone': '+92-301-1234567', 'rating': '4.8', 'trips': '34', 'status': 'active'},
    {'name': 'Zara Malik', 'phone': '+92-303-9876543', 'rating': '4.5', 'trips': '12', 'status': 'active'},
    {'name': 'Omar Farooq', 'phone': '+92-321-5554433', 'rating': '4.2', 'trips': '7', 'status': 'active'},
    {'name': 'Salman Khan', 'phone': '+92-300-1112233', 'rating': '2.1', 'trips': '40', 'status': 'blocked'},
    {'name': 'Hina Rehman', 'phone': '+92-312-6677889', 'rating': '4.9', 'trips': '58', 'status': 'active'},
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.lightTheme,
      child: Scaffold(
        backgroundColor: AppColors.ltBg,
        appBar: AppCustomBar(title: 'Manage Users', isLight: true),
        body: Column(
          children: [
            // Search
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.ltCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.ltBorder),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Color(0xFFB0BEC5), size: 18),
                    SizedBox(width: 10),
                    Text('Search users…', style: TextStyle(color: Color(0xFFB0BEC5), fontSize: 14)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _users.length,
                separatorBuilder: (_, __) => const Divider(height: 0, color: AppColors.ltBorder),
                itemBuilder: (context, i) {
                  final u = _users[i];
                  final blocked = u['status'] == 'blocked';
                  return Container(
                    color: AppColors.ltCard,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Helpers.buildAvatar(u['name']![0], size: 44, isLight: true),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(u['name']!,
                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.ltText)),
                              Text('★ ${u['rating']} · ${u['trips']} trips',
                                  style: const TextStyle(fontSize: 12, color: AppColors.ltSecondary)),
                              const SizedBox(height: 4),
                              Helpers.buildTag(
                                  blocked ? 'Blocked' : 'Active',
                                  type: blocked ? 'danger' : 'success',
                                  isLight: true),
                            ],
                          ),
                        ),
                        Container(
                          width: 32, height: 32,
                          decoration: BoxDecoration(
                            color: AppColors.ltBg,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.ltBorder),
                          ),
                          child: const Icon(Icons.more_horiz, color: AppColors.ltSecondary, size: 16),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}