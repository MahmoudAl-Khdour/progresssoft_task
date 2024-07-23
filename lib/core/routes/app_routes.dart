import 'package:get/get.dart';
import 'package:progresssoft_task/features/app/presentation/screens/splash_screen.dart';
import 'package:progresssoft_task/features/auth/presentation/screens/otp_screen.dart';
import 'package:progresssoft_task/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:progresssoft_task/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:progresssoft_task/features/main/presentation/screens/home_screen.dart';
import 'package:progresssoft_task/features/main/presentation/screens/profile_screen.dart';
import 'package:progresssoft_task/features/main/presentation/widgets/base_widget.dart';

// App Routes
class AppRoutes {
  static const String base = '/';
  static const String home = '/home';
  static const String splash = '/splash';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String otp = '/otp';
  static const String profile = '/profile';

  static List<GetPage> getPages = [
    GetPage(name: base, page: () => const BaseWidget()),
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: signIn, page: () => const SignInScreen()),
    GetPage(name: signUp, page: () => const SignUpScreen()),
    GetPage(name: otp, page: () => const OTPScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
  ];
}
