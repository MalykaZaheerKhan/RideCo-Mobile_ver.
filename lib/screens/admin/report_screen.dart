import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/custom_button.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int _period = 0;
  final _bars = [0.6, 0.5, 0.75, 0.9, 0.7, 1.0, 0.85];
  final _months = ['Sep', 'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar'];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.lightTheme,
      child: Scaffold(
        backgroundColor: AppColors.ltBg,
        appBar: AppCustomBar(
          title: 'Reports',
          isLight: true,
          actions: [
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                color: AppColors.ltBg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.ltBorder),
              ),
              child: const Icon(Icons.download_outlined, color: AppColors.ltSecondary, size: 16),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Period chips
              Row(
                children: ['Monthly', 'Weekly', 'Yearly'].asMap().entries.map((e) {
                  final active = e.key == _period;
                  return Padding(
                    padding: EdgeInsets.only(right: e.key < 2 ? 8 : 0),
                    child: GestureDetector(
                      onTap: () => setState(() => _period = e.key),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: active ? AppColors.ltPrimary : AppColors.ltCard,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: active ? AppColors.ltPrimary : AppColors.ltBorder),
                        ),
                        child: Text(e.value,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: active ? Colors.white : AppColors.ltSecondary)),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              // Revenue card
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
                    const Text('Revenue Overview — Mar 2026',
                        style: TextStyle(fontFamily: 'Syne', fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.ltText)),
                    const SizedBox(height: 8),
                    const Text('Rs 8.4M',
                        style: TextStyle(fontFamily: 'Syne', fontSize: 32, fontWeight: FontWeight.w800,
                            color: AppColors.ltText, letterSpacing: -1)),
                    const Text('↑ 18% vs Feb 2026',
                        style: TextStyle(fontSize: 13, color: AppColors.ltSuccess)),
                    const SizedBox(height: 16),
                    // Bar chart
                    SizedBox(
                      height: 80,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(_bars.length, (i) => Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: i < 6 ? 5 : 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FractionallySizedBox(
                                      heightFactor: _bars[i],
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: i == 5 ? AppColors.ltAccent : AppColors.ltPrimary.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(_months[i], style: const TextStyle(fontSize: 9, color: AppColors.ltSecondary)),
                              ],
                            ),
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              // KPI grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.6,
                children: const [
                  _ReportKpi(label: 'Total Rides', value: '32,840', change: '↑ 22% MoM', positive: true),
                  _ReportKpi(label: 'New Users', value: '1,284', change: '↑ 8% MoM', positive: true),
                  _ReportKpi(label: 'Avg Fare', value: 'Rs 256', change: '↓ 2% MoM', positive: false),
                  _ReportKpi(label: 'Cancellations', value: '3.8%', change: '↓ improving', positive: true),
                ],
              ),
              const SizedBox(height: 16),
              // Export buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      label: '📊  Export CSV',
                      variant: ButtonVariant.light,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      label: '📄  Export PDF',
                      variant: ButtonVariant.outline,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportKpi extends StatelessWidget {
  final String label, value, change;
  final bool positive;
  const _ReportKpi({required this.label, required this.value, required this.change, required this.positive});

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
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.ltSecondary)),
          const Spacer(),
          Text(value,
              style: const TextStyle(fontFamily: 'Syne', fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.ltText)),
          Text(change,
              style: TextStyle(
                  fontSize: 11,
                  color: positive ? AppColors.ltSuccess : AppColors.ltDanger)),
        ],
      ),
    );
  }
}