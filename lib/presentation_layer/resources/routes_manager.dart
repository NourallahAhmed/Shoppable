import 'package:flutter/material.dart';
import '/presentation_layer/home_screen/view/home_screen.dart';
import '/presentation_layer/login_screen/view/login_screen.dart';
import '/presentation_layer/onboarding_screen/view/onboarding_screen.dart';
import '/presentation_layer/register_screen/view/register_screen.dart';
import '/presentation_layer/resources/strings_manager.dart';
import '/presentation_layer/splach_screen/splash_screen.dart';
import '../../application_layer/dependency_injection.dart';
import '../forgetpassword_screen/view/forgetpassword_screen.dart';
import '../main_view/main_view.dart';
import '../product_details_screen/view/details_screen.dart';

class Routes {
  static const splashScreen = "/";    ///  main page
  static const mainScreen = "/main";    ///  main page
  static const onBoardingScreen = "/onBoarding";
  static const loginScreen = "/login";
  static const registerScreen = "/register";
  static const homeScreen = "/home";
  static const detailsScreen = "/details";
  static const forgetPasswordScreen = "/forgetPassword";
}

class RoutesManager {

  static String  _id = "" ;
  static setProductId(String newId) {
    _id = newId;
  }

  static Route<dynamic> getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case(Routes.mainScreen):
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());

      case (Routes.splashScreen):
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case (Routes.onBoardingScreen):

        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      case (Routes.loginScreen):

        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case (Routes.registerScreen):
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case (Routes.homeScreen):
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case (Routes.detailsScreen):

        print("id from routesManger = $_id");

        initDetailsScreen(_id);
        return MaterialPageRoute(builder: (_) => const DetailsScreen());

      case ( Routes.forgetPasswordScreen):
        initForgetPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());

      default:
        return MaterialPageRoute(builder: (_) => Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.noSuchRoutes),
          ),
          body: Center(child: Text(AppStrings.noSuchRoutes),)
        ));
    }
  }
}
