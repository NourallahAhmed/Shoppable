import 'package:Shoppable/application_layer/database_helper.dart';
import 'package:dartz/dartz.dart';
import '../../application_layer/dependency_injection.dart';
import '/data_layer/data_source/network/failure.dart';
import '/data_layer/data_source/remote_data_source/remote_data_source.dart';
import '/data_layer/models/mappers/ads_mappers.dart';
import '/data_layer/models/mappers/authentication_mappers.dart';
import '/data_layer/models/mappers/products_mapper.dart';
import '/data_layer/models/response_model/login_request.dart';
import '/domain_layer/model/Ads_Model.dart';
import '/domain_layer/model/product_model.dart';
import '/data_layer/models/response_model/register_request.dart';
import '/domain_layer/model/login_models.dart';
import '/domain_layer/repository/base_repository.dart';
import '../data_source/network/error_handler.dart';
import '../data_source/network/network_checker.dart';

class Repository implements BaseRepository{
  final BaseRemoteDataSource _baseRemoteDataSource;
  final NetworkChecker _networkChecker;
  final DataBaseHelper _dataBaseHelper;
  Repository(this._baseRemoteDataSource, this._networkChecker , this._dataBaseHelper);

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
        print("Error ${error}");
        return Left(DataSource.DEFAULT.getFailure());
      }
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest) async {
    if (await _networkChecker.isConnected){
      try{
        final reponse = await _baseRemoteDataSource.register(registerRequest);

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
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    if (await _networkChecker.isConnected){
      try{
        final reponse = await _baseRemoteDataSource.getAllProducts();

        if (reponse.isNotEmpty) {
          return Right(reponse.toDomain());
        } else {
          return Left(
              Failure(ApiInternalStatus.SUCCESS, ResponseMessage.DEFAULT));
        }
      }catch(error){
        print("error ${error}");
        return Left(DataSource.DEFAULT.getFailure());
      }
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<AdsModel>>> getAds() async {
    if (await _networkChecker.isConnected){
      try{
        final reponse = await _baseRemoteDataSource.getAds();

        if (reponse.isNotEmpty) {

          return Right(reponse.toDomain());
        } else {
          return Left(
              Failure(ApiInternalStatus.SUCCESS, ResponseMessage.DEFAULT));
        }
      }catch(error){

        print("catch error : ${error}");
        return Left(DataSource.DEFAULT.getFailure());
      }
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getElectronicsProducts()  async {
    if (await _networkChecker.isConnected){
      try{
        final reponse = await _baseRemoteDataSource.getElectronicsProducts();

        if (reponse.isNotEmpty) {
          return Right(reponse.toDomain());
        } else {
          return Left(
              Failure(ApiInternalStatus.SUCCESS, ResponseMessage.DEFAULT));
        }
      }catch(error){
        print("error ${error}");
        return Left(DataSource.DEFAULT.getFailure());
      }
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getJeweleryProducts()  async {
    if (await _networkChecker.isConnected){
      try{
        final reponse = await _baseRemoteDataSource.getJewelryProducts();

        if (reponse.isNotEmpty) {
          return Right(reponse.toDomain());
        } else {
          return Left(
              Failure(ApiInternalStatus.SUCCESS, ResponseMessage.DEFAULT));
        }
      }catch(error){
        print("error ${error}");
        return Left(DataSource.DEFAULT.getFailure());
      }
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    };
  }

  @override
  Future<Either<Failure, List<Product>>> getMenProducts() async {
    if (await _networkChecker.isConnected){
      try{
        final reponse = await _baseRemoteDataSource.getMenProducts();

        if (reponse.isNotEmpty) {
          return Right(reponse.toDomain());
        } else {
          return Left(
              Failure(ApiInternalStatus.SUCCESS, ResponseMessage.DEFAULT));
        }
      }catch(error){
        print("error ${error}");
        return Left(DataSource.DEFAULT.getFailure());
      }
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getWomenProducts() async {
    if (await _networkChecker.isConnected){
      try{
        final reponse = await _baseRemoteDataSource.getWomenProducts();

        if (reponse.isNotEmpty) {
          return Right(reponse.toDomain());
        } else {
          return Left(
              Failure(ApiInternalStatus.SUCCESS, ResponseMessage.DEFAULT));
        }
      }catch(error){
        print("error ${error}");
        return Left(DataSource.DEFAULT.getFailure());
      }
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> getProductDetails(String id) async {
    if (await _networkChecker.isConnected){
      try{
        final reponse = await _baseRemoteDataSource.getProduct(id);

        if (reponse != null) {
          return Right(reponse.toDomain());
        } else {
          return Left(
              Failure(ApiInternalStatus.SUCCESS, ResponseMessage.DEFAULT));
        }
      }catch(error){
        print("error ${error}");
        return Left(DataSource.DEFAULT.getFailure());
      }
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future addToCart(Product product) async {

    await instance<DataBaseHelper>().insertOrder(product);


    // if (await _networkChecker.isConnected){
    //   try{
    //     final reponse = await _baseRemoteDataSource.addToCart(product.toData());
    //
    //     if (reponse != null) {
    //       return Right(reponse.toDomain());
    //     } else {
    //       return Left(
    //           Failure(ApiInternalStatus.SUCCESS, ResponseMessage.DEFAULT));
    //     }
    //   }catch(error){
    //     print("error ${error}");
    //     return Left(DataSource.DEFAULT.getFailure());
    //   }
    // }else{
    //   return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    // }
  }

  @override
  Future<List<Product>> getCart() async {
   return await _dataBaseHelper.getAllOrder();
  }

  @override
  Future deleteProductFromCart(Product product) async {
    await _dataBaseHelper.deleteProductFromCart(product);
  }

}