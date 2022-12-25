import 'dart:async';

import 'package:tut_advanced_clean_arch/domain_layer/usecase/register_usecase/register_usecase.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/common/state_randerer/state_renderer.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/common/state_randerer/state_renderer_impl.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/view_model_base/base_view_model.dart';

import '../../common/frezzed_data_classes.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  final RegisterUseCase _registerUseCase;

  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _phoneStreamController =
      StreamController<String>.broadcast();
  final StreamController _countryCodeStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _allInputsValidationStreamController =
      StreamController<String>.broadcast();

  RegisterObject _registerObject = RegisterObject("", "", "", "", "");

  RegisterViewModel(this._registerUseCase);

  @override
  dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _countryCodeStreamController.close();
    _emailStreamController.close();
    _phoneStreamController.close();
  }

  @override
  Sink get countryCodeInput => _countryCodeStreamController.sink;

  @override
  Sink get emailInput => _emailStreamController.sink;

  @override
  Sink get passwordInput => _passwordStreamController.sink;

  @override
  Sink get phoneInput => _phoneStreamController.sink;

  @override
  Sink get userNameInput => _userNameStreamController.sink;

  @override
  Sink get isAllInputs => _allInputsValidationStreamController.sink;

  @override
  Stream<bool> get emailValidation =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get passwordValidation => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get phoneValidation =>
      _phoneStreamController.stream.map((phone) => _isPhoneValid(phone));

  @override
  Stream<bool> get countryCodeValidation => _countryCodeStreamController.stream
      .map((countryCode) => _isCountyCodeValid(countryCode));

  @override
  Stream<bool> get userNameValidation => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get isAllInputsAreValid =>
      _allInputsValidationStreamController.stream
          .map((event) => _isAllInputsAreValid());

  ///Validations
  _isPhoneValid(String phone) => phone.isNotEmpty;

  _isEmailValid(String email) => email.isNotEmpty;

  _isPasswordValid(String password) => password.isNotEmpty;

  _isCountyCodeValid(String countryCode) => countryCode.isNotEmpty;

  _isUserNameValid(String userName) => userName.isNotEmpty;

  _isAllInputsAreValid() {
    return _isUserNameValid(_registerObject.userName) ||
        _isPasswordValid(_registerObject.password) ||
        _isCountyCodeValid(_registerObject.countryCode) ||
        _isEmailValid(_registerObject.email) ||
        _isPhoneValid(_registerObject.phone);
  }

  @override
  void start() {
    inputFlowState.add(ContentState());
  }

  @override
  setCountryCode(String countryCode) {
    _countryCodeStreamController.add(countryCode);
    _registerObject = _registerObject.copyWith(countryCode: countryCode);
  }

  @override
  setEmail(String email) {
    _emailStreamController.add(email);
    _registerObject = _registerObject.copyWith(email: email);
  }

  @override
  setPassword(String password) {
    _passwordStreamController.add(password);
    _registerObject = _registerObject.copyWith(password: password);
  }

  @override
  setPhone(String phone) {
    _phoneStreamController.add(phone);
    _registerObject = _registerObject.copyWith(phone: phone);
  }

  @override
  setUserName(String userName) {
    _userNameStreamController.add(userName);
    _registerObject = _registerObject.copyWith(userName: userName);
  }

  @override
  register() {
    inputFlowState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
  }
}

abstract class RegisterViewModelInputs {
  setUserName(String userName);

  setPassword(String password);

  setEmail(String email);

  setPhone(String phone);

  setCountryCode(String countryCode);

  register();

  Sink get userNameInput;

  Sink get passwordInput;

  Sink get emailInput;

  Sink get phoneInput;

  Sink get countryCodeInput;

  Sink get isAllInputs;
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get userNameValidation;

  Stream<bool> get passwordValidation;

  Stream<bool> get emailValidation;

  Stream<bool> get phoneValidation;

  Stream<bool> get countryCodeValidation;

  Stream<bool> get isAllInputsAreValid;
}
