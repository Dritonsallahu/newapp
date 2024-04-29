import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/domain/repositories/auth_repository.dart';
import 'package:news_app/features/domain/repositories/post_repository.dart';

class DeleteAccountUseCase {
  final AuthRepository? authRepository;

  DeleteAccountUseCase({this.authRepository});

  Future<Either<Failure, bool>> call(context) async =>
      await authRepository!.deleteAccount(context);
}
