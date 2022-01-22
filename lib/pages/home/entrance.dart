import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
class EntrancePage extends StatefulWidget {
  const EntrancePage({Key? key}) : super(key: key);

  @override
  State<EntrancePage> createState() => _EntrancePageState();
}

class _EntrancePageState extends State<EntrancePage> {
  final screenSize= window.physicalSize/window.devicePixelRatio;
  late Timer _timer;
  //double nowPercent=0.0;

  @override
  void initState() {
    _timer=Timer(const Duration(milliseconds: 1000), (){
      Navigator.popAndPushNamed(context, '/game_main');
    });
    // nowPercent=0.0;
    // _timer=Timer.periodic(const Duration(milliseconds: 20),(timer){
    //   nowPercent=_timer.tick.toDouble()/50.0;
    //   if(_timer.tick==50){
    //     //timerCancel();
    //     _timer.cancel();
    //     Navigator.popAndPushNamed(context, '/game_main');
    //   }
    // });
    super.initState();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/entrance_background.png'),
              fit: BoxFit.cover,
            )
          ),
          child: Stack(
            children: [
              const Align(
                alignment: Alignment(0, 0.66),
                child: SizedBox(
                  height: 88*0.6,
                  width: 367*0.6,
                  child: Image(
                    image: AssetImage('assets/images/transparent_0.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 300,
                child: CircularPercentIndicator(
                  animation: true,
                  animationDuration: 1000,//动画总时长
                  radius: 50.0, //整个圆形的大小
                  lineWidth: 6.0,//指示线条大小
                  percent: 1,///当animation为false时为当前进度///当animation为true时为最终进度
                  center: TextButton(
                    child: const Text(
                      "跳过",
                      style: TextStyle(
                        color: Colors.deepOrange,
                      ),
                    ),
                    onPressed: (){
                      _timer.cancel();
                      Navigator.popAndPushNamed(context, '/game_main');
                    },
                  ),//中心widget 可以是文字 或其他widget 如何icon
                  circularStrokeCap: CircularStrokeCap.round,
                  linearGradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(39, 153, 93, 0.01),
                      Color.fromRGBO(39, 153, 93, 1)
                    ],
                  ),//渐变色
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
