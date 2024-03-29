import 'dart:async';
import 'package:Shoppable/application_layer/extensions.dart';

import '/presentation_layer/common/frezzed_data_classes.dart';
import '/presentation_layer/common/state_randerer/state_renderer.dart';
import '/presentation_layer/common/state_randerer/state_renderer_impl.dart';
import '/presentation_layer/view_model_base/base_view_model.dart';

import '../../../application_layer/app_pref.dart';
import '../../../domain_layer/usecase/login_usecase/login_usecase.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutput {
  // initialize streams

  /// broadcast for multipleListener
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  final StreamController isLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  // useCase object
  final LoginUseCase _loginUseCase;
  final AppPreferences _appPreferences;
  //data class
  LoginObject _loginObject = LoginObject("", "");

  LoginViewModel(this._loginUseCase  , this._appPreferences);

  @override
  void dispose() {
    _passwordStreamController.close();
    _userNameStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  void start() {
    inputFlowState.add(ContentState());
  }

  ///Input Actions
  @override
  login() async {
    inputFlowState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _loginUseCase.execute(
            LoginUseCaseInput(_loginObject.userName, _loginObject.password)))
        .fold((l) =>
              inputFlowState.add(ErrorState(stateRendererType: StateRendererType.popupErrorState, message: l.message)),

            (r) {
              isLoggedInSuccessfullyStreamController.add(true);
              _appPreferences.setUserLoggedIn();
              _appPreferences.setUserData(r.contacts!.email.orEmpty() , r.customer!.name.orEmpty() , r.contacts!.phone.orEmpty());
              }
    );
  }

  @override
  Sink get passwordInput => _passwordStreamController.sink;

  @override
  Sink get userNameInput => _userNameStreamController.sink;

  @override
  Sink get isAllInputs => _isAllInputsValidStreamController.sink;

  @override
  setPassword(String password) {
    _passwordStreamController.add(password);
    _loginObject = _loginObject.copyWith(password: password);

    ///Frezzed
    _isAllInputsValidStreamController.add(null);
  }

  @override
  setUserName(String userName) {
    _userNameStreamController.add(userName);
    _loginObject = _loginObject.copyWith(userName: userName);
    _isAllInputsValidStreamController.add(null);
  }

  /// OutPuts
  @override
  Stream<bool> get passwordValidation => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get userNameValidation => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get isAllInputsValid => _isAllInputsValidStreamController.stream
      .map((event) => _isAllInputsAreValid());

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isAllInputsAreValid() {
    return _isPasswordValid(_loginObject.password) &&
        _isUserNameValid(_loginObject.userName);
  }
}

abstract class LoginViewModelInput {
  /// Actions:
  /// user enter UserName

  setUserName(String userName);

  /// user enter password
  setPassword(String password);

  /// user press login button
  login();

  /// work with streams
  Sink get passwordInput;

  Sink get userNameInput;

  Sink get isAllInputs;
}

abstract class LoginViewModelOutput {
  /// work with streams
  Stream<bool> get passwordValidation;

  Stream<bool> get userNameValidation;

  Stream<bool> get isAllInputsValid;
}
