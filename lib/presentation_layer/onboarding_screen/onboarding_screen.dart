import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/color_manager.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/image_manager.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/strings_manager.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/value_manager.dart';

import '../resources/routes_manager.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;
  late final List<SliderObject> _widgetList = _getList();

  @override
  initState() {
    super.initState();
    _getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor:  ColorManager.primary,
        elevation: AppSize.s0,


        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: ColorManager.primary
        ),
      ),

      backgroundColor: ColorManager.primary,
      body: PageView.builder(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemCount: _widgetList.length,
          itemBuilder: (context, index) {
            return OnBoardingComponent(
              sliderObject: _widgetList[index],
            );
          }),
      bottomSheet: Container(

        color: ColorManager.primary,
        // height: AppSize.s120,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.loginScreen );
                },
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Text(
                    StringsManager.skip,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            )

            // widgets indicator and arrows
            ,
            Container(
                color: ColorManager.white,
                child: _getBottonSheetWidget())
          ],
        ),
      ),
    );
  }

  List<SliderObject> _getList() {
    return [
      SliderObject(
        icon: IconManager.shopingCart,
        txt: StringsManager.onBoarding1,
      ),
      SliderObject(
        icon: IconManager.deliveryIcon,
        txt: StringsManager.onBoarding3,
      ),
      SliderObject(
        icon: IconManager.shopingCart,
        txt: StringsManager.onBoarding2,
      ),
    ];
  }


  Widget _getBottonSheetWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,


      children: [

        Padding(
            padding: EdgeInsets.all(AppPadding.p8),
            child: IconButton(onPressed: () {


                _controller.animateToPage(_getPreviousIndex(), duration: Duration(milliseconds: AppDurations.millsec), curve: Curves.bounceInOut);

                }, icon: Icon(IconManager.backArrow ,color: ColorManager.primary,)) ,
        ),

        Row(

          children: [
            for( int i = 0 ; i < _widgetList.length ; i++ )
              Padding(

                padding: const EdgeInsets.all(AppPadding.p8),
                child: _getCirlcesWidget(i),
              ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(AppPadding.p8),
          child: IconButton(onPressed: () {
            _controller.animateToPage(_getNextIndex(), duration: Duration(milliseconds: AppDurations.millsec), curve: Curves.bounceInOut);

          }, icon: Icon(IconManager.nextArrow , color: ColorManager.primary,)) ,
        )


      ],
    );
  }


  int _getPreviousIndex(){
    int previousIndex =  -- _currentPage ;// to use this current decrement (don't wait to click again to use it )
    if (previousIndex == -1) previousIndex == _widgetList.length -1;
    return previousIndex;
  }

  int _getNextIndex(){
    int nextIndex = ++ _currentPage; // to use this current increment (don't wait to click again to use it )
    if (nextIndex == _widgetList.length ) nextIndex = 0;
    return nextIndex;
  }

  Widget _getCirlcesWidget( int index){

    if ( index == _currentPage){
      return Icon(IconManager.hollowCircle , size: AppSize.s14, color:  ColorManager.primary,);
    }
    else{
      return Icon(IconManager.solidCircle , size: AppSize.s14,  color:  ColorManager.primary,);
    }
  }
}

class OnBoardingComponent extends StatelessWidget {
  SliderObject sliderObject;

  OnBoardingComponent({
    required this.sliderObject,
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
              sliderObject.icon,
              color: ColorManager.primary,
              size: AppSize.s100,
            ),
          ),
          const SizedBox(
            height: AppSize.s18,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              sliderObject.txt,
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center,
            ), // how to fetch the theme.
          ),
        ],
      ),
    );
  }
}

class SliderObject {
  String txt;
  IconData icon;

  SliderObject({required this.txt, required this.icon});
}
