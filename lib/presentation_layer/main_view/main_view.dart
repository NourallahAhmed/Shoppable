import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/home_screen/view/home_screen.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/product_details_screen/view/details_screen.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/color_manager.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/strings_manager.dart';

import '../category_screen/view/category_screen.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  ///List of pages
  List<Widget> pages = [
    const HomeScreen(),
    const CategoryScreen()
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
          Icon(Icons.category_outlined, size: 30 ,  color: ColorManager.white,),
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
