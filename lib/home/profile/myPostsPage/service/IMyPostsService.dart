import 'package:Mevo/home/profile/myPostsPage/model/my_posts_model.dart';
import 'package:dio/dio.dart';

abstract class IMyPostsService {
  late Dio dio;

  Future<MyPostsModel?> postGetMyPosts(String token);
}

enum IMyPostsServicePath {
  All('/posts/all/');

  final String name;
  const IMyPostsServicePath(this.name);
}
