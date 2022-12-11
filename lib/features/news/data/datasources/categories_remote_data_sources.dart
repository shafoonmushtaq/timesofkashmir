import '/core/error/exceptions.dart';
import '/features/news/data/models/category_model.dart';
import 'package:http/http.dart' as http;

import '/core/util/configurations.dart';
import '/core/util/environment.dart';

abstract class CategoriesRemoteDataSource {
  /// Calls the https://www.timesofkashmir.in/wp-json/wp/v2/categories/?per_page=100 endpoint.
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
      "${baseUrl}wp-json/wp/v2/categories/?per_page=100",
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
        var list = categoryFromJson(response.body);
        List<CategoryModel> newList = [];
        for (var category in categoryOrder) {
          if (list.index(category) != -1) {
            var entity = list.removeAt(list.index(category));
            newList.add(entity);
          }
        }
        newList.addAll(list);
        return newList;
      } else {
        throw Exception();
      }
    } catch (_) {
      throw Exception();
    }
  }
}

extension IndexIt on List<CategoryModel> {
  int index(String name) {
    for (var element in this) {
      if (element.name == name) {
        return indexOf(element);
      }
    }
    return -1;
  }
}
