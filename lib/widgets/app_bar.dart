import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

class AppCustomBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final bool isLight;
  final List<Widget>? actions;
  final Widget? leading;

  const AppCustomBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.isLight = false,
    this.actions,
    this.leading,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final bg     = isLight ? AppColors.ltCard : AppColors.dkBg;
    final border = isLight ? AppColors.ltBorder : AppColors.dkBorder;
    final fg     = isLight ? AppColors.ltText : AppColors.dkText;
    final iconFg = isLight ? AppColors.ltSecondary : AppColors.dkSecondary;

    return Container(
      height: preferredSize.height + MediaQuery.of(context).padding.top,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        color: bg,
        border: Border(bottom: BorderSide(color: border)),
      ),
      child: Row(
        children: [
          if (showBack)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: GestureDetector(
                onTap: () => Navigator.maybePop(context),
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: isLight ? AppColors.ltBg : AppColors.dkCard,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: border),
                  ),
                  child: Icon(Icons.arrow_back_ios_new, size: 14, color: iconFg),
                ),
              ),
            )
          else
            leading ?? const SizedBox(width: 52),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Syne',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: fg,
                letterSpacing: -0.3,
              ),
            ),
          ),
          if (actions != null)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(children: actions!),
            )
          else
            const SizedBox(width: 52),
        ],
      ),
    );
  }
}