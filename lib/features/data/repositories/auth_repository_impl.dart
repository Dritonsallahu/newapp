
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/data/data_sources/auth_remote_data_source.dart';
import 'package:news_app/features/data/models/user_model.dart';
import 'package:news_app/features/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource? authRemoteDataSource;
  final NetworkInfo? networkInfo;

  AuthRepositoryImpl({this.networkInfo,this.authRemoteDataSource});
  @override
  Future<Either<Failure, UserModel>> authenticate(String username, String password) async {
    if (await networkInfo!.isConnected) {
      try {
        final user = await authRemoteDataSource!.authenticate(username, password);

        return Right(user);
      } catch (error) {
        return Left(ServerFailure());
      }
    } else {
      // Local storage here...
      // or server failure
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> setUniqueID(String uniqueID) async {
    if (await networkInfo!.isConnected) {
      try {
        final uniqueSet = await authRemoteDataSource!.setUniqueID(uniqueID);

        return Right(uniqueSet);
      } catch (error) {

        return Left(ServerFailure());
      }
    } else {
      // Local storage here...
      // or server failure
      return Left(ServerFailure());
    }
  }
  @override
  Future<Either<Failure, bool>> deleteAccount(BuildContext context) async {

        final remotePosts =
        await authRemoteDataSource!.deleteAccount(context);
        return Right(remotePosts);

  }

}