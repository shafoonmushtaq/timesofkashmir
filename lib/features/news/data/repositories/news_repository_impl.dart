import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/Post.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/news.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/categories_remote_data_sources.dart';
import '../datasources/news_remote_data_source.dart';
import '../datasources/post_remote_data_source.dart';

class NewsRepositoryImpl extends NewsRepository {
  final NewsRemoteDataSource newsRemoteDataSource;
  final CategoriesRemoteDataSource categoriesRemoteDataSource;
  final PostRemoteDataSource postRemoteDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl({
    required this.newsRemoteDataSource,
    required this.categoriesRemoteDataSource,
    required this.postRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<News>>> getNews(
      int categoryId, int nextCount) async {
    if (await networkInfo.isConnected) {
      try {
        final news = await newsRemoteDataSource.getNews(categoryId, nextCount);
        return Right(news);
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategory() async {
    if (await networkInfo.isConnected) {
      try {
        final category = await categoriesRemoteDataSource.getCategory();
        return Right(category);
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, Post>> getPost(int postId) async {
    if (await networkInfo.isConnected) {
      try {
        final post = await postRemoteDataSource.getPost(postId);
        return Right(post);
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
