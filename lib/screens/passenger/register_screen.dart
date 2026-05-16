import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController            = TextEditingController();
  final _emailController           = TextEditingController();
  final _passwordController        = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService               = AuthService();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    final name     = _nameController.text.trim();
    final email    = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm  = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
      _showSnack('Please fill in all fields.', isError: true);
      return;
    }
    if (password != confirm) {
      _showSnack('Passwords do not match.', isError: true);
      return;
    }
    if (password.length < 6) {
      _showSnack('Password must be at least 6 characters.', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    final error = await _authService.registerPassenger(email, password);

    setState(() => _isLoading = false);

    if (error != null) {
      _showSnack(error, isError: true);
    } else {
      _showSnack('Account created! Please verify your email.', isError: false);
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
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
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.dkCard,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.dkBorder),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new,
                      size: 14, color: AppColors.dkText),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                AppStrings.createAccount,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: 30),
              ),
              const SizedBox(height: 6),
              const Text(
                'Sign up to start riding',
                style: TextStyle(color: AppColors.dkSecondary, fontSize: 14),
              ),
              const SizedBox(height: 36),
              CustomInput(
                label: AppStrings.fullName,
                hint: 'Ahmad Raza',
                controller: _nameController,
                prefix: const Icon(Icons.person_outline,
                    size: 18, color: AppColors.dkSecondary),
              ),
              const SizedBox(height: 16),
              CustomInput(
                label: AppStrings.email,
                hint: '*****@example.com',
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
              const SizedBox(height: 16),
              CustomInput(
                label: AppStrings.confirmPassword,
                hint: '••••••••',
                obscure: true,
                controller: _confirmPasswordController,
                prefix: const Icon(Icons.lock_outline,
                    size: 18, color: AppColors.dkSecondary),
              ),
              const SizedBox(height: 28),
              CustomButton(
                label: _isLoading ? 'Creating Account…' : AppStrings.createAccount,
                variant: ButtonVariant.accent,
                onTap: _isLoading ? null : _handleSignUp,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(AppStrings.alreadyAccount,
                      style: TextStyle(
                          color: AppColors.dkSecondary, fontSize: 14)),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LoginScreen())),
                    child: const Text(
                      AppStrings.signIn,
                      style: TextStyle(
                          color: AppColors.dkAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}