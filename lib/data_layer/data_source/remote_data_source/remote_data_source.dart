import 'package:tut_advanced_clean_arch/data_layer/models/response_model/login_request.dart';
import '../../models/response_model/response.dart';
import '../network/server_client.dart';

abstract class BaseRemoteDataSource{
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSource implements BaseRemoteDataSource{

  final ServerClient _networkApi;

  RemoteDataSource( this._networkApi);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _networkApi.login(loginRequest.email, loginRequest.password);
  }

}


/*
    Structure :

      network client  --> login() "Fetch"


      remote data source  --> connect with network client


      repo --> connect with remote data source or local data source


      mappers  --> convert from data model to domain model
 */