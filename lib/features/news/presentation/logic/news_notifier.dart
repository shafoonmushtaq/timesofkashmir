import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesofkashmir/core/network/network_info.dart';
import 'package:timesofkashmir/features/news/data/datasources/categories_remote_data_sources.dart';
import 'package:timesofkashmir/features/news/data/datasources/news_remote_data_source.dart';
import 'package:timesofkashmir/features/news/data/repositories/news_repository_impl.dart';
import 'package:timesofkashmir/features/news/domain/usecases/get_category_use_case.dart';
import 'package:timesofkashmir/features/news/presentation/logic/category_state.dart';
import 'package:timesofkashmir/features/news/presentation/logic/news_state.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/news.dart';
import '../../domain/usecases/get_news_use_case.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

final httpClientProvider = Provider<Client>((ref) {
  return http.Client();
});

final newsRepositoryProvider = Provider<NewsRepositoryImpl>(((ref) {
  var httpClient = ref.watch(httpClientProvider);
  return NewsRepositoryImpl(
      newsRemoteDataSource: NewsRemoteDataSourceImpl(client: httpClient),
      categoriesRemoteDataSource:
          CategoriesRemoteDataSourceImpl(client: httpClient),
      networkInfo: NetworkInfoImpl());
}));

final getNewsUseCaseProvider = Provider<GetNewsUseCase>(((ref) {
  return GetNewsUseCase(ref.watch(newsRepositoryProvider));
}));

final getCategoryUseCaseProvider = Provider<GetCategoryUseCase>(((ref) {
  return GetCategoryUseCase(ref.watch(newsRepositoryProvider));
}));

final newsNotifierProvider =
    StateNotifierProvider.family<NewsNotifier, NewsState, int>(
        ((ref, categoryId) {
  return NewsNotifier(
      getNewsUseCase: ref.watch(
        getNewsUseCaseProvider,
      ),
      catgoryId: categoryId);
}));

final categoryNotifierProvider =
    StateNotifierProvider<CategoryNotifier, CategoryState>(((ref) {
  return CategoryNotifier(
      getCategoryUseCase: ref.watch(getCategoryUseCaseProvider));
}));

class NewsNotifier extends StateNotifier<NewsState> {
  NewsNotifier({required this.getNewsUseCase, required this.catgoryId})
      : super(const NewsState.loading()) {
    getPosts();
  }

  final GetNewsUseCase getNewsUseCase;
  final int catgoryId;
  int nextCount = 0;
  final List<News> _newsList = [];

  void getPosts() async {
    state = _newsList.isEmpty
        ? const NewsState.loading()
        : NewsState.data(news: _newsList);
    if (kDebugMode) {
      print("$nextCount is -->");
    }
    final newsOrFailure =
        await getNewsUseCase(Params(number: catgoryId, number2: nextCount));
    newsOrFailure.fold((l) {
      state = const NewsState.error();
    }, (r) {
      _newsList.addAll(r);
      state = NewsState.data(news: _newsList);
      nextCount = nextCount + 10;
    });
  }
}

class CategoryNotifier extends StateNotifier<CategoryState> {
  CategoryNotifier({required this.getCategoryUseCase})
      : super(const CategoryState.loading()) {
    getCategories();
  }
  final GetCategoryUseCase getCategoryUseCase;

  void getCategories() async {
    state = const CategoryState.loading();
    final categoryOrFailure = await getCategoryUseCase(NoParams());
    categoryOrFailure.fold((l) {
      state = const CategoryState.error();
    }, (r) {
      state = CategoryState.data(category: r);
    });
  }
}
