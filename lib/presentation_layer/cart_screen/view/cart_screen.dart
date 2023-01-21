import 'package:Shoppable/domain_layer/model/product_model.dart';
import 'package:Shoppable/presentation_layer/cart_screen/view_model/cart_view_model.dart';
import 'package:Shoppable/presentation_layer/common/state_randerer/state_renderer_impl.dart';
import 'package:Shoppable/presentation_layer/resources/image_manager.dart';
import 'package:Shoppable/presentation_layer/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../application_layer/dependency_injection.dart';
import '/presentation_layer/resources/color_manager.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartViewModel _cartViewModel = instance<CartViewModel>();

  initState() {
    _cartViewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
        stream: _cartViewModel.outputFlowState,
        builder: (context, snapshot) {
          return snapshot.data
                  ?.getStateContentWidget(context, _getContentWidget(), () {
                _cartViewModel.start();
              }) ??
              _getContentWidget();
        });
  }

  Widget _getContentWidget() {
    return StreamBuilder<List<Product>>(
        stream: _cartViewModel.cartStream,
        builder: (context, snapShot) {
          if (snapShot.data != null) {
            return Padding(
                padding: EdgeInsets.all(AppPadding.p8),
                child :ListView.separated(
                itemCount: snapShot.data!.length,

                itemBuilder: (context, index) {
                  return Container(
                    // padding: EdgeInsets.all(AppPadding.p12),
                    decoration: BoxDecoration(
                      color:  ColorManager.white,
                      shape:  BoxShape.rectangle,
                      border:  Border.all(width: AppSize.s1  , color:  ColorManager.lightPrimary),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(40),
                          bottomLeft:Radius.circular(10),
                          bottomRight:Radius.circular(40)
                      ),

                  ),
                    child: Row(
                      children: [
                        Card(
                          shape: const RoundedRectangleBorder(),
                          child: Image.network(
                            snapShot.data![index].image,
                            height: 90,
                            width: 90,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(AppPadding.p8),
                            child: Flexible(
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapShot.data![index].title,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(snapShot.data![index].category,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
                                  Text(snapShot.data![index].price.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall),
                                ],
                              ),
                            ))
                      ],
                    ),
                  );
                }, separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                  height: 10,
                );  },));
          } else {
            return Center(
              child: Lottie.asset(JsonManager.emptyJson),
            );
          }
        });
  }
}
