import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:on_graph_assesment/constant/colors.dart';
import 'package:on_graph_assesment/controller/post_list_cotroller.dart';
import 'package:on_graph_assesment/view/playback/widgets/normal_video_player_widget.dart';

import '../../../model/post_model.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: double.maxFinite,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (post.postType == "image")
            Image.network(
              post.fileUrl,
              fit: BoxFit.contain,
            ),
          if (post.postType == "video") NewVideoPlayer(url: post.fileUrl),
          PostContent(post: post),
        ],
      ),
    );
  }
}

class PostContent extends StatelessWidget {
  const PostContent({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Following",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.white70,
                ),
              )
            ],
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                            image: DecorationImage(
                              image: NetworkImage(post.postBy.picUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "@${post.postBy.firstName} ${post.postBy.lastName}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      post.title,
                      style: const TextStyle(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      post.shortDescription,
                      style: const TextStyle(),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  MyLikeButton(post),
                  // LikeButton(
                  //   onTap: (isLiked) async {
                  //     return !isLiked;
                  //   },
                  //   likeBuilder: (isLiked) {
                  //     return Icon(
                  //       Icons.favorite_rounded,
                  //       color: isLiked ? const Color(0xFFE91E47) : Colors.white,
                  //       size: 30,
                  //     );
                  //   },
                  //   countBuilder: (likeCount, isLiked, text) {
                  //     return Text(
                  //       text,
                  //       style: const TextStyle(
                  //         fontSize: 12,
                  //         color: whitePrimary,
                  //       ),
                  //     );
                  //   },
                  //   likeCount: int.tryParse(post.likeCount),
                  //   countPostion: CountPostion.bottom,
                  // ),

                  const SizedBox(height: 8),
                  Column(
                    children: const [
                      Icon(
                        Icons.comment_rounded,
                        size: 30,
                      ),
                      Text(
                        '5',
                        style: TextStyle(
                          fontSize: 12,
                          color: whitePrimary,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: const [
                      Icon(
                        Icons.forward,
                        size: 30,
                      ),
                      Text(
                        '5',
                        style: TextStyle(
                          fontSize: 12,
                          color: whitePrimary,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MyLikeButton extends ConsumerWidget {
  const MyLikeButton(this.post, {super.key});

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LikeButton(
      onTap: (isLiked) async {
        final val = await ref.read(postRepoProvider).likeDislike(post.id);
        return !isLiked;
      },
      likeBuilder: (isLiked) {
        return Icon(
          Icons.favorite_rounded,
          color: isLiked ? const Color(0xFFE91E47) : Colors.white,
          size: 30,
        );
      },
      countBuilder: (likeCount, isLiked, text) {
        return Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: whitePrimary,
          ),
        );
      },
      likeCount: int.tryParse(post.likeCount),
      countPostion: CountPostion.bottom,
    );
  }
}
