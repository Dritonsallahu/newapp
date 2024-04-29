import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/data/models/like_model.dart';
import 'package:news_app/features/domain/repositories/post_repository.dart';

class LikeNewsUseCase {
  final PostRepository? postRepository;

  LikeNewsUseCase({this.postRepository});

  Future<Either<Failure, LikeModel>> call(context, post) async =>
      await postRepository!.likeNews(context, post);
}
