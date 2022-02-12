import 'dart:ui';

class GlobalUnit {
  late String userName;
  final double unitWidth=window.physicalSize.width/window.devicePixelRatio/392.72727;
  final double unitHeight=window.physicalSize.height/window.devicePixelRatio/872.72727;
  GlobalUnit({this.userName='unNamed'});
}