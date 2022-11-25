import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/color_manager.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/image_manager.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/routes_manager.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/value_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer  ;
  
  
  _setTimer(){
    _timer = Timer(Duration(seconds: AppDurations.sec5 ), _goNext);
    
  }
  _goNext(){
    Navigator.pushReplacementNamed(context, Routes.onBoardingScreen);
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
