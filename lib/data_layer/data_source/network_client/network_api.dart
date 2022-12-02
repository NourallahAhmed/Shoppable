
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../application_layer/api_constants.dart';
import '../../models/response_model/response.dart';
part 'network_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class NetworkApi {

  factory NetworkApi(Dio dio, {required String baseUrl}) = _NetworkApi;


  @POST(ApiConstants.loginEndPoint)
  Future<AuthenticationResponse> login(
      @Field("email") String email, @Field("password") String password);
}