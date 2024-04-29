

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo{ Future<bool> get isConnected; }

class NetworkInfoImpl extends NetworkInfo{
  final InternetConnectionChecker? connectionChecker;

  NetworkInfoImpl({@required this.connectionChecker});

  @override
  Future<bool> get isConnected => connectionChecker!.hasConnection;

}

class NetworkInfoImpl2 extends NetworkInfo{
  final InternetConnectionChecker? connectionChecker;

  NetworkInfoImpl2({@required this.connectionChecker});

  @override
  Future<bool> get isConnected => connectionChecker!.hasConnection;

}
