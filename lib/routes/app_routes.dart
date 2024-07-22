import 'package:flutter_full_auth/features/authentication/screens/login/login.dart';
import 'package:flutter_full_auth/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:flutter_full_auth/features/authentication/screens/pswd_config/forgot_password.dart';
import 'package:flutter_full_auth/features/authentication/screens/signup/signup.dart';
import 'package:flutter_full_auth/features/authentication/screens/signup/verify_email.dart';
import 'package:flutter_full_auth/features/personalization/screens/profile/profile.dart';
import 'package:flutter_full_auth/features/personalization/screens/settings/user_settings.dart';
import 'package:flutter_full_auth/features/store/screens/home/home.dart';
import 'package:flutter_full_auth/features/store/screens/inventory/inventory.dart';
import 'package:get/get.dart';

import 'routes.dart';

class CAppRoutes {
  static final pages = [
    GetPage(
      name: CRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: CRoutes.inventory,
      page: () => const InventoryScreen(),
    ),
    GetPage(
      name: CRoutes.settings,
      page: () => const UserSettingsScreen(),
    ),
    GetPage(
      name: CRoutes.userProfile,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: CRoutes.signup,
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: CRoutes.verifyEmail,
      page: () => const VerifyEmailScreen(),
    ),
    GetPage(
      name: CRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: CRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: CRoutes.onBoarding,
      page: () => const OnboardingScreen(),
    ),
  ];
}
