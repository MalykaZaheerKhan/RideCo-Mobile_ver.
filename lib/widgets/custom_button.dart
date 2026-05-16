import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

enum ButtonVariant { primary, accent, outline, danger, success, light }

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final ButtonVariant variant;
  final bool isSmall;
  final Widget? leading;

  const CustomButton({
    super.key,
    required this.label,
    this.onTap,
    this.variant = ButtonVariant.primary,
    this.isSmall = false,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final double height = isSmall ? 40 : 52;
    final double fontSize = isSmall ? 13 : 15;
    final double radius = isSmall ? 8 : 12;

    Color bg;
    Color fg;
    Border? border;

    switch (variant) {
      case ButtonVariant.accent:
        bg = AppColors.dkAccent; fg = Colors.white; border = null;
      case ButtonVariant.outline:
        bg = Colors.transparent; fg = AppColors.dkText;
        border = Border.all(color: AppColors.dkBorder);
      case ButtonVariant.danger:
        bg = AppColors.dkDanger; fg = Colors.white; border = null;
      case ButtonVariant.success:
        bg = AppColors.dkSuccess; fg = Colors.white; border = null;
      case ButtonVariant.light:
        bg = AppColors.ltPrimary; fg = Colors.white; border = null;
      case ButtonVariant.primary:
        bg = AppColors.dkBtn; fg = AppColors.dkBg; border = null;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(radius),
          border: border,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 8)],
            Text(
              label,
              style: TextStyle(
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w600,
                fontSize: fontSize,
                color: fg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}