import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/domain/repositories/auth_repository.dart';

class SetUniqueIDUsecase {
  final AuthRepository? authRepository;

  SetUniqueIDUsecase({this.authRepository});

  Future<Either<Failure, bool>> setUniqueID(
      String uniqueID) async =>
      await authRepository!.setUniqueID(uniqueID);
}
