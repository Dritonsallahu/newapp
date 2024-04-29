import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/domain/repositories/post_repository.dart';

class GetNewsByContinentUseCase {
  final PostRepository? postRepository;

  GetNewsByContinentUseCase({this.postRepository});

  Future<Either<Failure, List<PostModel>>> call(context,String continent,String category) async =>
      await postRepository!.getNewsByContinent(context,continent,category);
}
