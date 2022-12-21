import 'package:flutter/material.dart';
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
          getAnimatedImage(""),
        ]);

      case StateRendererType.popupErrorState:
        return getPopupDialog(context, [
          getAnimatedImage(""),
          getErrorMessage(message, context),
          getButtonWidget(context),
        ]);

      case StateRendererType.fullScreenLoadingState:
        return getFullScreenContent([getAnimatedImage("")]);

      case StateRendererType.fullScreenErrorState:
        return getFullScreenContent([
          getAnimatedImage(""),
          getErrorMessage(message, context),
          getButtonWidget(context),
        ]);

      case StateRendererType.fullScreenEmptyState:
        return getFullScreenContent([
          getAnimatedImage(""),
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
    return Column(
      children: children,
    );
  }

  Widget getAnimatedImage(String imageName) {
    return SizedBox(
      child: Container(), //todo: lattie.assets
    );
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

  Widget getButtonWidget(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (stateRendererType == StateRendererType.fullScreenErrorState) {
            retryActionFunction.call();
          } else {
            Navigator.of(context).pop;
          }
        },
        child: Text(
          AppStrings.retry,
          style: Theme.of(context).textTheme.headlineMedium,
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
