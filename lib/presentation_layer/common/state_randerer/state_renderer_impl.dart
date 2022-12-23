import 'package:tut_advanced_clean_arch/presentation_layer/common/state_randerer/state_renderer.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/resources/strings_manager.dart';

abstract class FlowState{
  StateRendererType getStateRendererType();
  String getMessage();
}

//4 types

class LoadingState extends FlowState{
  StateRendererType stateRendererType;
  String message;

  LoadingState({ required this.stateRendererType, this.message = AppStrings.loading});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ErrorState extends FlowState{
  StateRendererType stateRendererType;
  String message;

  ErrorState({ required this.stateRendererType, required this.message });

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class EmptyState extends FlowState{
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.fullScreenEmptyState;
}

class ContentState extends FlowState{

  ContentState();

  @override
  String getMessage() => AppStrings.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}