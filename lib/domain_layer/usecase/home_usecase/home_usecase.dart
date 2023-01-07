
import 'package:dartz/dartz.dart';
import 'package:tut_advanced_clean_arch/data_layer/data_source/network/failure.dart';
import 'package:tut_advanced_clean_arch/domain_layer/model/Ads_Model.dart';
import 'package:tut_advanced_clean_arch/domain_layer/model/product_model.dart';
import 'package:tut_advanced_clean_arch/domain_layer/usecase/base/base_usecase.dart';

import '../../../data_layer/repository/repository.dart';

class HomeUseCase extends BaseUseCase<void,List<Product>>{
  final Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, List<Product>>> execute(void input) async {
    return await _repository.getAllProducts();
  }
}

class AdsUseCase extends BaseUseCase<void,List<AdsModel>>{
  final Repository _repository;

  AdsUseCase(this._repository);

  @override
  Future<Either<Failure, List<AdsModel>>> execute(void input) async {
    return await _repository.getAds();
  }
}

class MenProductUseCase extends BaseUseCase<void,List<Product>>{
  final Repository _repository;

  MenProductUseCase(this._repository);

  @override
  Future<Either<Failure, List<Product>>> execute(void input) async {
    return await _repository.getMenProducts();
  }
}
class WomenProductUseCase extends BaseUseCase<void,List<Product>>{
  final Repository _repository;

  WomenProductUseCase(this._repository);

  @override
  Future<Either<Failure, List<Product>>> execute(void input) async {
    return await _repository.getWomenProducts();
  }
}
class JeweleryProductUseCase extends BaseUseCase<void,List<Product>>{
  final Repository _repository;

  JeweleryProductUseCase(this._repository);

  @override
  Future<Either<Failure, List<Product>>> execute(void input) async {
    return await _repository.getJeweleryProducts();
  }
}
class ElectronicsProductUseCase extends BaseUseCase<void,List<Product>>{
  final Repository _repository;

  ElectronicsProductUseCase(this._repository);

  @override
  Future<Either<Failure, List<Product>>> execute(void input) async {
    return await _repository.getElectronicsProducts();
  }
}