import 'package:Shoppable/presentation_layer/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import '/application_layer/dependency_injection.dart';
import '/domain_layer/model/product_model.dart';
import '/presentation_layer/common/state_randerer/state_renderer_impl.dart';
import '/presentation_layer/product_details_screen/view_model/product_details_view_model.dart';
import '/presentation_layer/resources/color_manager.dart';

import '../../resources/value_manager.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final ProductDetailsViewModel _productDetailsViewModel =
      instance<ProductDetailsViewModel>();
  final List<String> sizes = [
    AppStrings.xSmall,
    AppStrings.small,
    AppStrings.medium,
    AppStrings.large,
    AppStrings.xLarge,
    AppStrings.xxLarge,
  ];

  @override
  initState() {
    _productDetailsViewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
        stream: _productDetailsViewModel.outputFlowState,
        builder: (context, snapShot) {
          return snapShot.data
                  ?.getStateContentWidget(context, _getContentWidget(), () {
                _productDetailsViewModel.start();
              }) ??
              _getContentWidget();
        });
  }

  Widget _getContentWidget() {
    return StreamBuilder<Product>(
        stream: _productDetailsViewModel.productDetailsOutputs,
        builder: (context, snapShot) {
          if (snapShot.data != null) {
            return Container(
              color: ColorManager.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ///image
                    Padding(
                      padding: const EdgeInsets.only(
                          top: AppPadding.p20,
                          right: AppPadding.p28,
                          left: AppPadding.p28),
                      child: Card(
                        elevation: AppSize.s4,
                        shadowColor: ColorManager.primary,
                        color: ColorManager.white,
                        child: Image.network(
                          snapShot.data!.image,
                          height: AppSize.s200,
                          width: double.infinity,
                        ),
                      ),
                    ),

                    ///  title - price - rate
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Flexible(
                            child: Text(
                              snapShot.data!.title,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                        ),

                        ///price - rate
                        Padding(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      AppStrings.egp,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: AppPadding.p2),
                                        child: Text(
                                          snapShot.data!.price.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge,
                                        ),
                                      ))
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(AppPadding.p8),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                      snapShot.data!.rating.rate.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    ///Colors

                    ///Size
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: AppPadding.p8),
                            child: Text(
                              AppStrings.size,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: AppSize.s60,

                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sizes.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    // height: AppSize.s20,
                                    width: AppSize.s90,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: AppPadding.p8,
                                          right: AppPadding.p8),
                                      child: ElevatedButton(
                                          autofocus: true,
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.zero,
                                                      side: BorderSide(color: ColorManager.darkGrey)
                                                  )
                                              ),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      ColorManager.white),
                                              overlayColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color?>(
                                                (Set<MaterialState> states) {
                                                  if (states.contains(
                                                      MaterialState.pressed))
                                                    return ColorManager.primary;
                                                  return null;
                                                },
                                              )),
                                          onPressed: () {},
                                          child: Text(
                                            sizes[index],
                                            style: TextStyle(
                                                color: ColorManager.grey),
                                          )),
                                    ),
                                  );
                                }))
                      ],
                    ),

                    /// desc
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        AppStrings.description,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    Text(
                      snapShot.data!.description,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),

                    ///Button add to cart
                    SizedBox(
                      height: AppSize.s50,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            _productDetailsViewModel.addToCart(snapShot.data!);
                          },
                          child: Text(AppStrings.addToCart)),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container(
              color: ColorManager.white,
            );
          }
        });
  }

  @override
  dispose() {
    _productDetailsViewModel.dispose();
    super.dispose();
  }
}
