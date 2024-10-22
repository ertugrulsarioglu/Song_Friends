// import 'package:Mevo/constants/padding_constants.dart';
// import 'package:Mevo/core/auth_manager.dart';
// import 'package:Mevo/home/discover/model/discover_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // ignore: must_be_immutable
// class PostWidget extends StatefulWidget {
//   const PostWidget({super.key});

//   @override
//   State<PostWidget> createState() => _PostWidgetState();
// }

// class _PostWidgetState extends State<PostWidget> with PaddingConstants {
//   late bool isLike;

//   @override
//   Widget build(BuildContext context) {
//     isLike = context
//             .read<AuthenticationManager>()
//             .discoverModel!
//             .posts?[5]
//             .isLiked ??
//         false;
//     return Container(
//       padding: buildDefaultSymetricHorizontalPadding(context),
//       child: Wrap(
//         runSpacing: spacingDeepLow(context),
//         children: [
//           buildListTile(context),
//           Padding(
//             padding: buildDefaultSymetricHorizontalPadding(context),
//             child:
//                 Text(callDiscoverModelPosts(context)!.posts?[5].content ?? ''),
//           ),
//           postClipRRectImage(true),
//           Padding(
//             padding: defaultPadding,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               // crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(callDiscoverModelPosts(context)!
//                     .posts![5]
//                     .totalComments
//                     .toString()),
//                 const Icon(Icons.mode_comment_outlined),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Text(callDiscoverModelPosts(context)!
//                     .posts![5]
//                     .totalLikes
//                     .toString()),
//                 GestureDetector(
//                   onTap: () {
//                     isLike = !isLike;
//                   },
//                   child: isLike == false
//                       ? const Icon(
//                           Icons.favorite_border_outlined,
//                         )
//                       : const Icon(
//                           Icons.favorite,
//                           color: Colors.red,
//                         ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget postClipRRectImage(bool haveImage) {
//     if (haveImage == isHaveImage) {
//       return ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Image.network(
//           callDiscoverModelPosts(context)!.posts?[5].mediaUrl ??
//               'https://149359637.v2.pressablecdn.com/wp-content/uploads/2021/08/Space-Earth-Wallpaper-About-Murals.jpg',
//           fit: BoxFit.cover,
//         ),
//       );
//     } else {
//       return Container();
//     }
//   }

//   ListTile buildListTile(BuildContext context) {
//     return ListTile(
//         contentPadding: buildDefaultSymetricHorizontalPadding(context),
//         // leading:
//         title: Row(
//           children: [
//             CircleAvatar(
//               radius: discoverPostsAvatarSize,
//               backgroundImage: NetworkImage(callDiscoverModelPosts(context)!
//                       .posts![5]
//                       .user!
//                       .avatar!
//                       .mediaUrl ??
//                   'https://avatars.githubusercontent.com/u/81019405?v=4'),
//             ),
//             const SizedBox(width: 5),
//             Text(
//               callDiscoverModelPosts(context)?.posts?[5].user?.username ?? '',
//               style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(width: 5),
//             Text(
//               getTimeAgo(callDiscoverModelPosts(context)!
//                   .posts![5]
//                   .createdAt
//                   .toString()),
//               style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
//             )
//           ],
//         ),
//         trailing: const Icon(Icons.more_horiz));
//   }

//   DiscoverModel? callDiscoverModelPosts(BuildContext context) {
//     return context.read<AuthenticationManager>().discoverModel;
//   }

//   bool? isHaveImage(BuildContext context) {
//     bool image = (context
//                 .read<AuthenticationManager>()
//                 .discoverModel!
//                 .posts![5]
//                 .mediaUrl)!
//             .isEmpty
//         ? false
//         : true;
//     return image;
//   }
// }

// String getTimeAgo(String pastDate) {
//   DateTime createdAt = DateTime.parse(pastDate);
//   Duration difference = DateTime.now().difference(createdAt);

//   if (difference.inDays > 365) {
//     return '${(difference.inDays / 365).floor()} yıl önce';
//   } else if (difference.inDays > 30) {
//     return '${(difference.inDays / 30).floor()} ay önce';
//   } else if (difference.inDays > 0) {
//     return '${difference.inDays} gün önce';
//   } else if (difference.inHours > 0) {
//     return '${difference.inHours} saat önce';
//   } else if (difference.inMinutes > 0) {
//     return '${difference.inMinutes} dakika önce';
//   } else {
//     return 'Şimdi';
//   }
// }
