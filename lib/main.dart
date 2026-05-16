import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'services/auth_service.dart';
import 'screens/passenger/splash_screen.dart';
import 'screens/passenger/login_screen.dart';
import 'screens/passenger/home_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const RideCoApp());
}
class RideCoApp extends StatelessWidget {
  const RideCoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RideCo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const SplashScreen(),
    );
  }
}

/// AuthWrapper — listens to Firebase auth state and auto-routes.
/// Passenger role only. Driver & Admin have their own login flows.
///
/// Usage: replace SplashScreen's navigation target with AuthWrapper
/// for the passenger flow, or call it directly after splash.
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        // ⏳ Firebase is still initialising
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // ✅ Logged in → go straight to HomeScreen
        if (snapshot.hasData && snapshot.data != null) {
          return const HomeScreen();
        }

        // ❌ Not logged in → show LoginScreen
        return const LoginScreen();
      },
    );
  }
}