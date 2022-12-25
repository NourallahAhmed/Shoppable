import 'package:dartz/dartz.dart';

import 'package:tut_advanced_clean_arch/data_layer/data_source/network/failure.dart';
import 'package:tut_advanced_clean_arch/data_layer/models/response_model/register_request.dart';

import '../../../data_layer/repository/repository.dart';
import '../../model/login_models.dart';
import '../base/base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(
        RegisterRequest(
            input.email,
            input.password,
            input.userName,
            input.phone,
            input.countryCode));
  }
}

class RegisterUseCaseInput {
  String email;
  String password;
  String userName;
  String phone;
  String countryCode;

  RegisterUseCaseInput(
      this.email, this.password, this.userName, this.phone, this.countryCode);
}
