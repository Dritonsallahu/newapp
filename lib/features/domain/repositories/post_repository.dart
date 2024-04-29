import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/data/models/comment_model.dart';
import 'package:news_app/features/data/models/like_model.dart';
import 'package:news_app/features/data/models/post_category_model.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/data/models/saved_post_model.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostModel>>> getAllPosts(BuildContext context);

  Future<Either<Failure, List<PostModel>>> getPopularPosts(BuildContext context);

  Future<Either<Failure, List<PostModel>>> getBreakingNews(BuildContext context);

  Future<Either<Failure, PostModel>> getPostById(BuildContext context,String id);

  Future<Either<Failure, List<PostModel>>> getNewsByCategory(BuildContext context,String category);

  Future<Either<Failure, List<PostCategoryModel>>> getNewsCategories(BuildContext context);

  Future<Either<Failure, List<SavedPostModel>>> getSavedPosts(BuildContext context);

  Future<Either<Failure, SavedPostModel>> saveNewPost(BuildContext context,String post);

  Future<Either<Failure, List<PostModel>>> getNewsByContinent(BuildContext context,String continent,String category);

  Future<Either<Failure, List<PostModel>>> getLatestNews(BuildContext context,String category);

  Future<Either<Failure, List<PostModel>>> getWorldNews(BuildContext context,String category);

  Future<Either<Failure, LikeModel>> likeNews(BuildContext context,String post);

  Future<Either<Failure, CommentModel>> commentNews(BuildContext context,String username,String comment, String post);

  Future<Either<Failure, List<CommentModel>>> getNewsComments(BuildContext context, String postId);

  Future<Either<Failure, List<PostModel>>> searchNews(BuildContext context,String title);

}
