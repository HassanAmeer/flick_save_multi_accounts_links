import 'package:flick/provider/auth.dart';
import 'package:flick/provider/user_social_info.dart';
import 'package:flick/repo/auth_repo.dart';
import 'package:flick/repo/user_social_info_repo.dart';
import 'package:flick/utils/app_constant.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'datasource/remote/dio/dio_client.dart';
import 'datasource/remote/dio/logging_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  //sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(() => DioClient(AppConstant.baseUrl, sl(),
      loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(
      () => AuthRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => UserSocialInfoRepo(dioClient: sl(), sharedPreferences: sl()));

  // Provider
  sl.registerFactory(() => AuthProviders(authRepo: sl()));
  sl.registerFactory(() => UserSocialInfo(userSocialInfoRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
