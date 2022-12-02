import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tut_advanced_clean_arch/domain_layer/model/onboarding_models.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/onboarding_screen/viewmodel/onboarding_view_model.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/color_manager.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/image_manager.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/strings_manager.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/value_manager.dart';

import '../../resources/routes_manager.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController(initialPage: 0);
  final OnboardingViewModel _viewModel = OnboardingViewModel();
  @override
  initState() {
    _viewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderObjectView>(
        stream: _viewModel.onboardingOutputs ,   /// listen to the stream
        builder: (context , snapshot){
          return _getOnboardingContent(snapshot.data);
        });
  }


  Widget _getOnboardingContent(SliderObjectView? sliderObjectView){
    if (sliderObjectView == null ){
      return Container();

    }
    else {
      return  Scaffold(
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
              _viewModel.onPageChange(index);
            },
            itemCount: sliderObjectView.numOfSliders,
            itemBuilder: (context, index) {
              return OnBoardingComponent(
                sliderObject: sliderObjectView.sliderObject,
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
                  child: _getBottonSheetWidget(sliderObjectView))
            ],
          ),
        ),
      );

    }
  }

  Widget _getBottonSheetWidget(SliderObjectView sliderObjectView){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
            padding: EdgeInsets.all(AppPadding.p8),
            child: IconButton(onPressed: () {
                _controller.animateToPage(_viewModel.previousPage(), duration: Duration(milliseconds: AppDurations.millsec), curve: Curves.bounceInOut);

                }, icon: Icon(IconManager.backArrow ,color: ColorManager.primary,)) ,
        ),

        Row(

          children: [
            for( int i = 0 ; i < sliderObjectView.numOfSliders ; i++ )
              Padding(

                padding: const EdgeInsets.all(AppPadding.p8),
                child: _getCirlcesWidget(i , sliderObjectView.currentIndex),
              ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(AppPadding.p8),
          child: IconButton(onPressed: () {
            _controller.animateToPage( _viewModel.nextPage(), duration: Duration(milliseconds: AppDurations.millsec), curve: Curves.bounceInOut);

          }, icon: Icon(IconManager.nextArrow , color: ColorManager.primary,)) ,
        )


      ],
    );
  }


  Widget _getCirlcesWidget( int index , int currentPage){

    if ( index == currentPage){
      return Icon(IconManager.hollowCircle , size: AppSize.s14, color:  ColorManager.primary,);
    }
    else{
      return Icon(IconManager.solidCircle , size: AppSize.s14,  color:  ColorManager.primary,);
    }
  }

  @override
  dispose(){
    _viewModel.dispose();
    super.dispose();
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


