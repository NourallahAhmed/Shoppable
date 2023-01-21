import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../cart_screen/view/cart_screen.dart';
import '/presentation_layer/home_screen/view/home_screen.dart';
import '/presentation_layer/resources/color_manager.dart';
import '/presentation_layer/resources/strings_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  ///List of pages
  List<Widget> pages = [
    const HomeScreen(),
    const CartScreen(),

  ];


  ///List of titles
  List<String> titles = [
    AppStrings.home,
    AppStrings.categories
  ];


  var _title = AppStrings.home;
  var _currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text(_title , style: Theme.of(context).textTheme.titleSmall)),
        body: pages[_currentIndex],


        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: ColorManager.white,
          color: ColorManager.lightPrimary,
          items: <Widget>[
            Icon(Icons.home, size: 30 , color: ColorManager.white,),
            Icon(Icons.shopping_cart, size: 30 ,  color: ColorManager.white,),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _title = titles[index];
            });
          },
        ),
        );

  }
}
