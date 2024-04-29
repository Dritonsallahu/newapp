import 'package:equatable/equatable.dart';
import 'package:news_app/features/domain/entities/post_category_entity.dart';

class PostEntity extends Equatable{
  dynamic id;
  PostCategoryEntity? category;
  String? title;
  String? subtitle;
  String? content;
  bool? breakingNews;
  List<String>? tags = [];
  String? image;
  List<String>? files = [];
  bool? active;
  String? createdAt;
  String? updatedAt;


  PostEntity(
      {this.id,
      this.category,
      this.title,
      this.subtitle,
      this.content,
      this.breakingNews,
      this.tags,
      this.image,
      this.files,
      this.active,
      this.createdAt,
      this.updatedAt
      });


  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    category,
    title,
    subtitle,
    content,
    breakingNews,
    tags,
    image,
    files,
    active,
    createdAt,
    updatedAt
  ];

}