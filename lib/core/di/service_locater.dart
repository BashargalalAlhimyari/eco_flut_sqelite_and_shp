import 'package:flutter_application_2/core/network/api_service.dart';
import 'package:flutter_application_2/core/theme/theme_provider.dart';
import 'package:flutter_application_2/dataSourse/local_storage/app_local_storage.dart';
import 'package:flutter_application_2/providers/cart_provider.dart';
import 'package:flutter_application_2/providers/favorite_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => FavoritesProvider());
  sl.registerFactory(() => CartProvider(localDataSource: sl()));
  sl.registerFactory(() => ThemeProvider()); 

  sl.registerLazySingleton<AppLocalDataSource>(
    () => AppLocalDataSourceImp(),
  );

  sl.registerLazySingleton(() => ApiService(sl()));
  sl.registerLazySingleton(() => Dio());
}