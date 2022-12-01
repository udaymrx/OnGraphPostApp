import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_graph_assesment/data/repository/post_repo.dart';
import 'package:on_graph_assesment/model/post_model.dart';

final postRepoProvider = Provider<PostRepository>((ref) {
  return PostRepository(ref);
});


class PostListNotifier extends StateNotifier<AsyncValue<List<Post>>> {
  PostListNotifier(this.ref) : super(const AsyncValue.data([])) {
    _fetchFirstPosts();
  }

  final Ref ref;

  Future<void> _fetchFirstPosts() async {
    try {
      List<Post> newPosts = await ref.read(postRepoProvider).getPostData(0);
      state = AsyncValue.data(newPosts);
    } on Exception catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> fetchNextPosts(int page) async {
    List<Post> posts = state.asData!.value;

    try {
      var newPosts = await ref.read(postRepoProvider).getPostData(page);
      posts.addAll(newPosts);

      state = AsyncValue.data(posts);
    } on Exception catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
