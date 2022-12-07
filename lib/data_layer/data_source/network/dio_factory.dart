import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tut_advanced_clean_arch/application_layer/api_constants.dart';


/// for headers
const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "langauge";
const String SEND_TOKEN = "SEND TOKEN HERE";


class DioFactory{
  Future<Dio> getDio() async{
    Dio dio = Dio();
    int _time = 60 * 1000;
    /// add headers
    Map<String , String> headers = {
      CONTENT_TYPE : APPLICATION_JSON,
      ACCEPT : APPLICATION_JSON,
      DEFAULT_LANGUAGE : "en",
      AUTHORIZATION : SEND_TOKEN,
    };

    /// dio_options
    dio.options = BaseOptions(
      baseUrl:  ApiConstants.baseUrl,
      headers:  headers ,
      receiveTimeout: _time,
      sendTimeout:  _time
    );

    /// dio logger
    if(!kReleaseMode){ // in debug mode only
        dio.interceptors.add(PrettyDioLogger(
          requestHeader : true ,
          requestBody  : true ,
          responseHeader  : true ,
        ));
    }

    return dio;
  }
}