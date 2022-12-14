import 'package:flutter/material.dart';
import '/presentation_layer/resources/routes_manager.dart';
import '/presentation_layer/resources/theme_manager.dart';
import '/presentation_layer/splach_screen/splash_screen.dart';


///APP CLASS
class MyApp extends StatelessWidget {

  //Named Constructor
  const MyApp._internal();

  static const  MyApp  instance =   MyApp._internal();

  /*
   Factory constructors return an instance of the class, but it doesn't necessarily create a new instance.
   Factory constructors might return an instance that already exists, or a sub-class.
  */

  factory MyApp() => instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesManager.getRoutes ,
        initialRoute: Routes.splashScreen,
        theme:  getApplicationTheme(),
        home: const SplashScreen());
  }
}
