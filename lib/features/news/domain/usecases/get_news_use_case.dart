import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:timesofkashmir/core/usecases/usecase.dart';
import '../repositories/news_repository.dart';
import '../../../../core/error/failures.dart';
import '../entities/news.dart';

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

  const Params({required this.number, required this.number2});

  @override
  List<Object?> get props => [number, number2];
}
