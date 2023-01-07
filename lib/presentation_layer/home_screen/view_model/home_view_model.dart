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
  MenProductUseCase _menProductUseCase;
  WomenProductUseCase _womenProductUseCase;
  JeweleryProductUseCase _jeweleryProductUseCase;
  ElectronicsProductUseCase _electronicsProductUseCase;

  /// broadcast for multipleListener
  final _productsStreamController = BehaviorSubject<List<Product>>();
  final _menProductsStreamController = BehaviorSubject<List<Product>>();
  final _womenProductsStreamController = BehaviorSubject<List<Product>>();
  final _jeweleryProductsStreamController = BehaviorSubject<List<Product>>();
  final _electronicsProductsStreamController = BehaviorSubject<List<Product>>();
  final _adsStreamController = BehaviorSubject<List<AdsModel>>();
  final _dataStreamController = BehaviorSubject<bool>();

  HomeViewModel(
      this._homeUseCase,
      this._adsUseCase,
      this._menProductUseCase,
      this._womenProductUseCase,
      this._jeweleryProductUseCase,
      this._electronicsProductUseCase);

  @override
  void start() async {
    inputFlowState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    ///Electronics_Products
    (await _electronicsProductUseCase.execute(Void)).fold(
        (l) => inputFlowState.add(ErrorState(
            stateRendererType: StateRendererType.fullScreenErrorState,
            message: l.message)), (r) {
      _electronicsProductsStreamController.add(r);
    });

    ///MenProducts
    (await _menProductUseCase.execute(Void)).fold(
        (l) => inputFlowState.add(ErrorState(
            stateRendererType: StateRendererType.fullScreenErrorState,
            message: l.message)), (r) {
      _menProductsStreamController.add(r);
    });

    ///WomenProducts
    (await _womenProductUseCase.execute(Void)).fold(
        (l) => inputFlowState.add(ErrorState(
            stateRendererType: StateRendererType.fullScreenErrorState,
            message: l.message)), (r) {
      _womenProductsStreamController.add(r);
    });

    ///JeweleryProducts
    (await _jeweleryProductUseCase.execute(Void)).fold(
        (l) => inputFlowState.add(ErrorState(
            stateRendererType: StateRendererType.fullScreenErrorState,
            message: l.message)), (r) {
      _jeweleryProductsStreamController.add(r);
    });

    ///ADs
    (await _adsUseCase.execute(Void)).fold(
        (l) => inputFlowState.add(ErrorState(
            stateRendererType: StateRendererType.fullScreenErrorState,
            message: l.message)), (r) {
      _adsStreamController.add(r);
    });
  }

  ///ADS
  @override
  Sink get adsInputs => _adsStreamController.sink;

  @override
  Stream<List<AdsModel>> get adsOutputs =>
      _adsStreamController.stream.map((event) => event);

  ///Products
  @override
  Sink get productsInputs => _productsStreamController.sink;

  @override
  Stream<List<Product>> get productsOutputs =>
      _productsStreamController.stream.map((event) => event);

  ///Electronics
  @override
  Sink get electronicsProductsInputs =>
      _electronicsProductsStreamController.sink;

  @override
  Stream<List<Product>> get electronicsProductsOutputs =>
      _electronicsProductsStreamController.stream.map((event) => event);

  @override
  Sink get jeweleryProductsInputs => _jeweleryProductsStreamController.sink;

  @override
  Stream<List<Product>> get jeweleryProductsOutputs =>
      _jeweleryProductsStreamController.stream.map((event) => event);

  @override
  Sink get menProductsInputs => _menProductsStreamController.sink;

  @override
  Stream<List<Product>> get menProductsOutputs =>
      _menProductsStreamController.stream.map((event) => event);

  @override
  Sink get womenProductsInputs => _womenProductsStreamController.sink;

  @override
  Stream<List<Product>> get womenProductsOutputs =>
      _womenProductsStreamController.stream.map((event) => event);

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

  Sink get menProductsInputs;

  Sink get womenProductsInputs;

  Sink get jeweleryProductsInputs;

  Sink get electronicsProductsInputs;
}

abstract class HomeViewModelOutputs {
  Stream<List<AdsModel>> get adsOutputs;

  Stream<List<Product>> get productsOutputs;

  Stream<List<Product>> get menProductsOutputs;

  Stream<List<Product>> get womenProductsOutputs;

  Stream<List<Product>> get jeweleryProductsOutputs;

  Stream<List<Product>> get electronicsProductsOutputs;
}
