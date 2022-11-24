import 'package:flutter/material.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/details_screen/details_screen.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/home_screen/home_screen.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/login_screen/login_screen.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/onboarding_screen/onboarding_screen.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/register_screen/register_screen.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/strings_manager.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/splach_screen/splash_screen.dart';

class Routes {
  static const splashScreen = "/"; //main page
  static const onBoardingScreen = "/onBoarding";
  static const loginScreen = "/login";
  static const registerScreen = "/register";
  static const homeScreen = "/home";
  static const detailsScreen = "/details";
}

class RoutesManager {
  static Route<dynamic> getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case (Routes.splashScreen):
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case (Routes.onBoardingScreen):
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      case (Routes.loginScreen):
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case (Routes.registerScreen):
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case (Routes.homeScreen):
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case (Routes.detailsScreen):
        return MaterialPageRoute(builder: (_) => const DetailsScreen());

      default:
        return MaterialPageRoute(builder: (_) => Scaffold(
          appBar: AppBar(
            title: Text(StringsManager.noSuchRoutes),
          ),
          body: Center(child: Text(StringsManager.noSuchRoutes),)
        ));
    }
  }
}
