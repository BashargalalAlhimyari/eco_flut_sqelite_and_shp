import 'package:flutter_application_2/core/network/api_service.dart';
import 'package:flutter_application_2/core/theme/theme_provider.dart';
import 'package:flutter_application_2/dataSourse/local_storage/categories_local_storage.dart';
import 'package:flutter_application_2/dataSourse/local_storage/products_local_storage.dart';
import 'package:flutter_application_2/dataSourse/remote_storage/categories_remote_storage.dart';
import 'package:flutter_application_2/dataSourse/remote_storage/products_remote_storage.dart';
import 'package:flutter_application_2/providers/cart_provider.dart';
import 'package:flutter_application_2/providers/category_provider.dart';
import 'package:flutter_application_2/providers/favorite_provider.dart';
import 'package:flutter_application_2/providers/product_provider.dart';
import 'package:flutter_application_2/repo/category_repo.dart';
import 'package:flutter_application_2/repo/product_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

// استيراد الطبقات الخاصة بك
final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Products & Categories
  
  sl.registerFactory(() => ProductsProvider(repository: sl()));
  sl.registerFactory(() => CategoriesProvider(repository: sl()));
  sl.registerFactory(() => FavoritesProvider(localDataSource: sl()));
  sl.registerFactory(() => CartProvider(localDataSource: sl()));
  sl.registerFactory(() => ThemeProvider()); 


  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // 3. Data Sources
  sl.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductsRemoteDataSourceImp(apiService: sl()),
  );
  sl.registerLazySingleton<CategoriesRemoteDataSource>(
    () => CategoriesRemoteDataSourceImp(apiService: sl()),
    
  );

  sl.registerLazySingleton<CategoriesLocalDataSource>(
    () => CategoriesLocalDataSourceImp(), // تأكد من مطابقة الاسم لديك
  );
  sl.registerLazySingleton<ProductsLocalDataSource>(
    () => ProductsLocalDataSourceImp(),
  );

  //! Core (الأدوات المشتركة)
  sl.registerLazySingleton(() => ApiService(sl())); // يمرر له الـ Dio


  //! External (المكتبات الخارجية)
  sl.registerLazySingleton(() => Dio());
}