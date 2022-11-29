import 'dart:async';

import 'package:tut_advanced_clean_arch/domain_layer/model/onboardingModels.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/view_model_base/base_view_model.dart';

import '../../resources/image_manager.dart';
import '../../resources/strings_manager.dart';

class OnboardingViewModel extends BaseViewModel
    with OnboardingViewModelInputs, OnboardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderObjectView>();

  int _currentPage = 0;
  late final List<SliderObject> _list;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getList();
    _postDataToView();
  }

  @override
  int nextPage() {
    int nextIndex =
        ++_currentPage; // to use this current increment (don't wait to click again to use it )
    if (nextIndex == _list.length) nextIndex = 0;
    return nextIndex;
  }

  int previousPage() {
    int previousIndex =
        --_currentPage; // to use this current decrement (don't wait to click again to use it )
    if (previousIndex == -1) previousIndex == _list.length - 1;
    return previousIndex;
  }

  @override
  void onPageChange(int index) {
    _currentPage = index;
    _postDataToView();
  }

  @override
  Sink get onboardingInputs => _streamController.sink;

  @override
  Stream<SliderObjectView> get onboardingOutputs =>
      _streamController.stream.map((sliderObjectview) => sliderObjectview);

  ///MARK: private functions
  List<SliderObject> _getList() {
    return [
      SliderObject(
        icon: IconManager.shopingCart,
        txt: StringsManager.onBoarding1,
      ),
      SliderObject(
        icon: IconManager.deliveryIcon,
        txt: StringsManager.onBoarding3,
      ),
      SliderObject(
        icon: IconManager.shopingCart,
        txt: StringsManager.onBoarding2,
      ),
    ];
  }

  _postDataToView() => onboardingInputs
      .add(SliderObjectView(_list[_currentPage], _currentPage, _list.length));
}

abstract class OnboardingViewModelInputs {
  int nextPage();

  int previousPage();

  void onPageChange(int index);

  Sink get onboardingInputs;
}

abstract class OnboardingViewModelOutputs {
  Stream<SliderObjectView> get onboardingOutputs;
}
