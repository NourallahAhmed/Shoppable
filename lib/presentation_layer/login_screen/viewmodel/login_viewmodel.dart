import 'dart:async';
import 'package:tut_advanced_clean_arch/presentation_layer/common/frezzed_data_classes.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/view_model_base/base_view_model.dart';

import '../../../domain_layer/usecase/login_usecase/login_usecase.dart';

class LoginViewModel
    implements BaseViewModel, LoginViewModelInput, LoginViewModelOutput {


  // initialize streams

  /// broadcast for multipleListener
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();



  // useCase object
  // final LoginUseCase _loginUseCase;

  //data class
  LoginObject _loginObject = LoginObject("", "");


  LoginViewModel(/*this._loginUseCase*/);

  @override
  void dispose() {
    _passwordStreamController.close();
    _userNameStreamController.close();
  }

  @override
  void start() {

  }

  ///Input Actions
  @override
  login() async {
    // await _loginUseCase.execute(LoginUseCaseInput(_loginObject.userName , _loginObject.password));
  }

  @override
  Sink get passwordInput => _passwordStreamController.sink;

  @override
  Sink get userNameInput => _userNameStreamController.sink;

  @override
  setPassword(String password) {
    _passwordStreamController.add(password);
    _loginObject = _loginObject.copyWith(password: password);
  }

  @override
  setUserName(String userName) {
    _userNameStreamController.add(userName);
    _loginObject = _loginObject.copyWith(userName: userName);
  }

  /// OutPuts
  @override
  Stream<bool> get passwordValidation => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get userNameValidation => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
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
}

abstract class LoginViewModelOutput {
  /// work with streams
  Stream<bool> get passwordValidation;

  Stream<bool> get userNameValidation;
}
