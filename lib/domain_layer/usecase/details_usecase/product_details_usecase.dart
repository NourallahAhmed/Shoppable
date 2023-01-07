import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:tut_advanced_clean_arch/data_layer/data_source/network/failure.dart';
import 'package:tut_advanced_clean_arch/domain_layer/model/product_model.dart';

import '../../../data_layer/repository/repository.dart';
import '../base/base_usecase.dart';

class ProductDetailsUseCase extends BaseUseCase<String , Product> {

  final Repository _repository;

  ProductDetailsUseCase(this._repository);

  @override
  Future<Either<Failure, Product>> execute(String id) async{
   return await _repository.getProductDetails(id);
  }


}