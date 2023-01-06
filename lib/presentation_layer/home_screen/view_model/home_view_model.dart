import 'dart:async';
import 'dart:ffi';
import 'package:rxdart/rxdart.dart';

import 'package:tut_advanced_clean_arch/domain_layer/usecase/home_usecase/home_usecase.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/common/state_randerer/state_renderer.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/common/state_randerer/state_renderer_impl.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/view_model_base/base_view_model.dart';

import '../../../domain_layer/model/Ads_Model.dart';
import '../../../domain_layer/model/product_model.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  HomeUseCase _homeUseCase;
  AdsUseCase _adsUseCase;

  /// broadcast for multipleListener
  final _productsStreamController = BehaviorSubject<List<Product>>();
  final _adsStreamController = BehaviorSubject<List<AdsModel>>();

  HomeViewModel(this._homeUseCase, this._adsUseCase);

  @override
  void start() async {
    inputFlowState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    ///Products
    (await _homeUseCase.execute(Void)).fold(
        (l) => inputFlowState.add(ErrorState(
            stateRendererType: StateRendererType.fullScreenErrorState,
            message: l.message)), (r) {
      _productsStreamController.add(r);
      _adsStreamController.stream.map((event) {
        event.isEmpty
            ? inputFlowState.add(ContentState())
            : inputFlowState.add(LoadingState(
                stateRendererType: StateRendererType.fullScreenLoadingState));
      });
    });

    ///ADs
    (await _adsUseCase.execute(Void)).fold(
        (l) => inputFlowState.add(ErrorState(
            stateRendererType: StateRendererType.fullScreenErrorState,
            message: l.message)), (r) {
      _adsStreamController.add(r);
      _productsStreamController.stream.map((event) {
        event.isEmpty
            ? inputFlowState.add(ContentState())
            : inputFlowState.add(LoadingState(
                stateRendererType: StateRendererType.fullScreenLoadingState));
      });
    });
  }

  ///ADS
  @override
  Sink get adsInputs => _adsStreamController.sink;

  @override
  Stream<List<AdsModel>> get adsOutputs =>
      _adsStreamController.stream.map((event) => event);

  /// if true there is a data coming

  ///Products
  @override
  Sink get productsInputs => _productsStreamController.sink;

  @override
  Stream<List<Product>> get productsOutputs =>
      _productsStreamController.stream.map((event) => event);

  @override
  dispose() {
    _productsStreamController.close();
    _adsStreamController.close();
    super.dispose();
  }
}

abstract class HomeViewModelInputs {
  Sink get adsInputs;

  Sink get productsInputs;
}

abstract class HomeViewModelOutputs {
  Stream<List<AdsModel>> get adsOutputs;

  Stream<List<Product>> get productsOutputs;
}
