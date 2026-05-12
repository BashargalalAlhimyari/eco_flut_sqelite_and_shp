import 'package:dartz/dartz.dart';
import 'package:flutter_application_2/core/errors/failure.dart';
import 'package:flutter_application_2/core/network/check_internet.dart';
import 'package:flutter_application_2/dataSourse/local_storage/categories_local_storage.dart';
import 'package:flutter_application_2/dataSourse/remote_storage/categories_remote_storage.dart';

class CategoryRepository {
  final CategoriesRemoteDataSource remoteDataSource;
  final CategoriesLocalDataSource localDataSource;

  CategoryRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<Either<Failure, List<String>>> getCategories() async {
    if (!(await hasNoInternet())) {
      try {
        final remoteCategories = await remoteDataSource.getAllCategories();
        
        // حفظ الفئات محلياً
        await localDataSource.cacheCategories(remoteCategories);
        
        return Right(remoteCategories);
      } catch (e) {
        return Left(ServerFailure(""));
      }
    } else {
      try {
        final localCategories = await localDataSource.getCachedCategories();
        return Right(localCategories);
      } catch (e) {
        return Left(CacheFailure(""));
      }
    }
  }
}