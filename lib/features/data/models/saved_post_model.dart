
import 'package:news_app/features/data/models/post_model.dart';

class SavedPostModel {
  dynamic id;
  dynamic author;
  PostModel? post;
  String? createdAt;
  String? updatedAt;

  SavedPostModel(
      {this.id,
        this.author,
        this.post,
        this.createdAt,
        this.updatedAt});

  factory SavedPostModel.fromJson(Map<String, dynamic> json) {
    return SavedPostModel(
      id: json['_id'],
      author: json['author'],
      post: json['post'].toString().contains("title") ? PostModel.fromJson(json['post']):null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
