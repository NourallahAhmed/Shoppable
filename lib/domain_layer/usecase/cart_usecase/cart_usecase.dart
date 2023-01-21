import 'package:Shoppable/data_layer/data_source/network/failure.dart';
import 'package:Shoppable/domain_layer/model/product_model.dart';
import 'package:Shoppable/domain_layer/usecase/base/base_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../repository/base_repository.dart';

class CartUseCase extends BaseUseCase<void ,List<Product>>{
   BaseRepository repository;


   CartUseCase(this.repository);

  @override
  Future<Either<Failure, List<Product>>> execute(void input) async {
   return Right (await repository.getCart());
  }

}