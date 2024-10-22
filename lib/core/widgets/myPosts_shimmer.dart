import 'package:Mevo/constants/padding_constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyPostsShimmer extends StatelessWidget with PaddingConstants {
  const MyPostsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: Colors.grey.shade300,
      period: const Duration(seconds: 1),
      child: ListView.separated(
        itemBuilder: (context, index) {
          // ignore: sized_box_for_whitespace
          return buildMyPostsShimmerBody(context);
        },
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 20);
        },
      ),
    );
  }

  Container buildMyPostsShimmerBody(BuildContext context) {
    return Container(
      padding: buildDefaultSymetricHorizontalPadding(context),
      child: Wrap(
        runSpacing: spacingDeepLow(context),
        children: [
          ListTile(
            contentPadding: buildDefaultSymetricHorizontalPadding(context),
            title: Row(
              children: [
                CircleAvatar(radius: profileViewAvatarSize),
                const SizedBox(width: 5),
                Container(
                  height: 10,
                  width: 50,
                  color: Colors.amber,
                ),
                const SizedBox(width: 5),
                Container(
                  height: 10,
                  width: 50,
                  color: Colors.amber,
                )
              ],
            ),
            trailing: const Icon(Icons.more_horiz),
          ),
          Padding(
              padding: buildDefaultSymetricHorizontalPadding(context),
              child: Container(
                height: 10,
                color: Colors.amber,
              )),
          const SizedBox(height: 15),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            color: Colors.amber,
          ),
          Padding(
            padding: defaultPadding,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('0'),
                Icon(Icons.mode_comment_outlined),
                SizedBox(
                  width: 10,
                ),
                Text('0'),
                Icon(
                  Icons.favorite_border_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
