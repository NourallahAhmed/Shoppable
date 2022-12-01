
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:tut_advanced_clean_arch/data_layer/response_model/response.dart';

import '../../../application_layer/api_constants.dart';
part 'network_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class NetworkApi {

  factory NetworkApi(Dio dio, {required String baseUrl}) = _NetworkApi;


  @POST(ApiConstants.loginEndPoint)
  Future<AuthenticationResponse> login(
      @Field("email") String email, @Field("password") String password);
}