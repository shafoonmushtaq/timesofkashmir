import 'package:http/http.dart' as http;
import 'package:timesofkashmir/core/error/exceptions.dart';

import '../../../../core/util/environment.dart';
import '../models/post_model.dart';

abstract class PostRemoteDataSource {
  /// Calls the https://www.timesofkashmir.in/wp-json/wp/v2/posts/{postId} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<PostModel> getPost(int postId);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<PostModel> getPost(int postId) {
    return _getPostFromUrl(
      "${baseUrl}wp-json/wp/v2/posts/$postId",
    );
  }

  Future<PostModel> _getPostFromUrl(String url) async {
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return postModelFromJson(response.body);
      } else {
        throw Exception();
      }
    } catch (_) {
      throw Exception();
    }
  }
}
