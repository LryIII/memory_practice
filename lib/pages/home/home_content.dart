import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memory_practice/pages/home/my_align_button.dart';

class HomeContent extends StatelessWidget {
  HomeContent({Key? key}) : super(key: key);

  final screenSize= window.physicalSize/window.devicePixelRatio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home_background.png'),
            fit: BoxFit.cover,
          )
        ),
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0, -0.67),
              child: GestureDetector(
                child: const SizedBox(
                  width: 177*0.93,
                  height: 47*0.93,
                    child: Image(
                      image: AssetImage('assets/images/leave.png'),
                      fit: BoxFit.fill,
                    ),
                ),
                onTap: (){
                },
              ),
            ),
            AlignImageButton(
              alignment: const Alignment(0,-0.35),
              imageUrl: 'assets/images/game.png',
              onTap: (){
                Navigator.of(context).pushNamed('/entrance');
              },
            ),
            AlignImageButton(
              alignment: const Alignment(0,-0.10),
              imageUrl: 'assets/images/user_grow.png',
              onTap: (){

              },
            ),
            AlignImageButton(
              alignment: const Alignment(0,0.15),
              imageUrl: 'assets/images/rank.png',
              onTap:(){
                Navigator.of(context).pushNamed('/entrance');
              },
            ),
            AlignImageButton(
              alignment: const Alignment(0,0.4),
              onTap:(){

              },
              imageUrl: 'assets/images/about_us.png',
            ),
            AlignImageButton(
              alignment: const Alignment(0,0.65),
              onTap:(){

              },
              imageUrl: 'assets/images/card_pic.png',
            ),
          ],
        ),
      ),
    );
  }
}
