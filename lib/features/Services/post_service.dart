import 'package:dartz/dartz.dart';
import 'package:news_app/core/consts/api.dart';
import 'package:news_app/core/error/exception.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/data/models/post_model.dart';
import 'package:http/http.dart' as http;
class PostService {
  Future<Either<Failure, PostModel>?> getPosts() async {}

  Future<Either<Failure, List<PostModel>>?> getBreakingNews() async {
      var response = await http.get(Uri.parse(readerBreakingNewsUrl));
      if(response.statusCode == 200){
        const Right([]);
      }
      else{
        Left(ServerException());
      }
  }

  Future<Either<Failure, PostModel>?> getRecommandedNews() async {}
}
