import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._();
  factory ConnectivityService()=> _instance;
  ConnectivityService._();

  final Connectivity connectivity = Connectivity();
  final StreamController<ConnectivityStatus> connectionStatusController=StreamController<ConnectivityStatus>.broadcast();

Stream get stream => connectionStatusController.stream;

  Future<void> initialize() async{
    connectivity.onConnectivityChanged.listen((ConnectivityResult result){
      var connectionStatus = _getStatusFromResult(result);
      connectionStatusController.add(connectionStatus);

      if(connectionStatus==ConnectivityStatus.offline)
        Fluttertoast.showToast(msg: 'No Internet');
    });
  }

  Future<bool> isConnectedToInternet() async{
      try {
        final result = await InternetAddress.lookup('www.google.com');
        log(result[0].rawAddress.toString());
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }else{
          return false;
        }
      } on SocketException catch(_) {
        return false;
      }

  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result){
    switch(result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.wifi;
      case ConnectivityResult.none:
          return ConnectivityStatus.offline;
      default:
        return ConnectivityStatus.offline;
    }

  }
}

enum ConnectivityStatus{
  cellular,
  wifi,
  offline
}