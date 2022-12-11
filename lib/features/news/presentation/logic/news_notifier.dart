import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/network/network_info.dart';
import '/features/news/data/datasources/categories_remote_data_sources.dart';
import '/features/news/data/datasources/news_remote_data_source.dart';
import '/features/news/data/datasources/post_remote_data_source.dart';
import '/features/news/data/repositories/news_repository_impl.dart';
import '/features/news/domain/entities/Post.dart' as post;
import '/features/news/domain/usecases/get_category_use_case.dart';
import '/features/news/domain/usecases/get_post_use_case.dart';
import '/core/usecases/usecase.dart';
import '/features/news/domain/entities/news.dart';

import '/features/news/domain/entities/category.dart' as category;
import '/features/news/domain/usecases/get_news_use_case.dart';
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
      networkInfo: NetworkInfoImpl(),
      postRemoteDataSource: PostRemoteDataSourceImpl(client: httpClient));
}));

final getNewsUseCaseProvider = Provider<GetNewsUseCase>(((ref) {
  return GetNewsUseCase(ref.watch(newsRepositoryProvider));
}));

final getCategoryUseCaseProvider = Provider<GetCategoryUseCase>(((ref) {
  return GetCategoryUseCase(ref.watch(newsRepositoryProvider));
}));

final getPostUseCaseProvider = Provider<GetPostUseCase>(((ref) {
  return GetPostUseCase(ref.watch(newsRepositoryProvider));
}));

final newsNotifierProvider =
    StateNotifierProvider.family<NewsNotifier, AsyncValue<List<News>>, int>(
        ((ref, categoryId) {
  return NewsNotifier(
      getNewsUseCase: ref.watch(
        getNewsUseCaseProvider,
      ),
      catgoryId: categoryId);
}));

final categoryNotifierProvider = StateNotifierProvider<CategoryNotifier,
    AsyncValue<List<category.Category>>>(((ref) {
  return CategoryNotifier(
      getCategoryUseCase: ref.watch(getCategoryUseCaseProvider));
}));

final postNotifierProvider = StateNotifierProvider.autoDispose
    .family<PostNotifier, AsyncValue<post.Post>, int>(((ref, postId) {
  return PostNotifier(
      getPostUseCase: ref.watch(getPostUseCaseProvider), postId: postId);
}));

class NewsNotifier extends StateNotifier<AsyncValue<List<News>>> {
  NewsNotifier({required this.getNewsUseCase, required this.catgoryId})
      : super(const AsyncValue.loading()) {
    getPosts();
  }

  final GetNewsUseCase getNewsUseCase;
  final int catgoryId;
  int nextCount = 0;
  final List<News> _newsList = [];

  void getPosts() async {
    if (kDebugMode) {
      print("nextCount is $nextCount");
    }
    state = _newsList.isEmpty
        ? const AsyncValue.loading()
        : AsyncValue.data(_newsList);
    if (kDebugMode) {
      print("$nextCount is -->");
    }
    final newsOrFailure =
        await getNewsUseCase(Params(number: catgoryId, number2: nextCount));
    newsOrFailure.fold((l) {
      state = AsyncError(l.toString(), StackTrace.current);
    }, (r) {
      _newsList.addAll(r);
      state = AsyncValue.data(_newsList);
      nextCount = nextCount + 10;
    });
  }
}

class CategoryNotifier
    extends StateNotifier<AsyncValue<List<category.Category>>> {
  CategoryNotifier({required this.getCategoryUseCase})
      : super(const AsyncValue.loading()) {
    getCategories();
  }
  final GetCategoryUseCase getCategoryUseCase;

  void getCategories() async {
    state = const AsyncValue.loading();
    final categoryOrFailure = await getCategoryUseCase(NoParams());
    categoryOrFailure.fold((l) {
      state = AsyncError(l.toString(), StackTrace.current);
    }, (r) {
      state = AsyncValue.data(r);
    });
  }
}

class PostNotifier extends StateNotifier<AsyncValue<post.Post>> {
  PostNotifier({required this.getPostUseCase, required this.postId})
      : super(const AsyncValue.loading()) {
    getPostDetails();
  }
  final GetPostUseCase getPostUseCase;
  final int postId;

  void getPostDetails() async {
    state = const AsyncValue.loading();
    final postDetailOrFailure = await getPostUseCase(Params(number: postId));
    postDetailOrFailure.fold((l) {
      state = AsyncError(l.toString(), StackTrace.current);
    }, (r) {
      state = AsyncValue.data(r);
    });
  }
}
