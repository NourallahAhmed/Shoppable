import 'dart:async';
import 'package:tut_advanced_clean_arch/presentation_layer/view_model_base/base_view_model.dart';

import '../../../domain_layer/usecase/login_usecase/login_usecase.dart';

class LoginViewModel implements BaseViewModel , LoginViewModelInput , LoginViewModelOutput{



      // initialize streams

      final StreamController _userNameStreamController  = StreamController<String>.broadcast(); /// broadcast for multipleListener
      final StreamController _passwordStreamController  = StreamController<String>.broadcast(); /// broadcast for multipleListener

      // useCase object
      final LoginUseCase _loginUseCase;

      LoginViewModel(this._loginUseCase);

      @override
      void dispose() {
        _passwordStreamController.close();
        _userNameStreamController.close();
      }

      @override
      void start() {
        // TODO: implement start
      }


      ///Input Actions
      @override
      login() {
        // TODO: implement login
        throw UnimplementedError();
      }

      @override
      Sink get passwordInput => _passwordStreamController.sink ;

      @override
      Sink get userNameInput => _userNameStreamController.sink;

      @override
      setPassword(String password) {
        // TODO: implement setPassword
        throw UnimplementedError();
      }

      @override
      setUserName(String userName) {
        // TODO: implement setUserName
        throw UnimplementedError();
      }


      /// OutPuts
      @override
      Stream<bool> get passwordValidation => _passwordStreamController.stream.map((password) => _isPasswordValid(password));


      @override
      Stream<bool> get userNameValidation => _userNameStreamController.stream.map((userName) => _isUserNameValid(userName));

      bool _isPasswordValid(String password ) {
        return  password.isNotEmpty;
      }

      bool _isUserNameValid(String userName) {
        return  userName.isNotEmpty;
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
  Stream <bool> get passwordValidation;

  Stream <bool> get userNameValidation;
}


