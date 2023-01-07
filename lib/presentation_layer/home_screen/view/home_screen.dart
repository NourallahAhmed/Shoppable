import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tut_advanced_clean_arch/domain_layer/model/Ads_Model.dart';
import 'package:tut_advanced_clean_arch/domain_layer/model/product_model.dart';
import 'package:shimmer/shimmer.dart';
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
    return Center(
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
            _getProductsWidget(),
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
              : Shimmer.fromColors(
                  baseColor: ColorManager.grey,
                  highlightColor: ColorManager.darkGrey,
                  child: Container(
                    height: AppSize.s200,
                  ),
                );
        });
  }

  Widget _getProductsWidget() {
    return StreamBuilder<List<Product>>(
      stream: _homeViewModel.productsOutputs,
      builder: (context, snapShot) {
        return snapShot.data != null
            ? _getProductCard(snapShot.data!)
            : Shimmer.fromColors(
                baseColor: ColorManager.grey,
                highlightColor: ColorManager.darkGrey,
                child: Container(
                  height: AppSize.s300,
                ),
              );
      },
    );
  }

  Widget _getProductCard(List<Product> products) {
    if (products != null) {
      return Padding(
        padding: const EdgeInsets.only(
            left: AppPadding.p12, right: AppPadding.p12, top: AppPadding.p12),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
              crossAxisCount: AppSize.s2,
              crossAxisSpacing: AppSize.s8,
              mainAxisSpacing: AppSize.s8,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(products.length, (index) {
                return InkWell(
                  onTap: () {
                    // navigate to store details screen
                    // Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
                  },
                  child: SizedBox(
                    height: AppSize.s500,
                    child: Card(

                      elevation: AppSize.s4,
                      child: Column(
                        children: [
                          Image.network(
                            products[index].image,
                            fit: BoxFit.fill,
                            height: AppSize.s90,
                          ),
                          Text( products[index].title.trim() , style: Theme.of(context).textTheme.titleMedium,)
                        ],
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  dispose() {
    _homeViewModel.dispose();
  }
}
