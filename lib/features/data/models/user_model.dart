import 'package:news_app/features/data/models/post_category_model.dart';
import 'package:news_app/features/domain/entities/post_category_entity.dart';

class UserModel {
  dynamic id;
  String? fullName;
  String? username;
  dynamic role;
  String? email;
  String? city;
  String? country;

  UserModel(
      {this.id,
      this.fullName,
      this.username,
      this.role,
      this.email,
      this.city,
      this.country});

  factory UserModel.fromJson(Map<String, dynamic> json) {

    return UserModel(
      id: json['_id'],
      fullName: json['fullname'],
      username: json['username'],
      role: json['role'],
      email: json['email'],
      city: json['city'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJSON() => {
        "_id": id,
        "fullname": fullName,
        "username": username,
        "role": role,
        "email": email,
        "city": city,
        "country": country,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id, fullName, email, city, country];
}
