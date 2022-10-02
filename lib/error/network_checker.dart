import 'dart:io';

import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkInfo{
 final InternetConnectionChecker _internetConnectionChecker;
 NetworkInfo(this._internetConnectionChecker);

 Future<bool> get isConnected async=> await _internetConnectionChecker.hasConnection;
}