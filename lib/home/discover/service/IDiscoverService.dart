// ignore: file_names
import 'package:Mevo/home/discover/model/discover_model.dart';
import 'package:dio/dio.dart';

abstract class IDiscoverService {
  late Dio dio;

  Future<DiscoverModel?> postPostAuth(String token);
  Future<bool?> postLikePosts(String postId);
  Future<bool?> deleteLike(String postId);
}

enum IDiscoverServicePath {
  ALL('/posts/all?'),
  POSTS('/posts/'),
  LIKES('/likes/');

  final String name;

  const IDiscoverServicePath(this.name);
}

//TODO: yorum sayfasini olustur servisten yorumlari cek