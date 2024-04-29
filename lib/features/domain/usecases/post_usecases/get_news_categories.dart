import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/data/models/post_category_model.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/domain/repositories/post_repository.dart';

class GetNewsCategoriesUseCase {
  final PostRepository? postRepository;

  GetNewsCategoriesUseCase({this.postRepository});

  Future<Either<Failure, List<PostCategoryModel>>> call(context) async =>
      await postRepository!.getNewsCategories(context);
}
