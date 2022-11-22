import 'package:dartz/dartz.dart';
import 'package:timesofkashmir/features/news/domain/entities/category.dart';

import '../../../../core/error/failures.dart';
import '../entities/Post.dart';
import '../entities/news.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<News>>> getNews(int categoryId, int nextCount);

  Future<Either<Failure, List<Category>>> getCategory();

  Future<Either<Failure, Post>> getPost(int postId);
}
