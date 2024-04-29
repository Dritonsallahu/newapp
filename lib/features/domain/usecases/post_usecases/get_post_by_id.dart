import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/domain/entities/post_entity.dart';
import 'package:news_app/features/domain/repositories/post_repository.dart';

class GetPostByIdUseCase {
  final PostRepository? postRepository;

  GetPostByIdUseCase({this.postRepository});

  Future<Either<Failure, PostModel>> call(BuildContext context,String id) async =>
      await postRepository!.getPostById(context,id);
}
