import 'package:dartz/dartz.dart';
import '/domain_layer/model/Ads_Model.dart';
import '/domain_layer/model/product_model.dart';
import '/data_layer/models/response_model/register_request.dart';
import '/domain_layer/model/login_models.dart';
import '../../data_layer/data_source/network/failure.dart';
import '../../data_layer/models/response_model/login_request.dart';

abstract class BaseRepository{
  Future<Either<Failure , Authentication>> login (LoginRequest loginRequest);
  Future<Either<Failure , ForgetPassword>> forgetPassword (String email);
  Future<Either<Failure , Authentication>> register (RegisterRequest registerRequest);
  Future<Either<Failure , List<Product>>> getAllProducts ();
  Future<Either<Failure , List<Product>>> getMenProducts ();
  Future<Either<Failure , List<Product>>> getWomenProducts ();
  Future<Either<Failure , List<Product>>> getJeweleryProducts ();
  Future<Either<Failure , List<Product>>> getElectronicsProducts ();
  Future<Either<Failure , List<AdsModel>>> getAds ();
  Future<Either<Failure , Product>> getProductDetails (String id);
  Future addToCart (Product product);
  Future<List<Product>> getCart ();
}