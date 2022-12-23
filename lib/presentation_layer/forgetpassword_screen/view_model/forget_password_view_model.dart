import 'dart:async';

import 'package:tut_advanced_clean_arch/domain_layer/usecase/forget_password_usecase/forget_pasword_usecase.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/common/state_randerer/state_renderer.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/common/state_randerer/state_renderer_impl.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/view_model_base/base_view_model.dart';

class ForgetPasswordViewModel extends BaseViewModel
    with ForgetPasswordViewModelInputs, ForgetPasswordViewModelOutputs {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final StreamController<String> _userEmailInputStreamController = StreamController();
  var email = "";

  ForgetPasswordViewModel(this._forgetPasswordUseCase);

  @override
  Stream<bool> get isUserEmailValid =>
      _userEmailInputStreamController.stream
          .map((email) => _isEmailValid(email));

  @override
  void start() {
    inputFlowState.add(ContentState());
  }

  @override
  dispose() {
    _userEmailInputStreamController.close();
    super.dispose();
  }

  @override
  Sink<String> get userEmailInput => _userEmailInputStreamController.sink;

  _isEmailValid(String email) {
    return email.isNotEmpty;
  }

  @override
  setUserEmail(String userEmail) {
    email = userEmail;
    _userEmailInputStreamController.add(userEmail);
  }

  @override
  resetPassword() async {
    inputFlowState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));

    (await _forgetPasswordUseCase.execute(email))
        .fold((l) =>
        inputFlowState.add(ErrorState(
            stateRendererType: StateRendererType.popupErrorState,
            message: l.message))
        , (r) =>  inputFlowState.add(ContentState()));
  }
}

abstract class ForgetPasswordViewModelInputs {
  Sink<String> get userEmailInput;

  setUserEmail(String userEmail);

  resetPassword();
}

abstract class ForgetPasswordViewModelOutputs {
  Stream<bool> get isUserEmailValid;
}
