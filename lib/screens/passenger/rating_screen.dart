import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../utils/helpers.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/custom_button.dart';
import 'home_screen.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _stars = 0;
  final List<String> _tags = ['Friendly', 'Safe Driving', 'On Time', 'Clean Car', 'Professional'];
  final Set<int> _selectedTags = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dkBg,
      appBar: AppCustomBar(title: AppStrings.rateYourRide, showBack: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Driver avatar
            Helpers.buildAvatar('AH', size: 72),
            const SizedBox(height: 12),
            const Text('Ahmad Hassan',
                style: TextStyle(fontFamily: 'Syne', fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.dkText)),
            const SizedBox(height: 4),
            const Text('Toyota Corolla · LEA-2847',
                style: TextStyle(fontSize: 13, color: AppColors.dkSecondary)),
            const SizedBox(height: 32),
            const Text(AppStrings.howWasYourTrip,
                style: TextStyle(fontFamily: 'Syne', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.dkText)),
            const SizedBox(height: 20),
            // Stars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) => GestureDetector(
                onTap: () => setState(() => _stars = i + 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(
                    i < _stars ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: i < _stars ? AppColors.dkWarn : AppColors.dkBorder,
                    size: 36,
                  ),
                ),
              )),
            ),
            const SizedBox(height: 24),
            // Tags
            Wrap(
              spacing: 8, runSpacing: 8,
              alignment: WrapAlignment.center,
              children: List.generate(_tags.length, (i) => GestureDetector(
                onTap: () => setState(() {
                  if (_selectedTags.contains(i)) _selectedTags.remove(i);
                  else _selectedTags.add(i);
                }),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: _selectedTags.contains(i) ? AppColors.dkAccent.withOpacity(0.12) : AppColors.dkCard,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: _selectedTags.contains(i) ? AppColors.dkAccent : AppColors.dkBorder),
                  ),
                  child: Text(_tags[i],
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _selectedTags.contains(i) ? AppColors.dkAccent : AppColors.dkText)),
                ),
              )),
            ),
            const SizedBox(height: 24),
            // Comment
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.dkBg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.dkBorder),
              ),
              child: const Row(
                children: [
                  Icon(Icons.chat_bubble_outline, color: AppColors.dkSecondary, size: 16),
                  SizedBox(width: 10),
                  Text('Add a comment (optional)…',
                      style: TextStyle(color: AppColors.dkSecondary, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            CustomButton(
              label: AppStrings.submitRating,
              variant: ButtonVariant.accent,
              onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (_) => false),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (_) => false),
              child: const Text(AppStrings.skipRating,
                  style: TextStyle(color: AppColors.dkSecondary, fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}