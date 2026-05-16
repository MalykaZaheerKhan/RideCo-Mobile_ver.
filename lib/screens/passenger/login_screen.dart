import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import '../driver/login_screen.dart';
import '../admin/login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

    final error = await _authService.loginPassenger(email, password);

    setState(() => _isLoading = false);

    if (error != null) {
      _showSnack(error, isError: true);
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
      );
    }
  }

  Future<void> _handleForgotPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      _showSnack('Enter your email above first.', isError: true);
      return;
    }
    final error = await _authService.resetPassword(email);
    if (error != null) {
      _showSnack(error, isError: true);
    } else {
      _showSnack('Password reset email sent! Check your inbox.', isError: false);
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
              const SizedBox(height: 24),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                      fontFamily: 'Syne',
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.dkText),
                  children: [
                    TextSpan(text: 'Ride'),
                    TextSpan(
                        text: 'Co',
                        style: TextStyle(color: AppColors.dkAccent)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                AppStrings.welcomeBack,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: 30),
              ),
              const SizedBox(height: 6),
              const Text(
                AppStrings.loginSubtitle,
                style: TextStyle(color: AppColors.dkSecondary, fontSize: 14),
              ),
              const SizedBox(height: 36),
              CustomInput(
                label: 'Email',
                hint: 'ahmad@example.com',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                prefix: const Icon(Icons.email_outlined,
                    size: 18, color: AppColors.dkSecondary),
              ),
              const SizedBox(height: 16),
              CustomInput(
                label: AppStrings.password,
                hint: '••••••••',
                obscure: true,
                controller: _passwordController,
                prefix: const Icon(Icons.lock_outline,
                    size: 18, color: AppColors.dkSecondary),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: _handleForgotPassword,
                  child: const Text(
                    AppStrings.forgotPassword,
                    style: TextStyle(
                      color: AppColors.dkAccent,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              CustomButton(
                label: _isLoading ? 'Logging in…' : AppStrings.login,
                onTap: _isLoading ? null : _handleLogin,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(AppStrings.noAccount,
                      style: TextStyle(
                          color: AppColors.dkSecondary, fontSize: 14)),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RegisterScreen())),
                    child: const Text(
                      AppStrings.register,
                      style: TextStyle(
                          color: AppColors.dkAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(children: const [
                Expanded(child: Divider(color: AppColors.dkBorder)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('or',
                      style: TextStyle(
                          color: AppColors.dkSecondary, fontSize: 13)),
                ),
                Expanded(child: Divider(color: AppColors.dkBorder)),
              ]),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const DriverLoginScreen())),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.dkBorder),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.drive_eta_outlined,
                          color: AppColors.dkSecondary, size: 18),
                      SizedBox(width: 10),
                      Text('Login as Driver',
                          style: TextStyle(
                              color: AppColors.dkText,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AdminLoginScreen())),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.dkBorder),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.admin_panel_settings_outlined,
                          color: AppColors.dkSecondary, size: 18),
                      SizedBox(width: 10),
                      Text('Login as Admin',
                          style: TextStyle(
                              color: AppColors.dkText,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}