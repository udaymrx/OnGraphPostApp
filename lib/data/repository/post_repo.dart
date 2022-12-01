import 'dart:async';
import 'dart:io';
import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:on_graph_assesment/global_providers.dart';

import '../../model/post_model.dart';
import '../api/api_client.dart';
import '../api/app_exception.dart';

class PostRepository {
  PostRepository(this.ref);

  final Ref ref;

  final int userId = 3;

  Future<List<Post>> getPostData([int page = 0]) async {
    List<Post> posts;
    int itemPerPage = 4;

    try {
      final http.Response res = await http
          .get(
            Uri.https(
              APIClient.baseUrl,
              '/api/post/all_posts',
              {
                "itemPerPage": itemPerPage.toString(),
                "page": page.toString(),
                "userId": userId.toString(),
              },
            ),
          )
          .timeout(const Duration(milliseconds: 10000));
      final jsonResponse = APIClient.returnResponse(res);
      var postData = PostData.fromJson(jsonResponse);
      var hsNxt = postData.data.nextPage != null;
      ref.read(hasNextProvider.notifier).changeValue(hsNxt);
      posts = postData.data.posts;
    } on SocketException catch (e) {
      developer.log(e.toString());
      throw NoInternetException();
    } on TimeoutException catch (e) {
      developer.log(e.toString());
      throw NoInternetException(
          'Taking too long to reach internet, Network call timeout.');
    } catch (e) {
      developer.log(e.toString());
      throw UnKnownException();
    }
    return posts;
  }

  Future<bool> likeDislike(int postId) async {
    bool liked = false;
    try {
      final res = await http.post(
        Uri.https(
          APIClient.baseUrl,
          '/api/post/like_dislike',
          {
            "userId": userId.toString(),
            "postId": postId.toString(),
          },
        ),
      );
      developer.log("${res.statusCode}");
      developer.log(res.body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        liked = true;
      } else {
        liked = false;
      }
    } on SocketException catch (e) {
      developer.log(e.toString());
      throw NoInternetException();
    } catch (e) {
      developer.log(e.toString());
      throw UnKnownException();
    }
    return liked;
  }
}
