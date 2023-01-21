
import 'package:Shoppable/data_layer/models/response_model/store_response.dart';
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


  @POST(ApiConstants.registerEndPoint)
  Future<AuthenticationResponse> register(
      @Field("email") String email,
      @Field("user_name") String userName,
      @Field("password") String password,
      @Field("phone") String phone,
      @Field("country_code") String countryCode,

      );

  @GET(ApiConstants.ads)
  Future<List<AdResponse>> getAds();


  @GET(ApiConstants.cart)
  Future<List<AdResponse>> addToCart(

      @Field("product") ProductResponse productResponse,
      @Field("email") String email,
      @Field("user_name") String userName,
      @Field("phone") String phone,

      );





}