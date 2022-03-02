import 'dart:math';
import 'dart:ui';

import 'package:memory_practice/components/store.dart';
import 'package:memory_practice/pages/rank/rank_network.dart';

import '../pages/grow/grow_network.dart';

class GlobalUnit {
  late String userName;
  final double screenWidth=window.physicalSize.width/window.devicePixelRatio;
  final double screenHeight=window.physicalSize.height/window.devicePixelRatio;
  final double unitWidth=window.physicalSize.width/window.devicePixelRatio/392.72727;
  final double unitHeight=window.physicalSize.height/window.devicePixelRatio/872.72727;
  GlobalUnit({this.userName='unNamed'});
}
class GlobalData{
  late String userName;
  late String passWord;
  late List recordList;
  late bool isLogin;
  late double bestTime;
  late int rankMy=0;
  GlobalData({
    this.userName="%",
    this.passWord="%",
    this.isLogin=false,
    this.recordList=const [],
    this.bestTime=0xfffffff,
    this.rankMy=0,
  });
  void changeLogin(bool value) =>isLogin=value;
  Future<String> getBestTime() async{
    if(isLogin){
      recordList=await GrowNetwork().getData(globalData.userName);
      if(recordList.isNotEmpty){
        for(int i=0;i<recordList.length;i++){
          bestTime=min(bestTime, recordList[i]['time'].toDouble());
        }
        return bestTime.toString();
      }else{
        return "暂无";
      }
    }
    return " ";
  }
  Future<String> getMyRank() async{
    if(isLogin){
      rankMy=await RankMyItem().getOneRank(globalData.userName);
      return rankMy==0 ? "暂无" : rankMy.toString();
    }
    return '';
  }
  void update() async{
    if(isLogin){
      recordList=await GrowNetwork().getData(globalData.userName);
      getBestTime();
    }
  }
  void uploadBest() async{
    if(isLogin){
      update();
      if(await RankMyItem().isInRank(userName)){
        await RankMyItem().changeRank(userName, bestTime);
      }else{
        await RankMyItem().addItem(userName, bestTime);
      }
    }
  }

  void logout() async{
    userName="%";
    passWord="%";
    isLogin=false;
    recordList=const [];
    bestTime=0xfffffff;
    rankMy=0;
    await SharedPreferenceUnit.saveData<bool>('isLogin', false);
    await SharedPreferenceUnit.saveData('%userName','%');
    await SharedPreferenceUnit.saveData('%passWord', '%');
  }
}
GlobalData globalData=GlobalData();