import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/data/models/saved_post_model.dart';
import 'package:news_app/features/domain/repositories/post_repository.dart';

class SaveNewPostUseCase {
  final PostRepository? postRepository;

  SaveNewPostUseCase({this.postRepository});

  Future<Either<Failure, SavedPostModel>> call(context, String post) async =>
      await postRepository!.saveNewPost(context,post);
}
