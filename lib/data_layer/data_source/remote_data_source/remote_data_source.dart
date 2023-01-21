import '../../../application_layer/app_pref.dart';
import '/data_layer/models/response_model/login_request.dart';
import '/data_layer/models/response_model/register_request.dart';
import '../../models/response_model/response.dart';
import '../../models/response_model/store_response.dart';
import '../network/server_client.dart';
import '../network/store_server_client.dart';

abstract class BaseRemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);

  Future<ForgetPasswordResponse> forgetPassword(String email);

  Future<AuthenticationResponse> register(RegisterRequest registerModel);

  Future<List<ProductResponse>> getAllProducts();

  Future<List<ProductResponse>> getMenProducts();

  Future<List<ProductResponse>> getWomenProducts();

  Future<List<ProductResponse>> getJewelryProducts();

  Future<List<ProductResponse>> getElectronicsProducts();

  Future<ProductResponse> getProduct(String id);

  Future<List<AdResponse>> getAds();

  Future addToCart(ProductResponse productResponse);
}

class RemoteDataSource implements BaseRemoteDataSource {
  final ServerClient _networkApi;

  final StoreServerClient _storeServerClient;
  final AppPreferences _appPreference;

  RemoteDataSource(
      this._networkApi, this._storeServerClient, this._appPreference);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _networkApi.login(loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(String email) async {
    return await _networkApi.forgetPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerModel) async {
    return await _networkApi.register(
      registerModel.email,
      registerModel.userName,
      registerModel.password,
      registerModel.phone,
      registerModel.countryCode,
    );
  }

  @override
  Future<List<ProductResponse>> getAllProducts() async {
    return await _storeServerClient.getAllProducts();
  }

  @override
  Future<ProductResponse> getProduct(String id) async {
    return await _storeServerClient.getProduct(id);
  }

  @override
  Future<List<AdResponse>> getAds() async {
    return await _networkApi.getAds();
  }

  @override
  Future<List<ProductResponse>> getElectronicsProducts() async {
    return await _storeServerClient.getElectronicsProducts();
  }

  @override
  Future<List<ProductResponse>> getJewelryProducts() async {
    return await _storeServerClient.getJeweleryProducts();
  }

  @override
  Future<List<ProductResponse>> getMenProducts() async {
    return await _storeServerClient.getMenProducts();
  }

  @override
  Future<List<ProductResponse>> getWomenProducts() async {
    return await _storeServerClient.getWomenProducts();
  }

  @override
  Future addToCart(ProductResponse productResponse) async {
    await _networkApi.addToCart(
      productResponse,
      await _appPreference.getEmail(),
      await _appPreference.getUserName(),
      await _appPreference.getPhone(),
    );
  }
}

/*
    Structure :

      network client  --> login() "Fetch"


      remote data source  --> connect with network client


      repo --> connect with remote data source or local data source


      mappers  --> convert from data model to domain model
 */
