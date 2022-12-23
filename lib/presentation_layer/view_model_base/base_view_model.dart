import 'dart:async';


import '../common/state_randerer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModeOutputs{

  //stream for the flowState for all viewModels

  final StreamController<FlowState> _flowStateStreamController = StreamController.broadcast();

  @override
  dispose() {
    _flowStateStreamController.close();
  }

  @override
  Sink<FlowState> inputFlowState() => _flowStateStreamController.sink;

  @override
  Stream<FlowState> outputFlowState() =>
      _flowStateStreamController.stream.map((flowState) => flowState);
}

abstract class BaseViewModelInputs{
  void start();
  void dispose();
  Sink<FlowState> inputFlowState();
}


abstract class BaseViewModeOutputs{
  Stream<FlowState> outputFlowState();

}

