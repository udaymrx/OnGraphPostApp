import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_graph_assesment/constant/colors.dart';
import 'package:on_graph_assesment/global_providers.dart';
import 'package:on_graph_assesment/view/playback/widgets/post_screen.dart';

import 'widgets/post_shimmer.dart';

class PlaybackPage extends StatefulWidget {
  const PlaybackPage({super.key});

  @override
  State<PlaybackPage> createState() => _PlaybackPageState();
}

class _PlaybackPageState extends State<PlaybackPage> {
  int initialPage = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(builder: (context, ref, child) {
          final hasNext = ref.watch(hasNextProvider);
          final res = ref.watch(postListProvider);

          return res.when(
            data: (data) {
              return PageView.builder(
                scrollDirection: Axis.vertical,
                onPageChanged: (currentPage) {
                  if (currentPage == data.length) {
                    if (hasNext) {
                      ref
                          .read(postListProvider.notifier)
                          .fetchNextPosts(initialPage);
                      initialPage++;
                      setState(() {});
                    }
                  }
                },
                itemBuilder: (context, index) {
                  if (index == (data.length)) {
                    return const PostShimmer();
                  } else {
                    return PostScreen(
                      post: data[index],
                    );
                  }
                },
                itemCount: hasNext ? data.length + 1 : data.length,
              );
            },
            error: (error, stackTrace) => Stack(
              alignment: Alignment.center,
              children: [
                const PostShimmer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    error.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            loading: () => const PostShimmer(),
          );
        }),
      ),
    );
  }
}
