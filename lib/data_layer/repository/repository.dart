import 'package:dartz/dartz.dart';
import 'package:tut_advanced_clean_arch/data_layer/data_source/network/failure.dart';
import 'package:tut_advanced_clean_arch/data_layer/data_source/remote_data_source/remote_data_source.dart';
import 'package:tut_advanced_clean_arch/data_layer/models/mappers/authentication_mappers.dart';
import 'package:tut_advanced_clean_arch/data_layer/models/response_model/login_request.dart';
import 'package:tut_advanced_clean_arch/domain_layer/model/login_models.dart';
import 'package:tut_advanced_clean_arch/domain_layer/repository/base_repository.dart';
import '../data_source/network/error_handler.dart';
import '../data_source/network/network_checker.dart';

class Repository implements BaseRepository{
  final BaseRemoteDataSource _baseRemoteDataSource;
  final NetworkChecker _networkChecker;

  Repository(this._baseRemoteDataSource, this._networkChecker);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if (await _networkChecker.isConnected){
      try{
        final reponse = await _baseRemoteDataSource.login(loginRequest);

        if (reponse.status == ApiInternalStatus.SUCCESS) {
          // return 0
          return Right(reponse.toDomain());
        } else {
          return Left(
              Failure(ApiInternalStatus.SUCCESS, ResponseMessage.DEFAULT));
        }
      }catch(error){
          return Left(DataSource.DEFAULT.getFailure());
      }
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ForgetPassword>> forgetPassword(String email) async {
    if (await _networkChecker.isConnected){
      try{
        final reponse = await _baseRemoteDataSource.forgetPassword(email);

        if (reponse.status == ApiInternalStatus.SUCCESS) {
          // return 0
          return Right(reponse.toDomain());
        } else {
          return Left(
              Failure(ApiInternalStatus.SUCCESS, ResponseMessage.DEFAULT));
        }
      }catch(error){
        return Left(DataSource.DEFAULT.getFailure());
      }
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

}