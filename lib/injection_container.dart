import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/data/data_sources/auth_remote_data_source.dart';
import 'package:news_app/features/data/data_sources/post_remote_data_source.dart';
import 'package:news_app/features/data/repositories/auth_repository_impl.dart';
import 'package:news_app/features/data/repositories/post_repositori_impl.dart';
import 'package:news_app/features/domain/repositories/auth_repository.dart';
import 'package:news_app/features/domain/repositories/post_repository.dart';
import 'package:news_app/features/domain/usecases/auth_usecases/auth_usecase.dart';
import 'package:news_app/features/domain/usecases/auth_usecases/set_unique_ID_usecase.dart';
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
import 'package:news_app/features/presentation/providers/post_provider.dart';
import 'package:news_app/features/presentation/providers/request_network_provider.dart';
import 'package:news_app/features/presentation/providers/user_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Providers
  sl.registerFactory(
    () => PostProvider(
      getAllPostsUseCase: sl(),
      getBreakingNewsUseCase: sl(),
      getNewsCategoriesUseCase: sl(),
      getNewsByCategoryUseCase: sl(),
      getSavedPostsUseCase: sl(),
      getLatestNewsUseCase: sl(),
      getWorldNewsUseCase: sl(),
      getPostByIdUseCase: sl(),
      getNewsByContinentUseCase: sl(),
      saveNewPostUseCase: sl(),
      likeNewsUseCase: sl(),
      commentPostUseCase: sl(),
      getNewsCommentsUseCase: sl(),
      searchNewsUseCase: sl(),
      getPopularPostsUseCase: sl(),
    ),
  );

  sl.registerFactory(() => UserProvider(
        authenticateUseCase: sl(),
        setUniqueIDUsecase: sl(),
    deleteAccountUseCase: sl()
      ));
  sl.registerFactory(() => RequestNetworkProvider());

  // Post Usecases
  sl.registerLazySingleton(() => GetAllPostsUseCase(postRepository: sl()));
  sl.registerLazySingleton(() => GetPostByIdUseCase(postRepository: sl()));
  sl.registerLazySingleton(() => GetBreakingNewsUseCase(postRepository: sl()));
  sl.registerLazySingleton(() => GetPopularPostsUseCase(postRepository: sl()));
  sl.registerLazySingleton(
      () => GetNewsCategoriesUseCase(postRepository: sl()));
  sl.registerLazySingleton(
      () => GetNewsByCategoryUseCase(postRepository: sl()));
  sl.registerLazySingleton(() => GetSavedPostsUseCase(postRepository: sl()));
  sl.registerLazySingleton(() => SaveNewPostUseCase(postRepository: sl()));
  sl.registerLazySingleton(() => GetLatestNewsUseCase(postRepository: sl()));
  sl.registerLazySingleton(() => GetWorldNewsUseCase(postRepository: sl()));
  sl.registerLazySingleton(
      () => GetNewsByContinentUseCase(postRepository: sl()));
  sl.registerLazySingleton(() => LikeNewsUseCase(postRepository: sl()));
  sl.registerLazySingleton(() => CommentPostUseCase(postRepository: sl()));
  sl.registerLazySingleton(() => GetNewsCommentsUseCase(postRepository: sl()));
  sl.registerLazySingleton(() => SearchNewsUseCase(postRepository: sl()));

  // Auth Usecases
  sl.registerLazySingleton(() => AuthenticateUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => SetUniqueIDUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(authRepository: sl()));

  // Repositories
  sl.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(networkInfo: sl(), postRemoteDataSource: sl()));

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(networkInfo: sl(), authRemoteDataSource: sl()));

  // Data Sources
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
