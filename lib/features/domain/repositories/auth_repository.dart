import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> authenticate(
      String username, String password);

  Future<Either<Failure, bool>> setUniqueID(
      String uniqueID);

  Future<Either<Failure, bool>> deleteAccount(BuildContext context);

}
