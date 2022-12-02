import 'package:tut_advanced_clean_arch/data_layer/models/response_model/login_request.dart';
import '../../models/response_model/response.dart';
import '../network_client/network_api.dart';

abstract class BaseRemoteDataSource{
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSource implements BaseRemoteDataSource{

  final NetworkApi _networkApi;

  RemoteDataSource( this._networkApi);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _networkApi.login(loginRequest.email, loginRequest.password);
  }

}