import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/domain/repositories/post_repository.dart';

class GetWorldNewsUseCase {
  final PostRepository? postRepository;

  GetWorldNewsUseCase({this.postRepository});

  Future<Either<Failure, List<PostModel>>> call(BuildContext context,String category) async =>
      await postRepository!.getWorldNews(context,category);
}
