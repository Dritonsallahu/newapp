

import 'package:flutter/cupertino.dart';

enum RequestNetworkType{
  none,
  requesting,
  success,
  failed
}

class RequestNetworkProvider extends ChangeNotifier{
  RequestNetworkType requestNetworkType = RequestNetworkType.none;

  getRequestNetworkType() => requestNetworkType;

  changeRequestType(RequestNetworkType requestNetworkType){
    this.requestNetworkType = requestNetworkType;
    notifyListeners();
  }

}