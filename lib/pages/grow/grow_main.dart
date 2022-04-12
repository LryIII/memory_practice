import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:memory_practice/components/entrance_to_login.dart';
import 'package:memory_practice/pages/grow/grow_line_chart.dart';
import 'package:memory_practice/pages/grow/grow_network.dart';
import 'package:memory_practice/pages/grow/grow_state_box.dart';
import 'package:memory_practice/pages/rank/rank_network.dart';

import '../../components/global.dart';

class GrowContent extends StatefulWidget {
  const GrowContent({Key? key}) : super(key: key);

  @override
  _GrowContentState createState() => _GrowContentState();
}

class _GrowContentState extends State<GrowContent> {
  final unitH=GlobalUnit().unitHeight;
  final unitW=GlobalUnit().unitWidth;
  int allNum=0;
  String bestString='';
  String rankString='';
  String nickString='';

  Future<String> getNick() async{
    int rank=await RankMyItem().getOneRank(globalData.userName);
    if(rank<=5){
      return '超凡入圣';
    }else if(rank<=10){
      return '一代宗师';
    }
    else if(rank<=20){
      return '一派掌门';
    }
    else if(rank<=30){
      return '武林盟主';
    }else if(rank<=40){
      return '江湖豪侠';
    }
    return '初入江湖';
  }

  void initSelf() async{
    bestString=await globalData.getBestTime();
    rankString=await globalData.getMyRank();
    nickString=await getNick();
    allNum=await GrowNetwork().getNum(globalData.userName);
    setState(() {

    });
  }
  
  @override
  void initState() {
    if(globalData.isLogin){
      initSelf();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/user_grow_background.png'),
          fit: BoxFit.cover,
        )),
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0, 0),
              child: SizedBox(
                height: 690.1*unitH,
                width: 317 * 1.05*unitW,
                child: const Image(
                  image: AssetImage(
                      'assets/images/user_grow_background_transparent.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0,0),
              child: SizedBox(
                height: 690.1*unitH,
                width: 317 * 1.05*unitW,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30*unitH,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "自我提升",
                            style: TextStyle(
                              fontSize: 33.3,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30*unitH,),
                      growSelf(),
                      SizedBox(height: 15.0*unitH,),
                      Container(
                        height: 446.6*unitH,
                        width: 307.0*unitW,
                        decoration: BoxDecoration(
                          color: const Color(0x933F51B5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: getLineChart(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getLineChart() {
    if(globalData.isLogin){
      return const RealGrowLineChart();
    }else{
      return unknownChart();
    }
  }
  growSelf() {
    return GestureDetector(
      onTap: (){
        if(globalData.isLogin){

        }else{
          SmartDialog.show(
            // here
            backDismiss: false,
            clickBgDismissTemp: false,
            isLoadingTemp: false,
            widget: EntranceToLogin(
              onPressed: (){
                SmartDialog.dismiss();
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/login').then((value) => setState((){}));
              },
            ),
          );
        }
      },
      child: Container(
        height: 100.0*unitH,
        width: 307.0*unitW,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            Container(
              height: 30*unitH,
              width: 307.0*unitW,
              decoration: const BoxDecoration(
                color: Color.fromARGB(0xff, 208, 230, 253),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child:Padding(
                padding: EdgeInsets.only(
                  left: 8.0*unitW,
                  top: 3.0*unitH,
                ),
                child: const Text(
                  '20连对最佳记录',
                  style: TextStyle(
                    color: Color.fromARGB(0xff, 70, 109, 212),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: 70.0*unitH,
              width: 307.2*unitW,
              decoration: const BoxDecoration(
                color: Color.fromARGB(0xff, 255, 255, 255),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Row(
                children: [
                  GrowStateBox(
                    title: globalData.isLogin ? bestString : "不",
                    subtitle: "最佳记录",
                  ),
                  GrowStateBox(
                    title: globalData.isLogin ? rankString : "知",
                    subtitle: "排行榜上",
                  ),
                  GrowStateBox(
                    title: globalData.isLogin ? nickString : "道",
                    subtitle: "等级状态",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getBest() async{
    try{
      double best=0xfffffff;
      List data=await GrowNetwork().getData(globalData.userName);
      if(data.isNotEmpty){
        for(int i=0;i<data.length;i++){
          best=min(best, data[i]['time'].toDouble());
        }
        return best.toInt().toString()+"秒"+((best-best.toInt())*1000).toInt().toString();
      }
      return '';
    }catch(e){
      return '';
    }
  }
  Future<String> getRank() async{
    try{
      int data=await RankMyItem().getOneRank(globalData.userName);
      if(data!=-1){
        return data.toString();
      }
      return "暂无";
    }catch(e){
      print(e);
      return '';
    }
  }
  unknownChart() {
    return EntranceToLogin(
      onPressed: (){
        Navigator.of(context).pop();
        Navigator.pushNamed(context, '/login').then((value) => setState((){}));
      },
    );
  }
}
