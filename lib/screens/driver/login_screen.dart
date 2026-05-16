import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input.dart';
import 'driver_home_screen.dart';

class DriverLoginScreen extends StatefulWidget {
  const DriverLoginScreen({super.key});

  @override
  State<DriverLoginScreen> createState() => _DriverLoginScreenState();
}

class _DriverLoginScreenState extends State<DriverLoginScreen> {
  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService        = AuthService();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email    = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnack('Please enter your email and password.', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    final error = await _authService.loginDriver(email, password);

    setState(() => _isLoading = false);

    if (error != null) {
      _showSnack(error, isError: true);
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const DriverHomeScreen()),
            (route) => false,
      );
    }
  }

  void _showSnack(String msg, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? AppColors.dkDanger : AppColors.dkSuccess,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dkBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    color: AppColors.dkText, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 16),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                      fontFamily: 'Syne',
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.dkText),
                  children: [
                    TextSpan(text: 'Ride'),
                    TextSpan(text: 'Co',
                        style: TextStyle(color: AppColors.dkSuccess)),
                    TextSpan(text: ' Driver',
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColors.dkSecondary)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text('Driver Login',
                  style: TextStyle(
                      fontFamily: 'Syne',
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: AppColors.dkText,
                      letterSpacing: -1)),
              const SizedBox(height: 6),
              const Text('Access your driver dashboard',
                  style: TextStyle(
                      color: AppColors.dkSecondary, fontSize: 14)),
              const SizedBox(height: 36),
              CustomInput(
                label: 'Driver Email',
                hint: 'driver@rideco.pk',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                prefix: const Icon(Icons.badge_outlined,
                    size: 18, color: AppColors.dkSecondary),
              ),
              const SizedBox(height: 16),
              CustomInput(
                label: 'Password',
                hint: '••••••••',
                obscure: true,
                controller: _passwordController,
                prefix: const Icon(Icons.lock_outline,
                    size: 18, color: AppColors.dkSecondary),
              ),
              const SizedBox(height: 28),
              CustomButton(
                label: _isLoading ? 'Logging in…' : 'Login as Driver',
                variant: ButtonVariant.success,
                onTap: _isLoading ? null : _handleLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}