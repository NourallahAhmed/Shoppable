import 'package:flutter/material.dart';
import 'package:tut_advanced_clean_arch/application_layer/dependency_injection.dart';
import 'package:tut_advanced_clean_arch/domain_layer/model/product_model.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/common/state_randerer/state_renderer_impl.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/product_details_screen/view_model/product_details_view_model.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/color_manager.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/value_manager.dart';

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
          if (snapShot != null) {
            return Expanded(
              child: Container(
                color: ColorManager.white,
                child: Column(
                  children: [
                    Image.network(
                      snapShot.data!.image,
                      height: AppSize.s150,
                    ),
                    Text(
                      snapShot.data!.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          snapShot.data!.price.toString(),
                          style: Theme.of(context).textTheme.titleLarge,
                        )),
                    Text(
                      snapShot.data!.category,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      snapShot.data!.description,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
