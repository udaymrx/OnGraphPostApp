import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/post_list_cotroller.dart';
import 'model/post_model.dart';

final postListProvider =
    StateNotifierProvider<PostListNotifier, AsyncValue<List<Post>>>((ref) {
  return PostListNotifier(ref);
});

final hasNextProvider = StateNotifierProvider<HasNextNotifier, bool>((ref) {
  return HasNextNotifier();
});

class HasNextNotifier extends StateNotifier<bool> {
  HasNextNotifier() : super(true);

  void changeValue(bool hasNext) {
    state = hasNext;
  }
}
