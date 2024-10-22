import 'package:Mevo/constants/padding_constants.dart';
import 'package:Mevo/constants/string_constants.dart';
import 'package:Mevo/core/auth_manager.dart';
import 'package:Mevo/home/discover/model/discover_model.dart';
import 'package:Mevo/home/discover/service/discover_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/discover_view_model.dart';

class DiscoverView extends DiscoverViewModel
    with StringConstants, PaddingConstants {
  late bool isLike;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(discoverAppBarTitleText),
        // leading: Padding(
        //   padding: defaultPadding,
        //   child: Image.asset('assets/icons-infinity.gif'),
        // ),
        actions: [
          Padding(
            padding: appBarActinonsPadding(context),
            child: const Icon(Icons.message),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              isLike =
                  callDiscoverModel(context)?.posts?[index].isLiked ?? false;
              return Container(
                padding: buildDefaultSymetricHorizontalPadding(context),
                child: Wrap(
                  runSpacing: spacingDeepLow(context),
                  children: [
                    buildListTile(context, index),
                    postsContent(context, index),
                    postsImage(context, index),
                    postsCommentAndLikes(context, index),
                  ],
                ),
              );
            },
                childCount: context
                    .read<AuthenticationManager>()
                    .discoverModel
                    ?.totalCount),
          ),
        ],
      ),
    );
  }

  Padding postsCommentAndLikes(BuildContext context, int index) {
    return Padding(
      padding: defaultPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(callDiscoverModel(context)!
              .posts![index]
              .totalComments
              .toString()),
          const Icon(Icons.mode_comment_outlined),
          const SizedBox(
            width: 10,
          ),
          Text(callDiscoverModel(context)!.posts![index].totalLikes.toString()),
          GestureDetector(
            onTap: () {
              isLike
                  ? DiscoverService(context).deleteLike(
                      callDiscoverModel(context)?.posts?[index].id.toString() ??
                          '')
                  : DiscoverService(context).postLikePosts(
                      callDiscoverModel(context)?.posts?[index].id.toString() ??
                          '');
              setState(() {
                isLike = !isLike;
              });
              print(isLike);
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

  Padding postsContent(BuildContext context, int index) {
    return Padding(
      padding: buildDefaultSymetricHorizontalPadding(context),
      child: Text(callDiscoverModel(context)!.posts?[index].content ?? ''),
    );
  }

  ClipRRect postsImage(BuildContext context, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: callDiscoverModel(context)!.posts?[index].mediaUrl != null
          ? Image.network(
              callDiscoverModel(context)!.posts?[index].mediaUrl ??
                  'https://149359637.v2.pressablecdn.com/wp-content/uploads/2021/08/Space-Earth-Wallpaper-About-Murals.jpg',
              fit: BoxFit.cover,
            )
          : Container(),
    );
  }

  Widget postImage(BuildContext context, int index, bool haveImage) {
    if (haveImage == true) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          callDiscoverModel(context)!.posts?[index].mediaUrl ??
              'https://149359637.v2.pressablecdn.com/wp-content/uploads/2021/08/Space-Earth-Wallpaper-About-Murals.jpg',
          fit: BoxFit.cover,
        ),
      );
    }
    return Container();
  }

  ListTile buildListTile(BuildContext context, int index) {
    return ListTile(
      contentPadding: buildDefaultSymetricHorizontalPadding(context),
      // leading:
      title: Row(
        children: [
          CircleAvatar(
            radius: discoverPostsAvatarSize,
            backgroundImage: NetworkImage(callDiscoverModel(context)!
                    .posts![index]
                    .user!
                    .avatar!
                    .mediaUrl ??
                'https://avatars.githubusercontent.com/u/81019405?v=4'),
          ),
          const SizedBox(width: 5),
          Consumer(
            builder: (context, value, child) => GestureDetector(
              onTap: () {
                // tiklandiginda profile update sayfasina gidecek
              },
              child: Text(
                callDiscoverModel(context)?.posts?[index].user?.username ?? '',
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            getTimeAgo(
                callDiscoverModel(context)!.posts![index].createdAt.toString()),
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
          )
        ],
      ),
      trailing: const Icon(Icons.more_horiz),
    );
  }

  DiscoverModel? callDiscoverModel(BuildContext context) =>
      context.read<AuthenticationManager>().discoverModel;

  bool isHaveImage(BuildContext context) {
    bool image = (context
                .read<AuthenticationManager>()
                .discoverModel!
                .posts![5]
                .mediaUrl)!
            .isEmpty
        ? false
        : true;
    return image;
  }

  Widget postClipRRectImage(bool haveImage) {
    if (haveImage == isHaveImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          callDiscoverModel(context)!.posts?[5].mediaUrl ??
              'https://149359637.v2.pressablecdn.com/wp-content/uploads/2021/08/Space-Earth-Wallpaper-About-Murals.jpg',
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container();
    }
  }
}

String getTimeAgo(String pastDate) {
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
}
