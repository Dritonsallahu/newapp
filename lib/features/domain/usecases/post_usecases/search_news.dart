import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/domain/repositories/post_repository.dart';

class SearchNewsUseCase {
  final PostRepository? postRepository;

  SearchNewsUseCase({this.postRepository});

  Future<Either<Failure, List<PostModel>>> call(context, String post) async =>
      await postRepository!.searchNews(context,post);
}
