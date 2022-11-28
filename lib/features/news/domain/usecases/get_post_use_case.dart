import 'package:dartz/dartz.dart';
import 'package:timesofkashmir/core/usecases/usecase.dart';
import 'package:timesofkashmir/features/news/domain/repositories/news_repository.dart';

import 'package:timesofkashmir/core/error/failures.dart';
import 'package:timesofkashmir/features/news/domain/entities/Post.dart';
import 'package:timesofkashmir/features/news/domain/usecases/get_news_use_case.dart';

class GetPostUseCase extends UseCase<Post, Params> {
  final NewsRepository repository;

  GetPostUseCase(this.repository);

  @override
  Future<Either<Failure, Post>> call(Params params) async {
    return repository.getPost(params.number);
  }
}
