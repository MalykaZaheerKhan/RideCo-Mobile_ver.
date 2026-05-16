import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/constants/colors.dart';
import '../../services/auth_service.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _scale = Tween<double>(begin: 0.85, end: 1.0).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack));
    _ctrl.forward();

    // ✅ After animation, check if user is already logged in
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      _navigateBasedOnAuth();
    });
  }

  /// If user is already logged in → skip login, go straight to Home.
  /// If not → show Splash buttons (Get Started / Sign In).
  void _navigateBasedOnAuth() {
    final authService = AuthService();
    final user = authService.currentUser;

    if (user != null) {
      // Already authenticated → go to HomeScreen directly
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
    // else: stay on SplashScreen so user can tap Get Started / Sign In
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dkBg,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: ScaleTransition(
            scale: _scale,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  // Logo
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      gradient: AppColors.brandGradient,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'R',
                      style: TextStyle(
                        fontFamily: 'Syne',
                        fontSize: 44,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                          fontFamily: 'Syne',
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: AppColors.dkText,
                          letterSpacing: -1),
                      children: [
                        TextSpan(text: 'Ride'),
                        TextSpan(
                            text: 'Co',
                            style: TextStyle(color: AppColors.dkAccent)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Tap. Ride. Arrive.',
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 15,
                      color: AppColors.dkSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Spacer(flex: 2),
                  // Get Started button
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RegisterScreen())),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        gradient: AppColors.brandGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Sign In link
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LoginScreen())),
                    child: const Text(
                      'Already have an account? Sign In',
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 14,
                        color: AppColors.dkAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}