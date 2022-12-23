import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/image_manager.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/value_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/style_manager.dart';

enum StateRendererType {
  popupLoadingState,
  popupErrorState,
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
  contentState
}

class StateRenderer extends StatelessWidget {
  // 4 inputs needed

  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionFunction;

  StateRenderer(
      {required this.stateRendererType,
      this.message = AppStrings.loading,
      this.title = "",
      required this.retryActionFunction});

  @override
  Widget build(BuildContext context) {
    return getStateContent(context);
  }

  Widget getStateContent(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return getPopupDialog(context, [
          getAnimatedImage(JsonManager.loadingJson),
        ]);

      case StateRendererType.popupErrorState:
        return getPopupDialog(context, [
          getAnimatedImage(JsonManager.errorJson),
          getErrorMessage(message, context),
          getButtonWidget(context , AppStrings.ok),
        ]);

      case StateRendererType.fullScreenLoadingState:
        return getFullScreenContent([getAnimatedImage(JsonManager.loadingJson)]);

      case StateRendererType.fullScreenErrorState:
        return getFullScreenContent([
          getAnimatedImage(JsonManager.errorJson),
          getErrorMessage(message, context),
          getButtonWidget(context, AppStrings.retry),
        ]);

      case StateRendererType.fullScreenEmptyState:
        return getFullScreenContent([
          getAnimatedImage(JsonManager.emptyJson),
          getButtonWidget(context, AppStrings.retry),
        ]);

      case StateRendererType.contentState:
        return Container();

      default:
        return Container();
    }
  }

  Widget getPopupDialog(BuildContext context, List<Widget> children) {
    return Dialog(
        elevation: AppSize.s1_5,
        shape : const RoundedRectangleBorder(),
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(AppSize.s1_5),
            boxShadow: [
              BoxShadow(
                color: ColorManager.lightBlack
              )
            ]
          ),
          child: _getDialogContent(children),
        ),

    );
  }

  Widget getFullScreenContent(List<Widget> children) {
    return Center(
      child: Column(
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  Widget getAnimatedImage(String animationName) {
    return SizedBox(
        height: AppSize.s100,
        width: AppSize.s100,
        child: Lottie.asset(animationName));
  }

  Widget getErrorMessage(String error, BuildContext context) {
    return SizedBox(
      child: Text(
        error,
        style: getRegularStyle(
            color: ColorManager.lightBlack,
            fontSize: AppSize.s18
        ),
      ),
    );
  }

  Widget getButtonWidget(BuildContext context , String buttonTxt) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p28),
        child: ElevatedButton(
          onPressed: () {
            if (stateRendererType == StateRendererType.fullScreenErrorState) {
              retryActionFunction.call();
            } else {

              Navigator.of(context).pop();
            }
          },
          child: Text(
            buttonTxt,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }

 Widget  _getDialogContent(List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
 }
}
