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
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0,-0.812+0.15),
      child: Container(
        width: screenWidth,
        height: screenHeight/2.0*1.12,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/entrance_top.png'),
            fit: BoxFit.fill,
          )
        ),
        // height: double.infinity,
        // width: double.infinity,
        // decoration: BoxDecoration(
        //   image:
        // ),
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
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0,0.895+0.15),
      child: Container(
        width: screenWidth,
        height: screenHeight/2*1.12,
        decoration: BoxDecoration(
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

