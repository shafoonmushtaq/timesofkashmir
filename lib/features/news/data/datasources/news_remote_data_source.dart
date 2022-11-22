import 'package:timesofkashmir/core/error/exceptions.dart';
import 'package:timesofkashmir/features/news/data/models/news_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/util/environment.dart';

abstract class NewsRemoteDataSource {
  /// Calls the https://www.timesofkashmir.in/wp-json/wp/v2/posts/ endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<NewsModel>> getNews(int categoryId, int nextCount);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;

  NewsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NewsModel>> getNews(int categoryId, int nextCount) {
    return _getNewsFromUrl(
      "${baseUrl}wp-json/wp/v2/posts?categories=$categoryId&per_page=20&offset=$nextCount",
    );
  }

  Future<List<NewsModel>> _getNewsFromUrl(String url) async {
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return newsModelFromJson(response.body);
      } else {
        throw Exception();
      }
    } catch (_) {
      throw Exception();
    }
  }
}
