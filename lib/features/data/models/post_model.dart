import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:news_app/features/data/models/post_category_model.dart';
import 'package:news_app/features/domain/entities/post_category_entity.dart';
import 'package:news_app/features/domain/entities/post_entity.dart';

class PostModel {
  dynamic id;
  dynamic author;
  PostCategoryEntity? category;
  String? title;
  String? subtitle;
  String? continent;
  String? country;
  String? content;
  int? commentsNumber;
  int? likesNumber;
  bool? breakingNews;
  List<dynamic>? tags = [];
  String? image;
  List<dynamic>? files = [];
  bool? active;
  String? createdAt;
  String? updatedAt;

  PostModel(
      {this.id,
      this.author,
      this.category,
      this.title,
      this.subtitle,
      this.continent,
      this.country,
      this.content,
      this.commentsNumber,
      this.likesNumber,
      this.breakingNews,
      this.tags,
      this.image,
      this.files,
      this.active,
      this.createdAt,
      this.updatedAt});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['_id'],
      author: json['author'],
      category: PostCategoryModel.fromJson(json['postCategory']),
      title: json['postTitle'],
      subtitle: json['postSubtitle'],
      continent: json['continent'],
      country: json['country'],
      content: json['body'],
      commentsNumber: json['commentsNumber'],
      likesNumber: json['likesNumber'],
      breakingNews: json['breakingNews'],
      tags: json['tags'],
      image: json['image'],
      files: json['files'],
      active: json['active'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
