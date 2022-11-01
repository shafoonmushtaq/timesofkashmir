import 'package:timesofkashmir/core/error/exceptions.dart';
import 'package:timesofkashmir/features/news/data/models/category_model.dart';
import 'package:timesofkashmir/features/news/data/models/news_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/util/environment.dart';

abstract class CategoriesRemoteDataSource {
  /// Calls the https://www.timesofkashmir.in/wp-json/wp/v2/posts/ endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CategoryModel>> getCategory();
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final http.Client client;

  CategoriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CategoryModel>> getCategory() {
    return _getCategoriesFromUrl(
      "${baseUrl}wp-json/wp/v2/categories",
    );
  }

  Future<List<CategoryModel>> _getCategoriesFromUrl(String url) async {
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return categoryFromJson(response.body);
      } else {
        throw Exception();
      }
    } catch (_) {
      throw Exception();
    }
  }
}
