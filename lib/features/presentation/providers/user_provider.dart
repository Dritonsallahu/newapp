import 'package:flutter/material.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/core/strings/failures.dart';
import 'package:news_app/features/data/models/user_model.dart';
import 'package:news_app/features/domain/usecases/auth_usecases/auth_usecase.dart';
import 'package:news_app/features/domain/usecases/auth_usecases/set_unique_ID_usecase.dart';
import 'package:news_app/features/domain/usecases/post_usecases/delete_account.dart';
import 'package:news_app/features/presentation/screens/credentials/login_screen.dart';
import 'package:news_app/features/presentation/widgets/error_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _userModel;
  bool loggingOut = false;

  AuthenticateUseCase? authenticateUseCase;
  SetUniqueIDUsecase? setUniqueIDUsecase;
  DeleteAccountUseCase? deleteAccountUseCase;

  UserProvider({
    this.authenticateUseCase,
    this.setUniqueIDUsecase,
    this.deleteAccountUseCase,
  });

  UserModel? getUser() => _userModel;

  authenticateFromDB(
      BuildContext context, String username, String password) async {
    var data = await authenticateUseCase!.authenticate(username, password);
    data.fold((failure) {}, (result) {
      _userModel = result;
      notifyListeners();
      Navigator.pop(context);
    });
  }

  setUniqueIDFromDB(SharedPreferences preferences, String? uniqueID) async {
    var data = await setUniqueIDUsecase!.setUniqueID(uniqueID!);
    data.fold((failure) {
      print(failure);
    }, (result) {
      print("sdfsssss");
      preferences.setString("uniqueID", uniqueID);
    });
  }

  Future<void> addNewUser(UserModel model) async {
    _userModel = model;
    notifyListeners();
  }

  deleteAccount(BuildContext context) async {
    loggingOut = true;
    var data = await deleteAccountUseCase!.call(context);
    return data.fold((failure)async {
      showBottomModalError(context, "We could't not delete your account!");
      loggingOut = false;

    }, (status) async{
      await removeUser();
      loggingOut = false;
      Navigator.pop(context);
      showBottomModalError(context, "Your account was successfully removed!");

      return status;
    });
  }

  removeUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("user");
    _userModel = null;
    notifyListeners();
  }

  mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case WrongData:
        return "Wrong data";
      default:
        return "Unexpected Error\nPlease try again later";
    }
  }
}
