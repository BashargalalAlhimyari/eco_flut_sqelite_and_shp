import 'package:dartz/dartz.dart';

import 'package:flutter_application_2/core/errors/failure.dart';
import 'package:flutter_application_2/core/network/check_internet.dart';
import 'package:flutter_application_2/dataSourse/local_storage/products_local_storage.dart';
import 'package:flutter_application_2/dataSourse/remote_storage/products_remote_storage.dart';
import 'package:flutter_application_2/models/product.dart';

class ProductRepository {
  final ProductsRemoteDataSource remoteDataSource;
  final ProductsLocalDataSource localDataSource;

  ProductRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    if ( !(await hasNoInternet())) {
      try {
        // 1. جلب البيانات من السيرفر
        final remoteProducts = await remoteDataSource.getAllProducts();
        
        // 2. تحديث التخزين المحلي (المزامنة)
        await localDataSource.cacheProducts(remoteProducts);
        
        return Right(remoteProducts);
      } catch (e) {
        return Left(ServerFailure("")); // فشل في الاتصال بالسيرفر
      }
    } else {
      try {
        // 3. جلب البيانات المخزنة محلياً عند عدم وجود إنترنت
        final localProducts = await localDataSource.getCachedProducts();
        return Right(localProducts);
      } catch (e) {
        return Left(CacheFailure("")); // فشل في جلب البيانات من الكاش (قد يكون فارغاً)
      }
    }
  }
}