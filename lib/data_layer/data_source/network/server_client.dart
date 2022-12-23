
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../../../application_layer/api_constants.dart';
import '../../models/response_model/response.dart';

part 'server_client.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ServerClient {

  factory ServerClient(Dio dio, {required String baseUrl}) = _ServerClient;


  @POST(ApiConstants.loginEndPoint)
  Future<AuthenticationResponse> login(
      @Field("email") String email, @Field("password") String password);


  @POST(ApiConstants.forgetPasswordEndPoint)
  Future<ForgetPasswordResponse> forgetPassword(
      @Field("email") String email);
}