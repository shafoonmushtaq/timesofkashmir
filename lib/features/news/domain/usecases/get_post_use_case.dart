import 'package:dartz/dartz.dart';
import '/core/usecases/usecase.dart';
import '/features/news/domain/repositories/news_repository.dart';

import '/core/error/failures.dart';
import '/features/news/domain/entities/Post.dart';
import '/features/news/domain/usecases/get_news_use_case.dart';

class GetPostUseCase extends UseCase<Post, Params> {
  final NewsRepository repository;

  GetPostUseCase(this.repository);

  @override
  Future<Either<Failure, Post>> call(Params params) async {
    return repository.getPost(params.number);
  }
}
