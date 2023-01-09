import 'package:dartz/dartz.dart';
import '/data_layer/data_source/network/failure.dart';
import '/domain_layer/model/login_models.dart';
import '/domain_layer/usecase/base/base_usecase.dart';

import '../../../data_layer/repository/repository.dart';

class ForgetPasswordUseCase extends BaseUseCase<String , ForgetPassword>{
  final Repository _repository;


  ForgetPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, ForgetPassword>> execute(String input) async {
    return await _repository.forgetPassword(input);
  }

}
