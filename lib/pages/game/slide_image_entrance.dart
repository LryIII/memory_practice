import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
class AnimatedSlideImageTop extends StatefulWidget {
  const AnimatedSlideImageTop({Key? key}) : super(key: key);

  @override
  _AnimatedSlideImageTopState createState() => _AnimatedSlideImageTopState();
}

class _AnimatedSlideImageTopState extends State<AnimatedSlideImageTop> {
  final screenHeight=window.physicalSize.height/window.devicePixelRatio;
  final screenWidth=window.physicalSize.width/window.devicePixelRatio;
  late Timer _timer;
  late double nowY;
  @override
  void initState() {
    // TODO: implement initState
    nowY=-0.662;//-0.812+0.15;
    _timer=Timer.periodic(const Duration(milliseconds: 20),
      (timer) {
        if(_timer.tick==60) {
          _timer.cancel();
        }
        if(_timer.tick>=10){
          nowY-=(-0.662+3.780)/50.0;
          setState(() {});
        }
      }
    );
    super.initState();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0,nowY),
      child: Container(
        width: screenWidth,
        height: screenHeight/2.0*1.12,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/entrance_top.png'),
            fit: BoxFit.fill,
          )
        ),
      ),
    );
  }
}
class AnimatedSlideImageBottom extends StatefulWidget {
  const AnimatedSlideImageBottom({Key? key}) : super(key: key);

  @override
  _AnimatedSlideImageBottomState createState() => _AnimatedSlideImageBottomState();
}

class _AnimatedSlideImageBottomState extends State<AnimatedSlideImageBottom> {
  final screenHeight=window.physicalSize.height/window.devicePixelRatio;
  final screenWidth=window.physicalSize.width/window.devicePixelRatio;
  late Timer _timer;
  late double nowY;
  @override
  void initState() {
    // TODO: implement initState
    nowY=1.045;//-0.812+0.15;
    _timer=Timer.periodic(const Duration(milliseconds: 20),
      (timer) {
         if(_timer.tick==50) {
           _timer.cancel();
         }
         if(_timer.tick>=10){
           nowY+=(4.090-1.045)/50.0;
           setState(() {});
         }
      }
    );
    super.initState();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0,nowY),
      child: Container(
        width: screenWidth,
        height: screenHeight/2*1.12,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/entrance_bottom.png'),
            fit: BoxFit.fill,
          ),
          //color: Colors.deepOrange,
        ),
      ),
    );
  }
}

