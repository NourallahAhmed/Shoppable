import 'dart:ffi';

import 'package:Shoppable/domain_layer/model/product_model.dart';
import 'package:Shoppable/domain_layer/usecase/cart_usecase/cart_usecase.dart';
import 'package:Shoppable/presentation_layer/common/state_randerer/state_renderer.dart';
import 'package:Shoppable/presentation_layer/common/state_randerer/state_renderer_impl.dart';
import 'package:Shoppable/presentation_layer/view_model_base/base_view_model.dart';
import 'package:rxdart/rxdart.dart';

class CartViewModel extends BaseViewModel with CartViewModelInput , CartViewModelOutput{
  CartUseCase _cartUseCase;
  final cartStream = BehaviorSubject<List<Product>>();

  CartViewModel(this._cartUseCase);

  @override
  void start() async {
      inputFlowState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
     (await _cartUseCase.execute(Void)).fold((l) => null, (r)  {
       print(r);
       cartStream.add(r);
       inputFlowState.add(ContentState());
     });
  }

  @override
  Sink get cartInput => cartStream.sink;

  @override
  // TODO: implement cartOutput
  Stream<List<Product>> get cartOutput => cartStream.stream.map((listOfCart) => listOfCart);

  @override
  void deleteItem(Product product) {
    _cartUseCase.deleteItem(product);
  }
}

abstract class CartViewModelInput{
  Sink get cartInput;
  void deleteItem(Product product);
}
abstract class CartViewModelOutput{
  Stream<List<Product>> get cartOutput;
}