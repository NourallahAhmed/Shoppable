import 'package:flutter/material.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/common/state_randerer/state_renderer.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

//4 types

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState(
      {required this.stateRendererType, this.message = AppStrings.loading});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState({required this.stateRendererType, required this.message});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}
class SuccessState extends FlowState {
  String message;

  SuccessState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.popupSuccessState;
}

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => AppStrings.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

// the super function

extension FlowStateExtension on FlowState {

  Widget getStateContentWidget(BuildContext context,
      Widget widgetContent,
      Function retryFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          _dismissDialog(context);
          //PopUP
          if (StateRendererType.popupLoadingState == getStateRendererType()) {
            showPopUpDialog(context ,  getMessage() , getStateRendererType());
            return widgetContent;
          }
          //Full Screen
          else {
            return StateRenderer(stateRendererType: getStateRendererType(),
                retryActionFunction: (){});
          }
        }

      case EmptyState:
        {
          return StateRenderer(stateRendererType: getStateRendererType(),
              retryActionFunction: retryFunction);
        }

      case ErrorState:
        {
          _dismissDialog(context);

          //PopUP
          if (StateRendererType.popupErrorState == getStateRendererType()) {
            showPopUpDialog(context ,  getMessage() , getStateRendererType());
            return widgetContent;
          }
          //Full Screen
          else {
            return StateRenderer(stateRendererType: getStateRendererType(),
                retryActionFunction: retryFunction);
          }
        }
        case SuccessState:
        {
          _dismissDialog(context);

          //PopUP
          if (StateRendererType.popupSuccessState == getStateRendererType()) {
            showPopUpDialog(context ,  getMessage() , getStateRendererType());
            return widgetContent;
          }
          //Full Screen
          else {
            return StateRenderer(stateRendererType: getStateRendererType(),
                retryActionFunction: retryFunction);
          }
        }

      case ContentState:
        {
          _dismissDialog(context);
          return widgetContent;
        }

      default:
        _dismissDialog(context);
        return widgetContent;
    }
  }


  _dismissDialog(BuildContext context){
    if (_isWigdetContainDialog(context)){ //true means has Dialog
    Navigator.of(context , rootNavigator: true).pop(true);
    }
  }

  _isWigdetContainDialog(BuildContext context){
  return  ModalRoute.of(context)?.isCurrent != true;
  }
  showPopUpDialog(BuildContext context, String message , StateRendererType stateRendererType) {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        showDialog(
            context: context,
            builder: (context){
              return StateRenderer(stateRendererType: stateRendererType, message:  message,retryActionFunction: (){});

            }));
  }
}
