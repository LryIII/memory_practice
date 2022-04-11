import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class NetStatusListener{
  static final NetStatusListener _instance = NetStatusListener._();

  NetStatusListener._();

  factory NetStatusListener() => _instance;

  static Future<void> init() async {
    Connectivity _connectivity=Connectivity();
    _instance._status = await _connectivity.checkConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      _instance._status = result;
    });
  }

  ConnectivityResult _status = ConnectivityResult.none;

  bool hasNetWork() => _instance._status != ConnectivityResult.none;

  Future<bool> isInCampus() async{
    Dio dio=Dio();
    var response=await dio.get(
      'https://sso.tju.edu.cn/cas/login',
    );
    if(response.statusCode==200){
      return true;
    }
    return false;
  }

  Future<void> checkNet() async{
    if(_instance._status != ConnectivityResult.none){
      if(await isInCampus()){
        SmartDialog.showToast("当前为校园网环境，访问速度较慢");
      }
    } else{
      SmartDialog.showToast("无网络连接，请检查网络");
    }
  }
}