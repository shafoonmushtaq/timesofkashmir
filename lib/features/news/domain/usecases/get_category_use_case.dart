import 'package:dartz/dartz.dart';
import '/core/usecases/usecase.dart';
import '/features/news/domain/repositories/news_repository.dart';
import '/core/error/failures.dart';
import '/features/news/domain/entities/category.dart';

class GetCategoryUseCase extends UseCase<List<Category>, NoParams> {
  final NewsRepository repository;

  GetCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) {
    return repository.getCategory();
  }
}
