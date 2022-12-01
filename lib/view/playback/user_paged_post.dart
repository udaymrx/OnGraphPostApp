// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// import '../../model/post_model.dart';

// class UserPagedPost extends ConsumerStatefulWidget {
//   const UserPagedPost({super.key});

//   @override
//   ConsumerState<UserPagedPost> createState() => _UserPagedPostState();
// }

// class _UserPagedPostState extends ConsumerState<UserPagedPost>
//     with AutomaticKeepAliveClientMixin {
//   final _pagingController =
//       PagingController<int, Post>(firstPageKey: 0, invisibleItemsThreshold: 10);

//   String? nextLink;

//   @override
//   void initState() {
//     _pagingController.addPageRequestListener((pageKey) {
//       _fetchPage(pageKey);
//     });
//     super.initState();
//   }

//   Future<void> _fetchPage(int pageKey) async {
//     try {
//       Posts newPage;
//       if (pageKey == 0) {
//         newPage = await ref.read(postApi).getUserPost(UserPreferences.userId);
//         nextLink = newPage.nextUrl;
//         await ref.read(postRepo).addUserPosts(newPage.posts);
//       } else {
//         newPage = await ref.read(postApi).getNextUserPost(nextLink!);
//         nextLink = newPage.nextUrl;
//       }
//       final newPost = newPage.posts;

//       final isLastPage = newPage.nextUrl == null;

//       if (isLastPage) {
//         _pagingController.appendLastPage(newPost);
//       } else {
//         final nextPageKey = pageKey + 1;
//         _pagingController.appendPage(newPost, nextPageKey);
//       }
//     } on NoInternetException catch (e) {
//       await ref.read(postRepo).openPostBox();
//       final val = ref.read(postRepo).userPostsList;
//       if (val.isNotEmpty) {
//         _pagingController.appendLastPage(val);
//       } else {
//         _pagingController.error = e;
//       }
//     } catch (error) {
//       _pagingController.error = error;
//     }
//   }

//   @override
//   void dispose() {
//     _pagingController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return RefreshIndicator(
//       onRefresh: () => Future.sync(
//         () => _pagingController.refresh(),
//       ),
//       child: PagedListView(
//         builderDelegate: PagedChildBuilderDelegate<Post>(
//           itemBuilder: (context, post, index) => PostWidgetUserMain(
//             post: post,
//             pagingController: _pagingController,
//           ),
//           firstPageErrorIndicatorBuilder: (context) {
//             final posts = ref.watch(postRepo).userPostsList;
//             return posts.isNotEmpty
//                 ? Column(
//                     children: [
//                       for (int i = 0; i < posts.length; i++)
//                         PostWidgetUserMain(
//                           post: posts[i],
//                           pagingController: _pagingController,
//                         ),
//                     ],
//                   )
//                 : const NoPostWidget();
//           },
//           // firstPageErrorIndicatorBuilder: (context) => NoInternetWidget(
//           //     retry: _pagingController.retryLastFailedRequest),
//           firstPageProgressIndicatorBuilder: (context) => const PostShimmer(),
//           noItemsFoundIndicatorBuilder: (context) => const NoPostWidget(),
//         ),
//         physics: const BouncingScrollPhysics(),
//         pagingController: _pagingController,
//       ),
//     );
//   }

//   @override
//   // TODO: implement wantKeepAlive
//   bool get wantKeepAlive => true;
// }
