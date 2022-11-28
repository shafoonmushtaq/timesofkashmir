import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:timesofkashmir/core/usecases/usecase.dart';
import 'package:timesofkashmir/features/news/domain/repositories/news_repository.dart';
import 'package:timesofkashmir/core/error/failures.dart';
import 'package:timesofkashmir/features/news/domain/entities/news.dart';

class GetNewsUseCase extends UseCase<List<News>, Params> {
  final NewsRepository repository;

  GetNewsUseCase(this.repository);

  @override
  Future<Either<Failure, List<News>>> call(Params params) async {
    return repository.getNews(params.number, params.number2);
  }
}

class Params extends Equatable {
  final int number;
  final int number2;

  const Params({required this.number, this.number2 = 0});

  @override
  List<Object?> get props => [number, number2];
}
