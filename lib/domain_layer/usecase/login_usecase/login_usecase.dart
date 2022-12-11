import 'package:dartz/dartz.dart';
import 'package:tut_advanced_clean_arch/data_layer/data_source/network/failure.dart';
import 'package:tut_advanced_clean_arch/domain_layer/model/login_models.dart';
import 'package:tut_advanced_clean_arch/domain_layer/usecase/base/base_usecase.dart';

import '../../../data_layer/models/response_model/login_request.dart';
import '../../../data_layer/repository/repository.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput , Authentication>{
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }


}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}