import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:wifi_iot/wifi_iot.dart';

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
    // 请求授权，location是定位权限。
    var permission = await Permission.location.request().isGranted;
    String? wifiSsid = await WiFiForIoTPlugin.getSSID();
    if(permission){
      if(wifiSsid!=null){
        if(wifiSsid.contains("wlan")){
          return true;
        }
      }
    }


    return false;
  }

  Future<void> checkNet() async{
    if(_instance._status != ConnectivityResult.none){
      if(await isInCampus()){
        SmartDialog.showToast(
          "当前为校园网环境，访问速度较慢",
          time: const Duration(milliseconds: 1700),
        );
      }
    } else{
      SmartDialog.showToast("无网络连接，请检查网络");
    }
  }
}