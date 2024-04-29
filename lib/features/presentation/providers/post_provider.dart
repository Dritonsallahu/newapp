import 'package:flutter/material.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/strings/failures.dart';
import 'package:news_app/features/data/models/post_category_model.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:news_app/features/data/models/saved_post_model.dart';
import 'package:news_app/features/domain/usecases/post_usecases/comment_news.dart';
import 'package:news_app/features/domain/usecases/post_usecases/delete_account.dart';
import 'package:news_app/features/domain/usecases/post_usecases/get_all_posts.dart';
import 'package:news_app/features/domain/usecases/post_usecases/get_breaking_news.dart';
import 'package:news_app/features/domain/usecases/post_usecases/get_latest_news.dart';
import 'package:news_app/features/domain/usecases/post_usecases/get_news_by_category.dart';

import 'package:news_app/features/domain/usecases/post_usecases/get_news_by_continent.dart';
import 'package:news_app/features/domain/usecases/post_usecases/get_news_categories.dart';
import 'package:news_app/features/domain/usecases/post_usecases/get_popular_posts.dart';
import 'package:news_app/features/domain/usecases/post_usecases/get_post_by_id.dart';
import 'package:news_app/features/domain/usecases/post_usecases/get_post_comments.dart';
import 'package:news_app/features/domain/usecases/post_usecases/get_saved_posts.dart';

import 'package:news_app/features/domain/usecases/post_usecases/get_world_news.dart';
import 'package:news_app/features/domain/usecases/post_usecases/like_news.dart';
import 'package:news_app/features/domain/usecases/post_usecases/save_new_post.dart';
import 'package:news_app/features/domain/usecases/post_usecases/search_news.dart';
import 'package:news_app/features/presentation/widgets/error_widgets.dart';
import 'package:news_app/features/presentation/widgets/general_widgets.dart';
import 'package:provider/provider.dart';

enum NewsCategory { auto, specific }

class PostProvider extends ChangeNotifier {
  NewsCategory newsCategory = NewsCategory.auto;
  bool failedFetching = false;

  List<PostModel> _posts = [];
  List<PostModel> _breakingNewsPosts = [];
  List<PostModel> _popularNewsPosts = [];
  List<PostCategoryModel> _newsCategories = [];
  List<SavedPostModel> _savedPosts = [];
  List<SavedPostModel> _savedPostsFilter = [];
  List<PostModel> _searchedNewsList = [];

  List<PostModel> _latestNews = [];
  bool _latestNewsFirstFetch = false;

  List<PostModel> _worldNews = [];
  bool _worldNewsFirstFetch = false;

  List<PostModel> _usaNews = [];
  bool _usaNewsFirstFetch = false;

  List<PostModel> _europeNews = [];
  bool _europeNewsFirstFetch = false;

  List<PostModel> _middleEastNews = [];
  bool _middleEastNewsFirstFetch = false;

  List<PostModel> _asiaNews = [];
  bool _asiaNewsFirstFetch = false;

  GetAllPostsUseCase? getAllPostsUseCase;
  GetPostByIdUseCase? getPostByIdUseCase;
  GetBreakingNewsUseCase? getBreakingNewsUseCase;
  GetNewsCategoriesUseCase? getNewsCategoriesUseCase;
  GetNewsByCategoryUseCase? getNewsByCategoryUseCase;
  GetSavedPostsUseCase? getSavedPostsUseCase;
  SaveNewPostUseCase? saveNewPostUseCase;
  GetLatestNewsUseCase? getLatestNewsUseCase;
  GetWorldNewsUseCase? getWorldNewsUseCase;
  GetNewsByContinentUseCase? getNewsByContinentUseCase;
  GetPopularPostsUseCase? getPopularPostsUseCase;
  LikeNewsUseCase? likeNewsUseCase;
  CommentPostUseCase? commentPostUseCase;
  GetNewsCommentsUseCase? getNewsCommentsUseCase;
  SearchNewsUseCase? searchNewsUseCase;

  PostProvider(
      {this.getAllPostsUseCase,
      this.getPostByIdUseCase,
      this.getBreakingNewsUseCase,
      this.getPopularPostsUseCase,
      this.getNewsCategoriesUseCase,
      this.getNewsByCategoryUseCase,
      this.getSavedPostsUseCase,
      this.saveNewPostUseCase,
      this.getLatestNewsUseCase,
      this.getNewsByContinentUseCase,
      this.getWorldNewsUseCase,
      this.likeNewsUseCase,
      this.commentPostUseCase,
      this.searchNewsUseCase,
      this.getNewsCommentsUseCase,
      });

  List<PostModel> getPosts() => _posts;
  List<PostModel> getSearchedNewsList() => _searchedNewsList;
  List<PostModel> getBreakingNewsPosts() => _breakingNewsPosts;
  List<PostModel> getPopularNews() => _popularNewsPosts;
  List<PostCategoryModel> getNewsCategories(String place) {
    List<PostCategoryModel> c = [];
    for (var element in _newsCategories) {
      if (element.categoryName == "Ukraine") {
      } else {
        c.add(element);
      }
    }
    return c;
  }

  List<SavedPostModel> getSavedPosts() => _savedPosts;
  List<PostModel> getLatestNews() => _latestNews;
  List<PostModel> getWorldNews() => _worldNews;

  List<PostModel>? getNewsByContinent(String contient) {
    if (contient == "USA") {
      return _usaNews;
    } else if (contient == "Europe") {
      return _europeNews;
    } else if (contient == "Middle East") {
      return _middleEastNews;
    } else if (contient == "Asia") {
      return _asiaNews;
    }
  }

  getPostsFromDB(BuildContext context) async {
    var data = await getAllPostsUseCase!.call(context);
    data.fold((failure) {
      if(!failedFetching){
        showBottomModalError(context, mapFailureMessage(failure));
        failedFetching = true;
      }

    }, (posts) {
      _posts = posts;

      notifyListeners();
    });
  }

   getPostByIdFromDB(BuildContext context, String id) async {
    var data = await getPostByIdUseCase!.call(context, id);
    return data.fold((failure) {
      if(!failedFetching){
        showBottomModalError(context, mapFailureMessage(failure));
        failedFetching = true;
      }
    }, (post) {

      return post;
    });
  }

  getBreakingNewsPostsFromDB(BuildContext context) async {
    var data = await getBreakingNewsUseCase!.call(context);
    data.fold((failure) {
      if(!failedFetching){
        showBottomModalError(context, mapFailureMessage(failure));
        failedFetching = true;
      }
    }, (posts) {
      _breakingNewsPosts = posts;
      notifyListeners();
    });
  }

  getPopularNewsPostsFromDB(BuildContext context) async {
    var data = await getPopularPostsUseCase!.call(context);
    data.fold((failure) {
      if(!failedFetching){
        showBottomModalError(context, mapFailureMessage(failure));
        failedFetching = true;
      }
    }, (posts) {
      _popularNewsPosts = posts;
      notifyListeners();
    });
  }

  getNewsCategoriesFromDB(BuildContext context) async {
    var data = await getNewsCategoriesUseCase!.call(context);
    data.fold((failure) {
      if(!failedFetching){
        showBottomModalError(context, mapFailureMessage(failure));
        failedFetching = true;
      }
    }, (posts) {
      _newsCategories = posts;

      notifyListeners();
    });
  }

  getNewsByCategoryFromDB(BuildContext context, String category) async {
    var data = await getNewsByCategoryUseCase!.call(context, category);
    data.fold((failure) {
      if(!failedFetching){
        showBottomModalError(context, mapFailureMessage(failure));
        failedFetching = true;
      }
    }, (posts) {
      _posts = posts;
      notifyListeners();
    });
  }

  getSavedNewsFromDB(BuildContext context) async {
    var data = await getSavedPostsUseCase!.call(context);
    data.fold((failure) {
      if(!failedFetching){
        showBottomModalError(context, mapFailureMessage(failure));
        failedFetching = true;
      }
    }, (posts) {


      _savedPosts = posts;
      _savedPostsFilter = posts;
      notifyListeners();
    });
  }

  saveNewPostToDB(BuildContext context, String post) async {
    var postProvider = Provider.of<PostProvider>(context,listen: false);
    var data = await saveNewPostUseCase!.call(context, post);
    return data.fold((failure) {
      if(!failedFetching){
        showBottomModalError(context, mapFailureMessage(failure));
        failedFetching = true;
      }
    }, (result) {
       postProvider.getSavedPosts().forEach((element) {

       });
      return result;

    });
  }

  getLatestNewsFromDB(BuildContext context, String category) async {
    var data = await getLatestNewsUseCase!.call(context, category);
    data.fold((failure) {
      if(!failedFetching){
        showBottomModalError(context, mapFailureMessage(failure));
        failedFetching = true;
      }
    }, (posts) {
      _latestNews = posts;

      notifyListeners();
    });
  }

  getWorldNewsFromDB(BuildContext context, String category) async {
    var data = await getWorldNewsUseCase!.call(context, category);
    data.fold((failure) {
      if(!failedFetching){
        showBottomModalError(context, mapFailureMessage(failure));
        failedFetching = true;
      }
    }, (posts) {
      _worldNews = posts;
      notifyListeners();
    });
  }

  likePostFromDB(BuildContext context, String post) async {
    var data = await likeNewsUseCase!.call(context, post);
    return data.fold((failure) {
      if(!failedFetching){
        showBottomModalError(context, mapFailureMessage(failure));
        failedFetching = true;
      }
    }, (like) {
        infoModal("You liked this post!", context);
      return like;
    });
  }

  commentPostFromDB(BuildContext context,String username,String comment, String post) async {
    var data = await commentPostUseCase!.call(context,username, comment, post);
    return data.fold((failure) {
      if(!failedFetching){
        showBottomModalError(context, mapFailureMessage(failure));
        failedFetching = true;
      }
    }, (comments) {
      return comments;
    });
  }

  getNewsCommentsPostFromDB(BuildContext context, String postId) async {
    var data = await getNewsCommentsUseCase!.call(context, postId);
    return data.fold((failure) {
      if(!failedFetching){
        showBottomModalError(context, mapFailureMessage(failure));
        failedFetching = true;
      }
    }, (comments) {
      return comments;
    });
  }

  searchNewsFromDB(BuildContext context, String title) async {
    var data = await searchNewsUseCase!.call(context, title);
    return data.fold((failure) {
      if(!failedFetching){
        showBottomModalError(context, mapFailureMessage(failure));
        failedFetching = true;
      }
    }, (posts) {
      _searchedNewsList = posts;
      notifyListeners();
    });
  }



  returnFailedStatus(){
  failedFetching = false;
  notifyListeners();
  }

  getNewByContinentFromDB(
      BuildContext context, String continent, String category) async {
    var data =
        await getNewsByContinentUseCase!.call(context, continent, category);
    data.fold((failure) {
      if(!failedFetching){
        showBottomModalError(context, mapFailureMessage(failure));
        failedFetching = true;
      }
    }, (posts) {
      if (continent == "USA") {
        _usaNews = [];
      } else if (continent == "Europe") {
        _europeNews = [];
      } else if (continent == "Middle East") {
        _middleEastNews = [];
      } else if (continent == "Asia") {
        _asiaNews = [];
      }

      for (var element in posts) {
        if (element.continent == "USA") {
          _usaNews.add(element);
        } else if (element.continent == "Europe") {
          _europeNews.add(element);
        } else if (element.continent == "Middle East") {
          _middleEastNews.add(element);
        } else if (element.continent == "Asia") {
          _asiaNews.add(element);
        }
      }
      notifyListeners();
    });
  }

  getLatestNewsFechingStatus() => _latestNewsFirstFetch;
  setLatestNewsFechingStatus(bool status) {
    _latestNewsFirstFetch = status;
    notifyListeners();
  }

  getWorldNewsFechingStatus() => _worldNewsFirstFetch;
  setWorldNewsFechingStatus(bool status) {
    _worldNewsFirstFetch = status;
    notifyListeners();
  }

  getUsaNewsFechingStatus() => _usaNewsFirstFetch;
  setUsaNewsFechingStatus(bool status) {
    _usaNewsFirstFetch = status;
    notifyListeners();
  }

  getEuropeNewsFechingStatus() => _europeNewsFirstFetch;
  setEuropeNewsFechingStatus(bool status) {
    _europeNewsFirstFetch = status;
    notifyListeners();
  }

  getMiddleEastNewsFechingStatus() => _middleEastNewsFirstFetch;
  setMiddleEastNewsFechingStatus(bool status) {
    _middleEastNewsFirstFetch = status;
    notifyListeners();
  }

  getAsiaFechingStatus() => _asiaNewsFirstFetch;
  setAsiaNewsFechingStatus(bool status) {
    _asiaNewsFirstFetch = status;
    notifyListeners();
  }

  mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case WrongData:
        return "Wrong data";
      default:
        return "Unexpected Error\nPlease try again later";
    }
  }

  getCategoryType() => newsCategory;

  changeCategoryType(NewsCategory newsCategory) {
    newsCategory = newsCategory;
    notifyListeners();
  }

  noCategoryChoosed() {
    for (int i = 0; i < _newsCategories.length; i++) {
      if (_newsCategories[i].choosed) {
        return true;
      }
    }
    return false;
  }

  bool isChoosedCategory(categoryId) {
    for (int i = 0; i < _newsCategories.length; i++) {
      if (_newsCategories[i].id == categoryId && _newsCategories[i].choosed) {
        return true;
      }
    }
    return false;
  }

  chooseCategory(categoryId) {
    for (int i = 0; i < _newsCategories.length; i++) {
      if (_newsCategories[i].id == categoryId) {
        _newsCategories[i].choosed = true;
      } else {
        _newsCategories[i].choosed = false;
      }
    }
    notifyListeners();
  }

  isPostSaved(PostModel postModel){

    for (var element in _savedPosts) {
      print("${element.post!.id} ${postModel.id}");
      if(element.post!.id == postModel.id){
        return true;
      }
    }
    return false;
  }

  filterSavedPost(String title){
    _savedPosts = [];
    for (var element in _savedPostsFilter) {
      if(element.post!.title!.contains(title)){
        _savedPosts.add(element);
      }
    }
    notifyListeners();
  }
}
