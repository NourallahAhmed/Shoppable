

import 'dart:async';

import 'dart:io';
import '/domain_layer/usecase/register_usecase/register_usecase.dart';
import '/presentation_layer/common/state_randerer/state_renderer.dart';
import '/presentation_layer/common/state_randerer/state_renderer_impl.dart';
import '/presentation_layer/resources/strings_manager.dart';
import '/presentation_layer/view_model_base/base_view_model.dart';
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
  final StreamController _pictureStreamController =
      StreamController<File>.broadcast();
  final StreamController _allInputsValidationStreamController =
      StreamController<void>.broadcast();
  final StreamController isRegisteredSuccessfullyStreamController =
      StreamController<String>.broadcast();

  RegisterObject _registerObject = RegisterObject("", "", "", "", "", "");

  RegisterViewModel(this._registerUseCase);

  @override
  dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _countryCodeStreamController.close();
    _emailStreamController.close();
    _phoneStreamController.close();
    _pictureStreamController.close();
    isRegisteredSuccessfullyStreamController.close();
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
  Sink get photoInput => _pictureStreamController.sink;

  /// Email
  @override
  Stream<bool> get emailValidation =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get emailValidationMessage => emailValidation.map(
      (isEmailValid) => isEmailValid ? null : AppStrings.emailErrorMessage);

  /// Password
  @override
  Stream<bool> get passwordValidation => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get passwordValidationMessage =>
      passwordValidation.map((isPasswordValid) =>
          isPasswordValid ? null : AppStrings.passwordErrorMessage);

  ///  Phone

  @override
  Stream<bool> get outputPhone =>
      _phoneStreamController.stream.map((phone) => _isPhoneValid(phone));

  @override
  Stream<String?> get phoneValidationMessage => outputPhone.map(
      (isPhoneValid) => isPhoneValid ? null : AppStrings.phoneErrorMessage);

  ///Country code
  @override
  Stream<bool> get countryCodeValidation => _countryCodeStreamController.stream
      .map((countryCode) => _isCountyCodeValid(countryCode));

  @override
  Stream<String?> get countryCodeValidationMessage =>
      countryCodeValidation.map((isCountryCodeValid) =>
          isCountryCodeValid ? null : AppStrings.countyCodeErrorMessage);

  ///UserName
  @override
  Stream<bool> get userNameValidation => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get userNameValidationMessage => userNameValidation.map(
      (isUserNameValid) => isUserNameValid ? null : AppStrings.useNameError);

  @override
  Stream<File> get outputPicture =>
      _pictureStreamController.stream.map((file) => file);

  // @override
  // Stream<String?> get photoValidationMessage => photoValidation.map((file) => _isPhotoValid(file));

  /// All inputs Validation
  @override
  Stream<bool> get isAllInputsAreValid =>
      _allInputsValidationStreamController.stream
          .map((event) => _isAllInputsAreValid());

  ///Validations

  bool _isPhoneValid(String phone) {
    return phone.length <= 11;
  }

  _isEmailValid(String email) => email.isNotEmpty; //todo: emailValid Method

  bool isEmailValid(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool _isPasswordValid(String password) => password.length >= 8;

  bool _isCountyCodeValid(String countryCode) => countryCode.isNotEmpty;

  bool _isUserNameValid(String userName) => userName.isNotEmpty;

  bool _isAllInputsAreValid() {
    return _isUserNameValid(_registerObject.userName) &&
        _isPasswordValid(_registerObject.password) &&
        _isCountyCodeValid(_registerObject.countryCode) &&
        _isEmailValid(_registerObject.email) &&
        _isPhoneValid(_registerObject.phone);
  }

  @override
  void start() {
    inputFlowState.add(ContentState());
  }



  /// -- Setters
  @override
  setCountryCode(String countryCode) {
    _countryCodeStreamController.add(countryCode);
    _allInputsValidationStreamController.add(null);
    if (_isCountyCodeValid(countryCode)) {
      _registerObject = _registerObject.copyWith(countryCode: countryCode);
    } else {
      _registerObject = _registerObject.copyWith(countryCode: "");
    }

    _validate();
  }

  @override
  setEmail(String email) {
    _emailStreamController.add(email);
    _allInputsValidationStreamController.add(null);

    if (isEmailValid(email)) {
      _registerObject = _registerObject.copyWith(email: email);
    } else {
      _registerObject = _registerObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    _passwordStreamController.add(password);
    _allInputsValidationStreamController.add(null);

    if (_isPasswordValid(password)) {
      _registerObject = _registerObject.copyWith(password: password);
    } else {
      _registerObject = _registerObject.copyWith(password: "");
    }

    _validate();
  }

  @override
  setPhone(String phone) {
    if (_isPhoneValid(phone)) {
      _phoneStreamController.add(phone);
      _registerObject = _registerObject.copyWith(phone: phone);
      _allInputsValidationStreamController.add(null);

    } else {
      _registerObject = _registerObject.copyWith(phone: "");
    }
    _validate();
  }

  @override
  setUserName(String userName) {
    _userNameStreamController.add(userName);
    _allInputsValidationStreamController.add(null);

    if (_isUserNameValid(userName)) {
      _registerObject = _registerObject.copyWith(userName: userName);
    } else {
      _registerObject = _registerObject.copyWith(userName: "");
    }
    _validate();
  }

  @override
  setPhoto(File photo) {
    _pictureStreamController.add(photo);
    _allInputsValidationStreamController.add(null);

    print("from view model");
    print(photo.path);
    if (photo.path.isNotEmpty) {
      _registerObject =
          _registerObject.copyWith(picture: photo.path );
    } else {
      _registerObject = _registerObject.copyWith(picture: "");
    }
    _validate();
  }

  @override
  register() async {
    inputFlowState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));

    (await _registerUseCase.execute(RegisterUseCaseInput(
            _registerObject.email,
            _registerObject.password,
            _registerObject.userName,
            _registerObject.phone,
            _registerObject.countryCode,
            _registerObject.picture)))
        .fold((l) => {
          inputFlowState.add(ErrorState(stateRendererType: StateRendererType.popupErrorState, message: l.message))
    }, (r)  {
          inputFlowState.add(ContentState());
          isRegisteredSuccessfullyStreamController.add(true);
    });
  }

  _validate() {
    _allInputsValidationStreamController.add(null);
  }
}

abstract class RegisterViewModelInputs {
  setUserName(String userName);

  setPassword(String password);

  setPhoto(File photo);

  setEmail(String email);

  setPhone(String phone);

  setCountryCode(String countryCode);

  register();

  Sink get userNameInput;

  Sink get passwordInput;

  Sink get emailInput;

  Sink get phoneInput;

  Sink get countryCodeInput;

  Sink get photoInput;

  Sink get isAllInputs;
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get userNameValidation;

  Stream<String?> get userNameValidationMessage;

  Stream<bool> get passwordValidation;

  Stream<String?> get passwordValidationMessage;

  Stream<bool> get emailValidation;

  Stream<String?> get emailValidationMessage;

  Stream<bool> get outputPhone;

  Stream<String?> get phoneValidationMessage;

  Stream<bool> get countryCodeValidation;

  Stream<String?> get countryCodeValidationMessage;

  Stream<File> get outputPicture;
  // Stream<String?> get photoValidationMessage;

  Stream<bool> get isAllInputsAreValid;
}
