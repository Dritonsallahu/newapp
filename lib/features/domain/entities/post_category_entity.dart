import 'package:equatable/equatable.dart';

class PostCategoryEntity extends Equatable {
  dynamic id;
  String? categoryName;
  int? categoryNumber;

  PostCategoryEntity({this.id, this.categoryName, this.categoryNumber});

  @override
  // TODO: implement props
  List<Object?> get props => [id, categoryName, categoryNumber];
}
