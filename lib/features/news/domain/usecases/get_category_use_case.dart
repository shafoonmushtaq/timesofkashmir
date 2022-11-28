import 'package:dartz/dartz.dart';
import 'package:timesofkashmir/core/usecases/usecase.dart';
import 'package:timesofkashmir/features/news/domain/repositories/news_repository.dart';
import 'package:timesofkashmir/core/error/failures.dart';
import 'package:timesofkashmir/features/news/domain/entities/category.dart';

class GetCategoryUseCase extends UseCase<List<Category>, NoParams> {
  final NewsRepository repository;

  GetCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) {
    return repository.getCategory();
  }
}
