import 'package:dartz/dartz.dart';
import 'package:timesofkashmir/core/usecases/usecase.dart';
import 'package:timesofkashmir/features/news/domain/repositories/news_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/Post.dart';
import 'get_news_use_case.dart';

class GetPostUseCase extends UseCase<Post, Params> {
  final NewsRepository repository;

  GetPostUseCase(this.repository);

  @override
  Future<Either<Failure, Post>> call(Params params) async {
    return repository.getPost(params.number);
  }
}
