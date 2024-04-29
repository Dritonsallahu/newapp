import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:news_app/features/data/models/post_category_model.dart';
import 'package:news_app/features/domain/entities/post_category_entity.dart';
import 'package:news_app/features/domain/entities/post_entity.dart';

class LikeModel {
  dynamic id;
  dynamic user;
  String? post;
  String? createdAt;
  String? updatedAt;

  LikeModel(
      {this.id,
        this.user,
        this.post,
        this.createdAt,
        this.updatedAt});

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      id: json['_id'],
      user: json['user'],
      post: json['post'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    user, 
    post,
    createdAt,
    updatedAt
  ];
}
