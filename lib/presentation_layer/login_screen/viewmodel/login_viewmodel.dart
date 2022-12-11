import 'package:dartz/dartz.dart';
import 'package:tut_advanced_clean_arch/data_layer/data_source/network/failure.dart';
import 'package:tut_advanced_clean_arch/data_layer/models/response_model/login_request.dart';
import 'package:tut_advanced_clean_arch/domain_layer/model/login_models.dart';
import 'package:tut_advanced_clean_arch/domain_layer/usecase/base/base_usecase.dart';
import 'package:tut_advanced_clean_arch/presentation_layer/view_model_base/base_view_model.dart';

class LoginViewModel implements BaseViewModel{
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }

}


abstract class LoginViewModelInput{

  /// Actions:
  /// user enter UserName

  setUserName(String userName);


  /// user enter password
  setPassword(String password);

  /// user press login button
  login();


  /// work with streams
  Sink  get _loginViewModelInput;
}
abstract class LoginViewModelOutput{

}


