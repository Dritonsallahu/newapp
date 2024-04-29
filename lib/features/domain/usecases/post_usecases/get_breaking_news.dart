import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/domain/entities/post_entity.dart';
import 'package:news_app/features/domain/repositories/post_repository.dart';

class GetBreakingNewsUseCase {
  final PostRepository? postRepository;

  GetBreakingNewsUseCase({this.postRepository});

  Future<Either<Failure, List<PostModel>>> call(context) async =>
      await postRepository!.getBreakingNews(context);
}
