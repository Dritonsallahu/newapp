import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/data/models/comment_model.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/domain/repositories/post_repository.dart';

class GetNewsCommentsUseCase {
  final PostRepository? postRepository;

  GetNewsCommentsUseCase({this.postRepository});

  Future<Either<Failure, List<CommentModel>>> call(context, postId) async =>
      await postRepository!.getNewsComments(context, postId);
}
