import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../widgets/app_bar.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key});

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  int _period = 0; // 0=daily, 1=weekly, 2=monthly

  final _bars = [0.5, 0.3, 0.7, 0.9, 0.6, 1.0, 0.8];
  final _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dkBg,
      appBar: AppCustomBar(title: AppStrings.earnings),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period selector
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.dkCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.dkBorder),
              ),
              child: Row(
                children: ['Daily', 'Weekly', 'Monthly'].asMap().entries.map((e) {
                  final active = e.key == _period;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _period = e.key),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: active ? AppColors.dkAccent : Colors.transparent,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        alignment: Alignment.center,
                        child: Text(e.value,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: active ? Colors.white : AppColors.dkSecondary)),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            // Total earning
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.dkCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.dkBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Today's Total", style: TextStyle(fontSize: 12, color: AppColors.dkSecondary)),
                  const SizedBox(height: 6),
                  const Text('Rs 2,840',
                      style: TextStyle(fontFamily: 'Syne', fontSize: 34, fontWeight: FontWeight.w800,
                          color: AppColors.dkText, letterSpacing: -1)),
                  const SizedBox(height: 4),
                  const Text('↑ 12% vs yesterday', style: TextStyle(fontSize: 13, color: AppColors.dkSuccess)),
                  const SizedBox(height: 20),
                  // Bar chart
                  SizedBox(
                    height: 80,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(_bars.length, (i) => Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: i < 6 ? 6 : 0),
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
                                        color: i == 5 ? AppColors.dkAccent : AppColors.dkAccent.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(_days[i],
                                  style: const TextStyle(fontSize: 10, color: AppColors.dkSecondary)),
                            ],
                          ),
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Stats grid
            Row(
              children: [
                _EarnStat(label: 'Trips', value: '12'),
                const SizedBox(width: 10),
                _EarnStat(label: 'Hours Online', value: '6.5h'),
                const SizedBox(width: 10),
                _EarnStat(label: 'Avg Fare', value: 'Rs 237'),
              ],
            ),
            const SizedBox(height: 20),
            // Recent trips
            const Text('Recent Trips',
                style: TextStyle(fontFamily: 'DMSans', fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.dkSecondary)),
            const SizedBox(height: 12),
            ...[
              {'from': 'Model Town', 'to': 'Gulberg', 'fare': '220', 'time': '10:30 AM'},
              {'from': 'DHA Phase 5', 'to': 'Airport', 'fare': '580', 'time': '7:00 AM'},
              {'from': 'Johar Town', 'to': 'Liberty', 'fare': '190', 'time': '6:15 AM'},
            ].map((t) => _TripTile(from: t['from']!, to: t['to']!, fare: t['fare']!, time: t['time']!)),
          ],
        ),
      ),
    );
  }
}

class _EarnStat extends StatelessWidget {
  final String label, value;
  const _EarnStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.dkCard,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.dkBorder),
        ),
        child: Column(children: [
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.dkSecondary)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontFamily: 'Syne', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.dkText)),
        ]),
      ),
    );
  }
}

class _TripTile extends StatelessWidget {
  final String from, to, fare, time;
  const _TripTile({required this.from, required this.to, required this.fare, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.dkCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.dkBorder),
      ),
      child: Row(
        children: [
          const Icon(Icons.route, color: AppColors.dkSecondary, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('$from → $to',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.dkText)),
              Text(time, style: const TextStyle(fontSize: 11, color: AppColors.dkSecondary)),
            ]),
          ),
          Text('Rs $fare',
              style: const TextStyle(fontFamily: 'Syne', fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.dkText)),
        ],
      ),
    );
  }
}