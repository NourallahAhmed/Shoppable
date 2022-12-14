
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../application_layer/api_constants.dart';
import '../../models/response_model/store_response.dart';

part 'store_server_client.g.dart';

@RestApi(baseUrl: ApiConstants.storeBaseUrl)
abstract class StoreServerClient{
  factory StoreServerClient(Dio dio, {required String baseUrl}) = _StoreServerClient;

  @GET(ApiConstants.allProducts)
  Future<List<ProductResponse>> getAllProducts();



  @GET(ApiConstants.menCategory)
  Future<List<ProductResponse>> getMenProducts();


  @GET(ApiConstants.womenCategory)
  Future<List<ProductResponse>> getWomenProducts();


  @GET(ApiConstants.jeweleryCategory)
  Future<List<ProductResponse>> getJeweleryProducts();


  @GET(ApiConstants.electronicsCategory)
  Future<List<ProductResponse>> getElectronicsProducts();



  @GET("${ApiConstants.allProducts}{/}")
  Future<ProductResponse> getProduct(@Path("/") id);

}