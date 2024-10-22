import 'package:Mevo/constants/padding_constants.dart';
import 'package:Mevo/constants/string_constants.dart';
import 'package:Mevo/core/auth_manager.dart';
import 'package:Mevo/core/widgets/myPosts_shimmer.dart';
import 'package:Mevo/home/profile/myPostsPage/viewmodel/my_posts_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPostsView extends MyPostsViewModel
    with PaddingConstants, StringConstants {
  late bool isLike;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(myPostsAppBarTitleText),
      ),
      body: myPostsModel != null ? buildMyPostsList : const MyPostsShimmer(),
    );
  }

  CustomScrollView get buildMyPostsList {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            isLike = myPostsModel?.posts?[index].isLiked ?? false;
            return Container(
              padding: buildDefaultSymetricHorizontalPadding(context),
              child: Wrap(
                runSpacing: spacingDeepLow(context),
                children: [
                  buildListTile(context, index),
                  buildPostsContent(context, index),
                  buildPostsImage(index),
                  buildPoststCommentAndLikes(index),
                ],
              ),
            );
          }, childCount: myPostsModel?.totalCount),
        ),
      ],
    );
  }

  ListTile buildListTile(BuildContext context, int index) {
    return ListTile(
      contentPadding: buildDefaultSymetricHorizontalPadding(context),
      title: Row(
        children: [
          CircleAvatar(
            radius: discoverPostsAvatarSize,
            backgroundImage: NetworkImage(
                myPostsModel?.posts?[index].user?.avatar?.mediaUrl ??
                    dummyProfilePicture),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {},
            child: Text(
              myPostsModel?.posts?[index].user?.username ??
                  context
                      .read<AuthenticationManager>()
                      .userModel!
                      .username
                      .toString(),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            getTimeAgo(myPostsModel?.posts?[index].createdAt.toString() ?? ''),
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
          ),
        ],
      ),
      trailing: const Icon(Icons.more_horiz),
    );
  }

  Padding buildPostsContent(BuildContext context, int index) {
    return Padding(
        padding: buildDefaultSymetricHorizontalPadding(context),
        child: Text(myPostsModel!.posts?[index].content ?? ''));
  }

  ClipRRect buildPostsImage(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: myPostsModel?.posts?[index].mediaUrl != null
          ? Image.network(
              myPostsModel?.posts?[index].mediaUrl ?? dummyPostImage,
              fit: BoxFit.cover)
          : Container(),
    );
  }

  Padding buildPoststCommentAndLikes(int index) {
    return Padding(
      padding: defaultPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(myPostsModel?.posts?[index].totalComments.toString() ?? '0'),
          const Icon(Icons.mode_comment_outlined),
          const SizedBox(
            width: 10,
          ),
          Text(myPostsModel?.posts?[index].totalLikes.toString() ?? '0'),
          GestureDetector(
            onTap: () {
              isLike = !isLike;
            },
            child: isLike == false
                ? const Icon(
                    Icons.favorite_border_outlined,
                  )
                : const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
          ),
        ],
      ),
    );
  }
}

String getTimeAgo(String pastDate) {
  try {
    DateTime createdAt = DateTime.parse(pastDate);
    Duration difference = DateTime.now().difference(createdAt);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} yıl önce';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} ay önce';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} gün önce';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} saat önce';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} dakika önce';
    } else {
      return 'Şimdi';
    }
  } catch (e) {
    print('Geçersiz tarih biçimi: $pastDate');
    return '';
  }
}
