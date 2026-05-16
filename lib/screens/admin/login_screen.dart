import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/theme/app_theme.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input.dart';
import 'dashboard_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
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
      _showSnack('Please enter admin credentials.', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    final error = await _authService.loginAdmin(email, password);  // ✅ updated

    setState(() => _isLoading = false);

    if (error != null) {
      _showSnack(error, isError: true);
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
            (route) => false,
      );
    }
  }

  void _showSnack(String msg, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? AppColors.ltDanger : AppColors.ltSuccess,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.lightTheme,
      child: Scaffold(
        backgroundColor: AppColors.ltBg,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      color: AppColors.ltText, size: 20),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 24),
                Container(
                  width: 64, height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.ltPrimary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.admin_panel_settings,
                      color: Colors.white, size: 32),
                ),
                const SizedBox(height: 24),
                const Text(AppStrings.adminLogin,
                    style: TextStyle(
                        fontFamily: 'Syne',
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ltText,
                        letterSpacing: -0.5)),
                const SizedBox(height: 6),
                const Text(
                    'Restricted access — authorized personnel only',
                    style: TextStyle(
                        fontSize: 13, color: AppColors.ltSecondary)),
                const SizedBox(height: 36),
                CustomInput(
                  label: AppStrings.adminId,
                  hint: 'admin@rideco.pk',
                  keyboardType: TextInputType.emailAddress,
                  isLight: true,
                  controller: _emailController,
                  prefix: const Icon(Icons.badge_outlined,
                      size: 18, color: AppColors.ltSecondary),
                ),
                const SizedBox(height: 16),
                CustomInput(
                  label: AppStrings.password,
                  hint: '••••••••',
                  obscure: true,
                  isLight: true,
                  controller: _passwordController,
                  prefix: const Icon(Icons.lock_outline,
                      size: 18, color: AppColors.ltSecondary),
                ),
                const SizedBox(height: 28),
                CustomButton(
                  label: _isLoading ? 'Logging in…' : 'Login to Admin Portal',
                  variant: ButtonVariant.light,
                  onTap: _isLoading ? null : _handleLogin,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}