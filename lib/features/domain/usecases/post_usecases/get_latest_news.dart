import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/domain/repositories/post_repository.dart';

class GetLatestNewsUseCase {
  final PostRepository? postRepository;

  GetLatestNewsUseCase({this.postRepository});

  Future<Either<Failure, List<PostModel>>> call(BuildContext context,String category) async {
    print("Sdf");
    return await postRepository!.getLatestNews(context,category);
  }

}
