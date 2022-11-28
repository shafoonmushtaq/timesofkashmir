import 'package:dartz/dartz.dart';

import 'package:timesofkashmir/core/error/failures.dart';
import 'package:timesofkashmir/core/network/network_info.dart';
import 'package:timesofkashmir/features/news/domain/entities/Post.dart';
import 'package:timesofkashmir/features/news/domain/entities/category.dart';
import 'package:timesofkashmir/features/news/domain/entities/news.dart';
import 'package:timesofkashmir/features/news/domain/repositories/news_repository.dart';
import 'package:timesofkashmir/features/news/data/datasources/categories_remote_data_sources.dart';
import 'package:timesofkashmir/features/news/data/datasources/news_remote_data_source.dart';
import 'package:timesofkashmir/features/news/data/datasources/post_remote_data_source.dart';

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
