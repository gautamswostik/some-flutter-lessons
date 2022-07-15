import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fluuter_boilerplate/app_setup/dio/dio_client.dart';
import 'package:fluuter_boilerplate/infrastructure/infinite_list_repo/entites/post_model.dart';

abstract class IGetPosts {
  Future<Either<String, List<PostModel>>> getPosts({required int page});
}

class GetPostsRepository extends IGetPosts {
  final Dio _dioClient = dioClient();
  @override
  Future<Either<String, List<PostModel>>> getPosts({required int page}) async {
    try {
      final respose = await _dioClient.get(
        'posts',
        queryParameters: {
          '_page': page,
        },
      );
      log('$respose');
      List<PostModel> list = [];
      for (var item in respose.data) {
        list.add(PostModel.fromJson(item));
      }
      return Right(list);
    } on DioError catch (e) {
      return Left(e.message);
    }
  }
}
