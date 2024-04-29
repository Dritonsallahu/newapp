// ignore_for_file: use_build_context_synchronously

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/data/data_sources/post_remote_data_source.dart';
import 'package:news_app/features/data/models/comment_model.dart';
import 'package:news_app/features/data/models/like_model.dart';
import 'package:news_app/features/data/models/post_category_model.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/data/models/saved_post_model.dart';
import 'package:news_app/features/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource? postRemoteDataSource;
  final NetworkInfo? networkInfo;

  PostRepositoryImpl({this.postRemoteDataSource, this.networkInfo});
  @override
  Future<Either<Failure, List<PostModel>>> getAllPosts(
      BuildContext context) async {
    if (await networkInfo!.isConnected) {
      try {
        final remotePosts = await postRemoteDataSource!.getAllPosts(context);

        return Right(remotePosts);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      // Local storage here...
      // or server failure
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PostModel>> getPostById(
      BuildContext context, String id) async {
    if (await networkInfo!.isConnected) {
      try {
        final remotePost = await postRemoteDataSource!.getPostById(context, id);
        return Right(remotePost);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      // Local storage here...
      // or server failure
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getPopularPosts(BuildContext context) async {
    if (await networkInfo!.isConnected) {
      try {
        final remotePopularPosts = await postRemoteDataSource!.getPopularPosts(context);
        return Right(remotePopularPosts);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      // Local storage here...
      // or server failure
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getBreakingNews(
      BuildContext context) async {
    if (await networkInfo!.isConnected) {
      try {
        final remotePosts =
            await postRemoteDataSource!.getBreakingNews(context);
        return Right(remotePosts);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      // Local storage here...
      // or server failure
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getNewsByCategory(
      BuildContext context, String category) async {
    final remotePosts =
        await postRemoteDataSource!.getNewsByCategory(context, category);
    return Right(remotePosts);
  }

  @override
  Future<Either<Failure, List<PostCategoryModel>>> getNewsCategories(
      BuildContext context) async {
    if (await networkInfo!.isConnected) {
      try {
        final remotePosts =
            await postRemoteDataSource!.getNewsCategories(context);
        return Right(remotePosts);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      // Local storage here...
      // or server failure
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<SavedPostModel>>> getSavedPosts(
      BuildContext context) async {

        final remotePosts = await postRemoteDataSource!.getSavedPosts(context);
        return Right(remotePosts);

  }

  @override
  Future<Either<Failure, SavedPostModel>> saveNewPost(BuildContext context, String post) async {

        final remotePosts =
        await postRemoteDataSource!.saveNewPost(context, post);
        return Right(remotePosts);

  }

  @override
  Future<Either<Failure, List<PostModel>>> getLatestNews(
      BuildContext context, String category) async {
    if (await networkInfo!.isConnected) {
      try {
        final remotePosts =
            await postRemoteDataSource!.getLatestNews(context, category);
        return Right(remotePosts);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      // Local storage here...
      // or server failure
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getNewsByContinent(
      BuildContext context, String continent, String category) async {
    if (await networkInfo!.isConnected) {
      try {
        final remotePosts = await postRemoteDataSource!
            .getNewsByContinent(context, continent, category);
        return Right(remotePosts);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      // Local storage here...
      // or server failure
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getWorldNews(
      BuildContext context, String category) async {
    if (await networkInfo!.isConnected) {
      try {
        final remotePosts =
            await postRemoteDataSource!.getWorldNews(context, category);
        return Right(remotePosts);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      // Local storage here...
      // or server failure
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, LikeModel>> likeNews(BuildContext context, String post) async {
    if (await networkInfo!.isConnected) {
      try {
        final remotePosts =
            await postRemoteDataSource!.likeNews(context, post);
        return Right(remotePosts);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      // Local storage here...
      // or server failure
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CommentModel>> commentNews(BuildContext context, String username, String comment, String post) async {
    if (await networkInfo!.isConnected) {
      try {
        final remotePosts =
            await postRemoteDataSource!.commentNews(context, username, comment, post);
        return Right(remotePosts);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      // Local storage here...
      // or server failure
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<CommentModel>>> getNewsComments(BuildContext context, String postId) async {
    if (await networkInfo!.isConnected) {
      try {
        final remotePosts =
            await postRemoteDataSource!.getNewsComments(context,postId);
        return Right(remotePosts);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      // Local storage here...
      // or server failure
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> searchNews(BuildContext context, String title) async {
    if (await networkInfo!.isConnected) {
      try {
        final remotePosts =
            await postRemoteDataSource!.searchNews(context, title);
        return Right(remotePosts);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      // Local storage here...
      // or server failure
      return Left(ServerFailure());
    }
  }




}
