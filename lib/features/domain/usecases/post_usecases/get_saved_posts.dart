import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/data/models/saved_post_model.dart';
import 'package:news_app/features/domain/entities/post_entity.dart';
import 'package:news_app/features/domain/repositories/post_repository.dart';

class GetSavedPostsUseCase {
  final PostRepository? postRepository;

  GetSavedPostsUseCase({this.postRepository});

  Future<Either<Failure, List<SavedPostModel>>> call(context) async =>
      await postRepository!.getSavedPosts(context);
}
