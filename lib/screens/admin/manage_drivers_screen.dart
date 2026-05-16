import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/app_theme.dart';
import '../../utils/helpers.dart';
import '../../widgets/app_bar.dart';

class ManageDriversScreen extends StatelessWidget {
  const ManageDriversScreen({super.key});

  static const _drivers = [
    {'name': 'Ahmad Hassan', 'plate': 'LEA-2847', 'rating': '4.8', 'trips': '843', 'status': 'online'},
    {'name': 'Rana Asif', 'plate': 'LEC-9032', 'rating': '4.6', 'trips': '502', 'status': 'offline'},
    {'name': 'Bilal Khan', 'plate': 'LZP-1120', 'rating': '4.3', 'trips': '210', 'status': 'online'},
    {'name': 'Usman Noor', 'plate': 'LEZ-7731', 'rating': '4.9', 'trips': '1280', 'status': 'busy'},
    {'name': 'Salman Malik', 'plate': 'LEB-3344', 'rating': '2.1', 'trips': '40', 'status': 'blocked'},
  ];

  Color _statusColor(String s) {
    switch (s) {
      case 'online': return AppColors.ltSuccess;
      case 'busy': return const Color(0xFFF57F17);
      case 'blocked': return AppColors.ltDanger;
      default: return AppColors.ltSecondary;
    }
  }

  String _statusTagType(String s) {
    switch (s) {
      case 'online': return 'success';
      case 'busy': return 'warn';
      case 'blocked': return 'danger';
      default: return 'neutral';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.lightTheme,
      child: Scaffold(
        backgroundColor: AppColors.ltBg,
        appBar: AppCustomBar(title: 'Manage Drivers', isLight: true),
        body: Column(
          children: [
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
                    Text('Search drivers…', style: TextStyle(color: Color(0xFFB0BEC5), fontSize: 14)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _drivers.length,
                separatorBuilder: (_, __) => const Divider(height: 0, color: AppColors.ltBorder),
                itemBuilder: (context, i) {
                  final d = _drivers[i];
                  return Container(
                    color: AppColors.ltCard,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Helpers.buildAvatar(d['name']![0], size: 44, isLight: true),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(d['name']!,
                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.ltText)),
                              Text('★ ${d['rating']} · ${d['trips']} trips',
                                  style: const TextStyle(fontSize: 12, color: AppColors.ltSecondary)),
                              const SizedBox(height: 4),
                              Row(children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.ltBg,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: AppColors.ltBorder),
                                  ),
                                  child: Text(d['plate']!,
                                      style: const TextStyle(fontFamily: 'JetBrainsMono', fontSize: 10, color: AppColors.ltSecondary)),
                                ),
                                const SizedBox(width: 8),
                                Helpers.buildTag(
                                    d['status']![0].toUpperCase() + d['status']!.substring(1),
                                    type: _statusTagType(d['status']!),
                                    isLight: true),
                              ]),
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