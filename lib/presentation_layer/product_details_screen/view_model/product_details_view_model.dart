import 'package:rxdart/rxdart.dart';
import '/domain_layer/usecase/details_usecase/product_details_usecase.dart';
import '/presentation_layer/common/state_randerer/state_renderer.dart';
import '/presentation_layer/common/state_randerer/state_renderer_impl.dart';
import '/presentation_layer/view_model_base/base_view_model.dart';

import '../../../domain_layer/model/product_model.dart';

class ProductDetailsViewModel extends BaseViewModel
    with ProductDetailsViewModelInputs, ProductDetailsViewModelOutputs {
  final ProductDetailsUseCase _productDetailsUseCase;
  final _productStreamController = BehaviorSubject<Product>();
  String id;

  ProductDetailsViewModel(this._productDetailsUseCase, this.id);

  @override
  void dispose() {
    _productStreamController.close();
    super.dispose();
  }

  @override
  void start() async {

    print("id ViewModel = ${id}");
    inputFlowState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    (await _productDetailsUseCase.execute(id))
        .fold(
            (l) => inputFlowState.add(
                  ErrorState(stateRendererType: StateRendererType.fullScreenEmptyState, message: l.message)),
            (r) {
              _productStreamController.add(r);
              inputFlowState.add(ContentState());
            }
            );
  }

  @override
  Sink get productDetailsInputs => _productStreamController.sink;

  @override
  Stream<Product> get productDetailsOutputs => _productStreamController.stream.map((event) => event);

}

abstract class ProductDetailsViewModelInputs {
  Sink get productDetailsInputs;
}

abstract class ProductDetailsViewModelOutputs {
  Stream<Product> get productDetailsOutputs;
}