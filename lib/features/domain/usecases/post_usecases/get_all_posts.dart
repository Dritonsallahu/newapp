import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/domain/repositories/post_repository.dart';

class GetAllPostsUseCase {
  final PostRepository? postRepository;

  GetAllPostsUseCase({this.postRepository});

  Future<Either<Failure, List<PostModel>>> call(context) async =>
      await postRepository!.getAllPosts(context);
}
