// ignore_for_file: overridden_fields

import '../../domain/entities/post_category_entity.dart';

class PostCategoryModel extends PostCategoryEntity {
  dynamic id;
  final String? categoryName;
  bool choosed = false;

  final int? categoryNumber;

  PostCategoryModel({this.id, this.categoryName, this.categoryNumber})
      : super(
            id: id, categoryName: categoryName, categoryNumber: categoryNumber);

  factory PostCategoryModel.fromJson(Map<String, dynamic> json) {
    return PostCategoryModel(
      id: json['_id'],
      categoryName: json['categoryName'],
      categoryNumber: json['categoryNumber'],
    );
  }
}
