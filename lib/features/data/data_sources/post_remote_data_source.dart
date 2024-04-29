// ignore_for_file: constant_identifier_names, depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/core/consts/api.dart';
import 'package:news_app/core/error/exception.dart';
import 'package:news_app/features/data/models/comment_model.dart';
import 'package:news_app/features/data/models/like_model.dart';
import 'package:news_app/features/data/models/post_category_model.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/data/models/saved_post_model.dart';
import 'package:news_app/features/domain/entities/post_entity.dart';
import 'package:news_app/features/presentation/providers/request_network_provider.dart';
import 'package:news_app/features/presentation/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts(BuildContext context);
  Future<List<PostModel>> getPopularPosts(BuildContext context);
  Future<List<PostModel>> getBreakingNews(BuildContext context);
  Future<PostModel> getPostById(BuildContext context, String id);
  Future<List<PostModel>> getNewsByCategory(
      BuildContext context, String category);
  Future<List<PostCategoryModel>> getNewsCategories(BuildContext context);
  Future<List<SavedPostModel>> getSavedPosts(BuildContext context);
  Future<SavedPostModel> saveNewPost(BuildContext context, String post);
  Future<List<PostModel>> getLatestNews(BuildContext context, String category);
  Future<List<PostModel>> getNewsByContinent(
      BuildContext context, String continent, String category);
  Future<List<PostModel>> getWorldNews(BuildContext context, String category);
  Future<LikeModel> likeNews(BuildContext context, String post);
  Future<CommentModel> commentNews(
      BuildContext context, String username, String comment, String post);
  Future<List<CommentModel>> getNewsComments(
      BuildContext context, String postId);
  Future<List<PostModel>> searchNews(BuildContext context, String title);

}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  http.Client? client;

  PostRemoteDataSourceImpl({required this.client});

  SharedPreferences? sharedPreferences;
  var headers = {'Content-Type': 'application/json'};
  @override
  Future<List<PostModel>> getAllPosts(context) async {

   try{
     var userProvider = Provider.of<UserProvider>(context, listen: false);
     sharedPreferences = await SharedPreferences.getInstance();
     var id = sharedPreferences!.getString("uniqueID");
     headers['uniqueID'] = id!;
     if (userProvider.getUser() != null) {
       headers['userID'] = userProvider.getUser()!.id;
     }
     // Add user id if exists, if not add unique ID, for later...
     final response =
     await client!.get(Uri.parse(readerPostsUrl), headers: headers);
     print(response.body);
     var decodedJson = json.decode(response.body)['posts'];
     if (decodedJson is List) {
       List<PostModel> postModels =
       decodedJson.map((postJson) => PostModel.fromJson(postJson)).toList();

       return postModels;
     } else {
       throw Exception('Invalid JSON format'); // Handle invalid JSON format
     }
   }catch(e){
     print(e);
     return [];
   }
  }

  @override
  Future<PostModel> getPostById(BuildContext context, String id) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      sharedPreferences = await SharedPreferences.getInstance();
      var uniqueID = sharedPreferences!.getString("uniqueID");
      headers['uniqueID'] = uniqueID!;
      if (userProvider.getUser() != null) {
        headers['userID'] = userProvider.getUser()!.id;
      }
      // Add user id if exists, if not add unique ID, for later...
      final response = await client!
          .get(Uri.parse("$readerPostByIdUrl/$id"), headers: headers);

      var decodedJson = json.decode(response.body)['post'];
      print(decodedJson['commentsNumber']);
      print(decodedJson['likesNumber']);
      PostModel postModel = PostModel.fromJson(decodedJson);
      return postModel;
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getBreakingNews(context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences!.getString("uniqueID");
    headers['uniqueID'] = id!;
    if (userProvider.getUser() != null) {
      headers['userID'] = userProvider.getUser()!.id;
    }
    final response =
        await client!.get(Uri.parse(readerBreakingNewsUrl), headers: headers);

    var decodedJson = json.decode(response.body)['posts'];

    if (decodedJson is List) {
      List<PostModel> postModels =
          decodedJson.map((postJson) => PostModel.fromJson(postJson)).toList();

      return postModels;
    } else {
      throw Exception('Invalid JSON format'); // Handle invalid JSON format
    }
  }

  @override
  Future<List<PostModel>> getPopularPosts(BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences!.getString("uniqueID");
    headers['uniqueID'] = id!;
    if (userProvider.getUser() != null) {
      headers['userID'] = userProvider.getUser()!.id;
    }
    final response =
        await client!.get(Uri.parse(readerPopularNews), headers: headers);

    var decodedJson = json.decode(response.body)['posts'];

    if (decodedJson is List) {
      List<PostModel> postModels =
          decodedJson.map((postJson) => PostModel.fromJson(postJson)).toList();

      return postModels;
    } else {
      throw Exception('Invalid JSON format'); // Handle invalid JSON format
    }
  }

  @override
  Future<List<PostModel>> getNewsByCategory(context, String category) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences!.getString("uniqueID");
    headers['uniqueID'] = id!;
    if (userProvider.getUser() != null) {
      headers['userID'] = userProvider.getUser()!.id;
    }
    final response = await client!
        .get(Uri.parse("$readerNewsByCategory/$category"), headers: headers);
    var decodedJson = json.decode(response.body)['posts'];
    if (decodedJson is List) {
      List<PostModel> postModels =
          decodedJson.map((postJson) => PostModel.fromJson(postJson)).toList();

      return postModels;
    } else {
      throw Exception('Invalid JSON format'); // Handle invalid JSON format
    }
  }

  @override
  Future<List<PostCategoryModel>> getNewsCategories(context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences!.getString("uniqueID");
    headers['uniqueID'] = id!;
    if (userProvider.getUser() != null) {
      headers['userID'] = userProvider.getUser()!.id;
    }
    final response =
        await client!.get(Uri.parse(readerNewsCategories), headers: headers);
    var decodedJson = json.decode(response.body)['posts'];

    if (decodedJson is List) {
      List<PostCategoryModel> postModels = decodedJson
          .map((postJson) => PostCategoryModel.fromJson(postJson))
          .toList();

      return postModels;
    } else {
      throw Exception('Invalid JSON format'); // Handle invalid JSON format
    }
  }

  @override
  Future<List<SavedPostModel>> getSavedPosts(context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences!.getString("uniqueID");
    headers['uniqueID'] = id!;
    if (userProvider.getUser() != null) {
      headers['userID'] = userProvider.getUser()!.id;
    }
    final response =
        await client!.get(Uri.parse(readerSavedNews), headers: headers);
    var decodedJson = json.decode(response.body)['posts'];
    print(decodedJson);
    if (decodedJson is List) {
      List<SavedPostModel> postModels = decodedJson
          .map((postJson) => SavedPostModel.fromJson(postJson))
          .toList();

      return postModels;
    } else {
      throw Exception('Invalid JSON format'); // Handle invalid JSON format
    }
  }

  @override
  Future<SavedPostModel> saveNewPost(BuildContext context, String post) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences!.getString("uniqueID");
    headers['uniqueID'] = id!;
    if (userProvider.getUser() != null) {
      headers['userID'] = userProvider.getUser()!.id;
    }
    var url = Uri.parse(readerSaveNews);
    final response = await client!
        .post(url, body: jsonEncode({'postID': post}), headers: headers);

    var decodedJson = json.decode(response.body)['result'];

    return SavedPostModel.fromJson(decodedJson);
  }

  @override
  Future<List<PostModel>> getLatestNews(
      BuildContext context, String category) async {
    try {
      var url = Uri.parse(
          "$readerLatestNews${category.isNotEmpty ? "/$category" : ""}");
      final response = await client!.get(url, headers: headers);
      var decodedJson = json.decode(response.body)['posts'];
      if (decodedJson is List) {
        List<PostModel> postModels = decodedJson
            .map((postJson) => PostModel.fromJson(postJson))
            .toList();

        return postModels;
      } else {
        throw Exception('Invalid JSON format'); // Handle invalid JSON format
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<PostModel>> getNewsByContinent(
      BuildContext context, String continent, String category) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences!.getString("uniqueID");
    headers['uniqueID'] = id!;
    if (userProvider.getUser() != null) {
      headers['userID'] = userProvider.getUser()!.id;
    }

    var url = Uri.parse(
        "$readerNewsByContinent${continent.isNotEmpty ? "/$continent" : ""}${category.isNotEmpty ? "/$category" : ""}");
    final response = await client!.get(url, headers: headers);

    var decodedJson = json.decode(response.body)['posts'];
    if (decodedJson is List) {
      List<PostModel> postModels =
          decodedJson.map((postJson) => PostModel.fromJson(postJson)).toList();

      return postModels;
    } else {
      throw Exception('Invalid JSON format'); // Handle invalid JSON format
    }
  }

  @override
  Future<List<PostModel>> getWorldNews(context, String category) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences!.getString("uniqueID");
    headers['uniqueID'] = id!;
    if (userProvider.getUser() != null) {
      headers['userID'] = userProvider.getUser()!.id;
    }
    var url =
        Uri.parse("$readerWorldNews${category.isNotEmpty ? "/$category" : ""}");
    final response = await client!.get(url, headers: headers);
    var decodedJson = json.decode(response.body)['posts'];
    if (decodedJson is List) {
      List<PostModel> postModels =
          decodedJson.map((postJson) => PostModel.fromJson(postJson)).toList();

      return postModels;
    } else {
      throw Exception('Invalid JSON format'); // Handle invalid JSON format
    }
  }

  @override
  Future<CommentModel> commentNews(BuildContext context, String username,
      String comment, String post) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences!.getString("uniqueID");
    headers['uniqueID'] = id!;
    if (userProvider.getUser() != null) {
      headers['userID'] = userProvider.getUser()!.id;
    }
    var url = Uri.parse("$readerCommentNewsUrl/$post");

    final response = await client!.post(url,
        body: jsonEncode({
          "username": username,
          "comment": comment,
          "post": post,
        }),
        headers: headers);
    var decodedJson = json.decode(response.body)['posts'];

    CommentModel commentModel = CommentModel.fromJson(decodedJson);

    return commentModel;
  }

  @override
  Future<LikeModel> likeNews(BuildContext context, String post) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences!.getString("uniqueID");
    headers['uniqueID'] = id!;
    if (userProvider.getUser() != null) {
      headers['userID'] = userProvider.getUser()!.id;
    }
    var url = Uri.parse(readerLikeNewsUrl);
    final response = await client!
        .post(url, body: jsonEncode({"post": post}), headers: headers);

    var decodedJson = json.decode(response.body)['posts'];

    LikeModel postModels = LikeModel.fromJson(decodedJson);

    return postModels;
  }

  @override
  Future<List<PostModel>> searchNews(BuildContext context, String title) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences!.getString("uniqueID");
    headers['uniqueID'] = id!;
    if (userProvider.getUser() != null) {
      headers['userID'] = userProvider.getUser()!.id;
    }
    var url = Uri.parse("$readerSearchNewsUrl?title=$title");
    final response = await client!.get(url, headers: headers);

    var decodedJson = json.decode(response.body)['posts'];
    if (decodedJson is List) {
      List<PostModel> postModels =
          decodedJson.map((postJson) => PostModel.fromJson(postJson)).toList();

      return postModels;
    } else {
      throw Exception('Invalid JSON format'); // Handle invalid JSON format
    }
  }

  @override
  Future<List<CommentModel>> getNewsComments(
      BuildContext context, String postId) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences!.getString("uniqueID");
    headers['uniqueID'] = id!;
    if (userProvider.getUser() != null) {
      headers['userID'] = userProvider.getUser()!.id;
    }
    var url = Uri.parse("$readerCommentsNewsUrl/$postId");
    final response = await client!.get(url, headers: headers);
    print(response.body);
    var decodedJson = json.decode(response.body)['posts'];
    if (decodedJson is List) {
      List<CommentModel> postModels = decodedJson
          .map((postJson) => CommentModel.fromJson(postJson))
          .toList();

      return postModels;
    } else {
      throw Exception('Invalid JSON format'); // Handle invalid JSON format
    }
  }


}
