import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Dark Theme (Passenger & Driver) ──────────────────────────
  static const Color dkBg        = Color(0xFF0D0D0D);
  static const Color dkCard      = Color(0xFF1A1A1A);
  static const Color dkText      = Color(0xFFE0E0E0);
  static const Color dkSecondary = Color(0xFF9E9E9E);
  static const Color dkBtn       = Color(0xFFFFFFFF);
  static const Color dkAccent    = Color(0xFF7C4DFF);
  static const Color dkSuccess   = Color(0xFF00C853);
  static const Color dkBorder    = Color(0xFF2A2A2A);
  static const Color dkDanger    = Color(0xFFFF5252);
  static const Color dkWarn      = Color(0xFFFFB300);

  // ── Light Theme (Admin) ──────────────────────────────────────
  static const Color ltBg        = Color(0xFFF4F6F8);
  static const Color ltCard      = Color(0xFFFFFFFF);
  static const Color ltPrimary   = Color(0xFF1976D2);
  static const Color ltAccent    = Color(0xFF42A5F5);
  static const Color ltText      = Color(0xFF1A1A1A);
  static const Color ltSecondary = Color(0xFF546E7A);
  static const Color ltBorder    = Color(0xFFE0E0E0);
  static const Color ltSuccess   = Color(0xFF2E7D32);
  static const Color ltDanger    = Color(0xFFC62828);

  // ── Gradient ─────────────────────────────────────────────────
  static const LinearGradient brandGradient = LinearGradient(
    colors: [dkAccent, ltAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient avatarGradientDark = LinearGradient(
    colors: [dkAccent, ltAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient avatarGradientLight = LinearGradient(
    colors: [ltPrimary, ltAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}