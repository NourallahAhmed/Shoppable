import 'package:Shoppable/application_layer/database_helper.dart';
import 'package:Shoppable/domain_layer/usecase/cart_usecase/cart_usecase.dart';
import 'package:Shoppable/presentation_layer/cart_screen/view_model/cart_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/application_layer/api_constants.dart';
import '/data_layer/data_source/network/dio_factory.dart';
import '/data_layer/data_source/network/network_checker.dart';
import '/data_layer/data_source/network/store_server_client.dart';
import '/data_layer/data_source/remote_data_source/remote_data_source.dart';
import '/data_layer/repository/repository.dart';
import '/domain_layer/usecase/forget_password_usecase/forget_pasword_usecase.dart';
import '/domain_layer/usecase/home_usecase/home_usecase.dart';
import '/domain_layer/usecase/login_usecase/login_usecase.dart';
import '/domain_layer/usecase/register_usecase/register_usecase.dart';
import '/presentation_layer/login_screen/viewmodel/login_viewmodel.dart';
import '/presentation_layer/register_screen/view_model/register_view_model.dart';

import '../data_layer/data_source/network/server_client.dart';
import '../domain_layer/usecase/details_usecase/product_details_usecase.dart';
import '../presentation_layer/forgetpassword_screen/view_model/forget_password_view_model.dart';
import '../presentation_layer/home_screen/view_model/home_view_model.dart';
import '../presentation_layer/product_details_screen/view_model/product_details_view_model.dart';
import 'app_pref.dart';
import 'package:sqflite/sqflite.dart';

var instance = GetIt.instance;



Future<void> initAppModule() async {
  ///DataBase
  var db =  await DataBaseHelper.dataBaseHelper.database;


  instance.registerLazySingleton<Database>(() => db);
  instance.registerLazySingleton<DataBaseHelper>(() => DataBaseHelper.dataBaseHelper);

  /// adding shared perf
  var sharedPref = await SharedPreferences.getInstance();

  instance.registerLazySingleton(() => sharedPref);

  /// adding app pref class
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  ///networkChecker
  instance
      .registerLazySingleton(() => NetworkChecker(InternetConnectionChecker()));

  ///dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  ///get DioInstance
  var dioInstance = await instance<DioFactory>().getDio();

  ///app service client
  instance.registerLazySingleton<ServerClient>(
      () => ServerClient(dioInstance, baseUrl: ApiConstants.baseUrl));

  ///StoreServerClient

  instance.registerLazySingleton<StoreServerClient>(
      () => StoreServerClient(dioInstance, baseUrl: ApiConstants.storeBaseUrl));

  ///base remote
  instance.registerLazySingleton<BaseRemoteDataSource>(() => RemoteDataSource(
      instance<ServerClient>(),
      instance<StoreServerClient>(),
      instance<AppPreferences>()));

  /// repo
  instance.registerLazySingleton(() =>
      Repository(instance<BaseRemoteDataSource>(), instance<NetworkChecker>() , instance<DataBaseHelper>()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    ///  LoginUseCase
    instance.registerFactory<LoginUseCase>(
        () => LoginUseCase(instance<Repository>()));

    /// login view model
    instance.registerFactory<LoginViewModel>(() =>
        LoginViewModel(instance<LoginUseCase>(), instance<AppPreferences>()));
  }
}

initForgetPasswordModule() {
  if (!GetIt.I.isRegistered<ForgetPasswordUseCase>()) {
    ///  ForgetPasswordUseCase
    instance.registerFactory<ForgetPasswordUseCase>(
        () => ForgetPasswordUseCase(instance<Repository>()));

    /// ForgetPassword view model
    instance.registerFactory<ForgetPasswordViewModel>(
        () => ForgetPasswordViewModel(instance<ForgetPasswordUseCase>()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    ///  RegisterUseCase
    instance.registerFactory<RegisterUseCase>(
        () => RegisterUseCase(instance<Repository>()));

    /// Register view model
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance<RegisterUseCase>()));

    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    ///  UseCase
    instance.registerFactory<HomeUseCase>(
        () => HomeUseCase(instance<Repository>()));

    instance
        .registerFactory<AdsUseCase>(() => AdsUseCase(instance<Repository>()));
    instance.registerFactory<MenProductUseCase>(
        () => MenProductUseCase(instance<Repository>()));
    instance.registerFactory<WomenProductUseCase>(
        () => WomenProductUseCase(instance<Repository>()));
    instance.registerFactory<JeweleryProductUseCase>(
        () => JeweleryProductUseCase(instance<Repository>()));
    instance.registerFactory<ElectronicsProductUseCase>(
        () => ElectronicsProductUseCase(instance<Repository>()));

    /// Register view model
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(
        instance<HomeUseCase>(),
        instance<AdsUseCase>(),
        instance<MenProductUseCase>(),
        instance<WomenProductUseCase>(),
        instance<JeweleryProductUseCase>(),
        instance<ElectronicsProductUseCase>()));
  }
}

initDetailsScreen(String id) {
  print("id from init details screen  = $id");
  if (!GetIt.I.isRegistered<ProductDetailsUseCase>()) {
    instance.registerFactory<ProductDetailsUseCase>(
        () => ProductDetailsUseCase(instance<Repository>()));

    ///  view model
    instance.registerFactory<ProductDetailsViewModel>(
        () => ProductDetailsViewModel(instance<ProductDetailsUseCase>(), id));
  } else {
    GetIt.I.unregister<ProductDetailsViewModel>();
    instance.registerFactory<ProductDetailsViewModel>(
        () => ProductDetailsViewModel(instance<ProductDetailsUseCase>(), id));
  }
}


initCartScreen() {
  if (!GetIt.I.isRegistered<CartUseCase>()) {
    instance.registerFactory<CartUseCase>(
        () => CartUseCase(instance<Repository>()));

    ///  view model
    instance.registerFactory<CartViewModel>(
        () => CartViewModel(instance<CartUseCase>() ));
  }
}
