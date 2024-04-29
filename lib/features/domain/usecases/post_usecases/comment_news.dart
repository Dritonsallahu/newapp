import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/data/models/comment_model.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/domain/repositories/post_repository.dart';

class CommentPostUseCase {
  final PostRepository? postRepository;

  CommentPostUseCase({this.postRepository});

  Future<Either<Failure, CommentModel>> call(context,username, comment, post) async =>
      await postRepository!.commentNews(context,username,comment, post);
}
