import 'package:flutter/material.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/color_manager.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/strings_manager.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/value_manager.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;
  late final List<OnBoardingComponent> _widgetList = _getList();


  @override
  initState(){
    super.initState();
    _getList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: PageView.builder(
          controller: _controller,
          onPageChanged: (index){
            setState((){
              _currentPage = index;
            });
          },
          itemCount: _widgetList.length,
          itemBuilder: (context , index){
              return _widgetList[index];
      }),
      bottomSheet: Container(
      color: ColorManager.white,
      height: AppSize.s100,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child:  Text(
                StringsManager.skip,
                textAlign: TextAlign.end,
              ),
            ),
          )

          // widgets indicator and arrows
        ],
      ),
    ),
    );
  }

  List<OnBoardingComponent> _getList() {
    return [
      OnBoardingComponent(icon:  Icons.shopping_bag_outlined, txt:  StringsManager.onBoarding1,),
      OnBoardingComponent(icon:  Icons.delivery_dining, txt:  StringsManager.onBoarding2,),
      OnBoardingComponent(icon:  Icons.shopping_cart_outlined, txt:  StringsManager.onBoarding3,),
    ];
  }
}

class OnBoardingComponent extends StatelessWidget {

  String txt;
  IconData icon;

   OnBoardingComponent({
    required this.icon,
     required this.txt,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppPadding.p14),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: ColorManager.white),
            child: Icon(
              this.icon,
              color: ColorManager.primary,
              size: AppSize.s100,
            ),
          ),
          SizedBox(height: AppSize.s18,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(txt , ),
          ),
        ],
      ),
    );
  }
}
