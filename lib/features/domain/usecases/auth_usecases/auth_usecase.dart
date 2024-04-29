import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/data/models/user_model.dart';
import 'package:news_app/features/domain/repositories/auth_repository.dart';

class AuthenticateUseCase {
  final AuthRepository? authRepository;

  AuthenticateUseCase({this.authRepository});

  Future<Either<Failure, UserModel>> authenticate(
          String username, String password) async =>
      await authRepository!.authenticate(username, password);
}
 