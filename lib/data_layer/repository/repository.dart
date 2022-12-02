import 'package:dartz/dartz.dart';
import 'package:tut_advanced_clean_arch/application_layer/api_constants.dart';
import 'package:tut_advanced_clean_arch/application_layer/extensions.dart';
import 'package:tut_advanced_clean_arch/data_layer/data_source/network_client/failure.dart';
import 'package:tut_advanced_clean_arch/data_layer/data_source/remote_data_source/remote_data_source.dart';
import 'package:tut_advanced_clean_arch/data_layer/models/mappers/authentication_mappers.dart';
import 'package:tut_advanced_clean_arch/data_layer/models/response_model/login_request.dart';
import 'package:tut_advanced_clean_arch/domain_layer/model/login_models.dart';
import 'package:tut_advanced_clean_arch/domain_layer/repository/base_repository.dart';

import '../data_source/network_client/network_checker.dart';
import '../data_source/network_client/network_error_messages.dart';

class Repository implements BaseRepository{
  final BaseRemoteDataSource _baseRemoteDataSource;
  final NetworkChecker _networkChecker;

  Repository(this._baseRemoteDataSource, this._networkChecker);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {

    /// check connection first


    /// if has connection
    ///   check on the status code  and so on
    ///    else return failure
    ///  else return failure


    if (await _networkChecker.isConnected){
      final reponse = await _baseRemoteDataSource.login(loginRequest);

      if (reponse.status == ApiConstants.statusSuccess){ // return 0
        return Right(reponse.toDomain());
      }else{
        return Left(Failure(reponse.status.notZero() ,  NetworkErrorMessage.apiError));
      }
    }else{
      return Left(Failure(400 , NetworkErrorMessage.networkError));

    }



  }

}