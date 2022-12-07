import 'package:dartz/dartz.dart';
import 'package:tut_advanced_clean_arch/domain_layer/model/login_models.dart';
import '../../data_layer/data_source/network/failure.dart';
import '../../data_layer/models/response_model/login_request.dart';

abstract class BaseRepository{
  Future<Either<Failure , Authentication>> login (LoginRequest loginRequest);
}