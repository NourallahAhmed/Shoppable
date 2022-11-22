import 'package:flutter/material.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/theme_manager.dart';


///APP CLASS
class MyApp extends StatelessWidget {

  //Named Constructor
  MyApp._internal();

  static final  MyApp  instance =   MyApp._internal();

  /*
   Factory constructors return an instance of the class, but it doesn't necessarily create a new instance.
   Factory constructors might return an instance that already exists, or a sub-class.
  */

  factory MyApp() => instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme:  getApplicationTheme(),
        home: Container());
  }
}