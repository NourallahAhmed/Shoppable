import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tut_advanced_clean_arch/application_layer/api_constants.dart';

import '../../../application_layer/app_pref.dart';


/// for headers
const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "langauge";


class DioFactory{

  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async{
    Dio dio = Dio();


    /// get the saved language
    String language = await _appPreferences.getAppLanguage();


    Map<String , String> headers = {
      CONTENT_TYPE : APPLICATION_JSON,
      ACCEPT : APPLICATION_JSON,
      DEFAULT_LANGUAGE : language,
      AUTHORIZATION : ApiConstants.token,
    };

    /// dio_options
    /// The common config for the Dio instance.
    dio.options = BaseOptions(
      baseUrl:  ApiConstants.baseUrl,
      headers:  headers ,
      receiveTimeout: ApiConstants.apiTime,
      sendTimeout:  ApiConstants.apiTime
    );

    /// dio logger
    if(!kReleaseMode){    // in debug mode only
        dio.interceptors.add(PrettyDioLogger(
          requestHeader : true ,
          requestBody  : true ,
          responseHeader  : true ,
        ));
    }

    return dio;
  }
}