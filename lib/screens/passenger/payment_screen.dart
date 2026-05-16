import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/custom_button.dart';
import 'rating_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _method = 0; // 0=cash, 1=wallet, 2=card

  final _methods = const [
    {'icon': '💵', 'label': 'Cash'},
    {'icon': '👛', 'label': 'Wallet'},
    {'icon': '💳', 'label': 'Card'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dkBg,
      appBar: AppCustomBar(title: AppStrings.payment),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fare summary
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.dkCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.dkBorder),
              ),
              child: Column(
                children: [
                  const Text('Ride Summary',
                      style: TextStyle(fontFamily: 'Syne', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.dkText)),
                  const SizedBox(height: 16),
                  _FareRow(label: 'Base Fare', value: 'Rs 150'),
                  _FareRow(label: 'Distance (4.2 km)', value: 'Rs 63'),
                  _FareRow(label: 'Platform Fee', value: 'Rs 10'),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(color: AppColors.dkBorder),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total',
                          style: TextStyle(fontFamily: 'Syne', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.dkText)),
                      Text('Rs 223',
                          style: const TextStyle(fontFamily: 'Syne', fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.dkAccent)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Payment Method',
                style: TextStyle(fontFamily: 'DMSans', fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.dkSecondary)),
            const SizedBox(height: 12),
            // Method chips
            Row(
              children: List.generate(_methods.length, (i) => Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _method = i),
                  child: Container(
                    margin: EdgeInsets.only(right: i < 2 ? 10 : 0),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: _method == i ? AppColors.dkAccent.withOpacity(0.1) : AppColors.dkCard,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _method == i ? AppColors.dkAccent : AppColors.dkBorder),
                    ),
                    child: Column(
                      children: [
                        Text(_methods[i]['icon']!, style: const TextStyle(fontSize: 22)),
                        const SizedBox(height: 4),
                        Text(_methods[i]['label']!,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _method == i ? AppColors.dkAccent : AppColors.dkText)),
                      ],
                    ),
                  ),
                ),
              )),
            ),
            const SizedBox(height: 32),
            CustomButton(
              label: '${AppStrings.payNow} · Rs 223',
              variant: ButtonVariant.accent,
              onTap: () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => const RatingScreen())),
            ),
          ],
        ),
      ),
    );
  }
}

class _FareRow extends StatelessWidget {
  final String label, value;
  const _FareRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: AppColors.dkSecondary)),
          Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.dkText)),
        ],
      ),
    );
  }
}