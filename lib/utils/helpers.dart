import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

class Helpers {
  Helpers._();

  // ── Status tag builder ────────────────────────────────────────
  static Widget buildTag(String label, {String type = 'neutral', bool isLight = false}) {
    Color bg, fg, border;

    if (isLight) {
      switch (type) {
        case 'success': bg = const Color(0xFFE8F5E9); fg = AppColors.ltSuccess; border = AppColors.ltSuccess.withOpacity(0.3);
        case 'danger':  bg = const Color(0xFFFFEBEE); fg = AppColors.ltDanger;  border = AppColors.ltDanger.withOpacity(0.3);
        case 'primary': bg = const Color(0xFFE3F2FD); fg = AppColors.ltPrimary; border = AppColors.ltPrimary.withOpacity(0.3);
        case 'warn':    bg = const Color(0xFFFFF8E1); fg = const Color(0xFFF57F17); border = const Color(0xFFF57F17).withOpacity(0.3);
        default:        bg = const Color(0xFFECEFF1); fg = AppColors.ltSecondary; border = AppColors.ltBorder;
      }
    } else {
      switch (type) {
        case 'success': bg = AppColors.dkSuccess.withOpacity(0.12); fg = AppColors.dkSuccess; border = AppColors.dkSuccess.withOpacity(0.25);
        case 'danger':  bg = AppColors.dkDanger.withOpacity(0.12);  fg = AppColors.dkDanger;  border = AppColors.dkDanger.withOpacity(0.25);
        case 'accent':  bg = AppColors.dkAccent.withOpacity(0.12);  fg = AppColors.dkAccent;  border = AppColors.dkAccent.withOpacity(0.25);
        case 'warn':    bg = AppColors.dkWarn.withOpacity(0.12);    fg = AppColors.dkWarn;    border = AppColors.dkWarn.withOpacity(0.25);
        default:        bg = AppColors.dkBorder.withOpacity(0.3);   fg = AppColors.dkSecondary; border = AppColors.dkBorder;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: fg,
          fontFamily: 'DMSans',
        ),
      ),
    );
  }

  // ── Avatar builder ────────────────────────────────────────────
  static Widget buildAvatar(String initials, {double size = 48, bool isLight = false}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isLight ? AppColors.avatarGradientLight : AppColors.avatarGradientDark,
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: size * 0.3,
          fontFamily: 'DMSans',
        ),
      ),
    );
  }

  // ── Map placeholder ───────────────────────────────────────────
  static Widget mapPlaceholder({bool isLight = false, String label = 'MAP VIEW', double? height}) {
    final bg    = isLight ? const Color(0xFFE8EDF2) : const Color(0xFF111111);
    final grid  = isLight ? const Color(0xFFD8DDE3) : const Color(0xFF1E1E1E);
    final tagBg = isLight ? Colors.blue.withOpacity(0.1) : AppColors.dkAccent.withOpacity(0.15);
    final tagFg = isLight ? AppColors.ltPrimary : AppColors.dkAccent;
    final tagBorder = isLight ? AppColors.ltPrimary.withOpacity(0.3) : AppColors.dkAccent.withOpacity(0.3);

    return Container(
      height: height,
      color: bg,
      child: CustomPaint(
        painter: _GridPainter(grid),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: tagBg,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: tagBorder),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'JetBrainsMono',
                fontSize: 11,
                letterSpacing: 1,
                color: tagFg,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Rupee format ──────────────────────────────────────────────
  static String formatRupee(int amount) => 'Rs $amount';

  // ── Snackbar ──────────────────────────────────────────────────
  static void showSnack(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: const TextStyle(fontFamily: 'DMSans')),
      backgroundColor: isError ? AppColors.dkDanger : AppColors.dkSuccess,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(16),
    ));
  }
}

class _GridPainter extends CustomPainter {
  final Color color;
  _GridPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) => false;
}