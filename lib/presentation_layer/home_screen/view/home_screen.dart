import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tut_advanced_clean_arch/domain_layer/model/Ads_Model.dart';
import 'package:tut_advanced_clean_arch/domain_layer/model/product_model.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/common/state_randerer/state_renderer.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/common/state_randerer/state_renderer_impl.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/home_screen/view_model/home_view_model.dart';

import '../../../application_layer/dependency_injection.dart';
import '../../resources/color_manager.dart';
import '../../resources/value_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _homeViewModel = instance<HomeViewModel>();

  @override
  initState() {
    _homeViewModel.inputFlowState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    _homeViewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
        stream: _homeViewModel.outputFlowState,
        builder: (context, snapShot) {
          return snapShot.data
                  ?.getStateContentWidget(context, _getContentWidget(), () {
                _homeViewModel.start();
              }) ??
              _getContentWidget();
        });
  }

  Widget _getContentWidget() {
    return
      Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              ///CarouselSlider
             _getAdsWidget(),

              SizedBox(
                height: 10,
              ),
              ///Categories

              ///products
              _getProductsWidget() ,
              // _getProdcutGridView(),
            ],
          ),

    ),
      );
  }

  Widget _getAdsWidget() {
    return StreamBuilder<List<AdsModel>>(
        stream: _homeViewModel.adsOutputs,
        builder: (context, snapShot) {
          return snapShot.data != null
              ? CarouselSlider(
                  items: snapShot.data
                      ?.map((ad) => SizedBox(
                            height: AppSize.s200,
                            width: double.infinity,
                            child: Card(
                              elevation: AppSize.s1_5,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s12),
                                  side: BorderSide(
                                      color: ColorManager.primary,
                                      width: AppSize.s1)),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s12),
                                child:
                                    Image.network(ad.image, fit: BoxFit.fill),
                              ),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(autoPlay: true))
              : Container();
        });
  }

  Widget _getProductsWidget() {
 
    return StreamBuilder<List<Product>>(
      stream: _homeViewModel.productsOutputs,
      builder: (context, snapShot) {
        return snapShot.data != null
            ? _getProductCard(snapShot.data!)
            : Container(height: AppSize.s300,);
      },
    );
  }


  Widget _getProdcutGridView(/*List<Product> products*/){
    return Expanded(
      child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16),
          children: [
          Image.network('https://picsum.photos/250?image=1'),
      Image.network('https://picsum.photos/250?image=2'),
      Image.network('https://picsum.photos/250?image=3'),]
      ),
    );


    // return GridView(
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,),
    //   children: products
    //       .map((product) => Card(
    //     elevation: AppSize.s4,
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(AppSize.s12),
    //         side: BorderSide(
    //             color: ColorManager.white, width: AppSize.s1)),
    //     child: Column(
    //       children: [
    //         ClipRRect(
    //           borderRadius: BorderRadius.circular(AppSize.s12),
    //           child: Image.network(
    //             product.image,
    //             fit: BoxFit.cover,
    //             width: AppSize.s150,
    //             height: AppSize.s120,
    //           ),
    //         ),
    //         Padding(
    //             padding:
    //             const EdgeInsets.only(top: AppPadding.p8),
    //             child: Align(
    //               alignment: Alignment.center,
    //               child: Text(
    //                 product.title,
    //                 style: Theme.of(context).textTheme.bodyMedium,
    //                 textAlign: TextAlign.center,
    //               ),
    //             ))
    //       ],
    //     ),
    //   ))
    //       .toList(),
    // );
  }
  Widget _getProductCard(List<Product> products) {

    {
      if (products != null) {
        return  Container(
            height: AppSize.s200,
            margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
            child: ListView(
              children: products
                  .map((product) => Card(
                elevation: AppSize.s4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    side: BorderSide(
                        color: ColorManager.white, width: AppSize.s1)),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                        width: AppSize.s120,
                        height: AppSize.s120,
                      ),
                    ),
                    Padding(
                        padding:
                        const EdgeInsets.only(top: AppPadding.p8),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            product.title,
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ))
                  ],
                ),
              ))
                  .toList(),
            ),

        );
      } else {
        return Container();
      }
    }
  }

  @override
  dispose() {
    _homeViewModel.dispose();
  }
}
