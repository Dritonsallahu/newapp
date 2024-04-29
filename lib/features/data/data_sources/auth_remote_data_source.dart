import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/core/consts/api.dart';
import 'package:news_app/features/data/models/user_model.dart';
import 'package:news_app/features/presentation/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> authenticate(String username, password);
  Future<bool> setUniqueID(String uniqueID);
  Future<bool> deleteAccount(BuildContext context);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  var headers = {'Content-Type': 'application/json'};
  http.Client? client;
  SharedPreferences? sharedPreferences;
  AuthRemoteDataSourceImpl({required this.client});
  @override
  Future<UserModel> authenticate(String username, password) async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final allInfo = deviceInfo.data;
    var uniqueID = allInfo['identifierForVendor'];
    SharedPreferences? preferences = await SharedPreferences.getInstance();
    var map = {
      "username": username,
      "password": password,
      "uniqueID": uniqueID
    };
    final response = await client!.post(Uri.parse(loginUrl),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(map));

    var decodedData = json.decode(response.body)['user'];

    UserModel userModel = UserModel.fromJson(decodedData);
    preferences.setString("user", jsonEncode(userModel.toJSON()));
    return userModel;
  }

  @override
  Future<bool> setUniqueID(String? uniqueID) async {
    var uuid = Uuid();
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final allInfo = deviceInfo.data;
    var un = Platform.isAndroid ? uuid.v4(): allInfo['identifierForVendor'];

    var map = {
      "uniqueID": uniqueID ?? un,
    };
    final response = await client!.post(Uri.parse(uniqueDataUrl),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(map));

    var decodedData = json.decode(response.body);
    if(decodedData['message'] == "success" || decodedData['message'] == "exist"){
      return true;
    }
    return false;
  }
  @override
  Future<bool> deleteAccount(BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences!.getString("uniqueID");
    headers['uniqueID'] = id!;
    if (userProvider.getUser() != null) {
      headers['userID'] = userProvider.getUser()!.id;
    }
    var url = Uri.parse(deleteReaderAccount);
    final response = await client!.post(url,
        body: jsonEncode({"user": userProvider.getUser()!.id}),
        headers: headers);
    print(response.body);
    var decodedJson = json.decode(response.body);
    return decodedJson;

  }
}
