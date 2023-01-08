import 'package:flutter/material.dart';
import 'package:tut_advanced_clean_arch/application_layer/dependency_injection.dart';
import 'package:tut_advanced_clean_arch/domain_layer/model/product_model.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/common/state_randerer/state_renderer_impl.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/product_details_screen/view_model/product_details_view_model.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/color_manager.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/style_manager.dart';
import '../../common/state_randerer/state_renderer.dart';
import '../../resources/value_manager.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final ProductDetailsViewModel _productDetailsViewModel =
      instance<ProductDetailsViewModel>();

  @override
  initState() {
    _productDetailsViewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<FlowState>(
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
            return   Container(
              color: ColorManager.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top : AppPadding.p20 , right: AppPadding.p28 , left: AppPadding.p28),
                          child: Card(
                            elevation: AppSize.s4,
                            child: Image.network(
                              snapShot.data!.image,
                              height: AppSize.s200,
                              width:  double.infinity,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                snapShot.data!.title,
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding:  EdgeInsets.all(8.0),
                                  child: Icon(Icons.star ,color: Colors.amber,),
                                ) ,
                                Text(
                                  snapShot.data!.rating.rate.toString(),
                                  style: Theme.of(context).textTheme.displayMedium,
                                ),
                              ],
                            ),
                          ],
                        ),

                        Text(
                            snapShot.data!.description,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),


                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "${snapShot.data!.price.toString()} EGP",
                                  style: Theme.of(context).textTheme.headlineLarge,
                                )),





                      ],
                    ),
              ),
            );
          } else {
            return Container(color: ColorManager.white,);
          }
        });
  }

  @override
  dispose(){
    _productDetailsViewModel.dispose();
  }


}
