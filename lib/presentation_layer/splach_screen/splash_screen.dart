import 'dart:async';

import 'package:flutter/material.dart';
import '/application_layer/app_pref.dart';
import '/application_layer/dependency_injection.dart';
import '/presentation_layer/resources/color_manager.dart';
import '/presentation_layer/resources/image_manager.dart';
import '/presentation_layer/resources/routes_manager.dart';
import '/presentation_layer/resources/value_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  Timer? _timer  ;
  
  
  _setTimer(){
    _timer = Timer(Duration(seconds: AppDurations.sec5 ), _goNext);
    
  }
  _goNext() async {
   _appPreferences.isUserLoggedIn().then((isLoggedIn) => {
     //check if user Logged in

     if(isLoggedIn ){
        Navigator.pushReplacementNamed(context, Routes.mainScreen)
     }
     else{

        _appPreferences
                  .isUserSeeOnBoardingView()
                  .then(
                (isUserViewedOnBoarding) => {
                        //check if true -> Is User see onboarding Screen
                        if (isUserViewedOnBoarding)
                          {
                            // check if true -> go home page
                            Navigator.pushReplacementNamed(
                                context, Routes.loginScreen)
                          }
                        else
                          {
                            // check if false -> go to onboarding
                            Navigator.pushReplacementNamed(
                                context, Routes.onBoardingScreen)
                          }
                      })
            }
   });






  }

  @override
  initState(){
    _setTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(child: Image.asset(ImageManager.logo),), //todo: do some animation
    );
  }

  @override
  dispose(){
    _timer?.cancel();
  }
}
