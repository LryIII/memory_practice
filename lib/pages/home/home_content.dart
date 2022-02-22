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
                  Navigator.of(context).pushNamed('/login');
                },
              ),
            ),
            Align(
              alignment: const Alignment(0,-0.56),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "点此登录",
                    style: TextStyle(
                      fontSize: 20.0
                    ),
                  ),
                  Icon(
                    Icons.arrow_upward
                  )
                ],
              ),
            ),
            AlignImageButton(
              alignment: const Alignment(0,-0.35),
              imageUrl: 'assets/images/game.png',
              onTap: (){
                Navigator.of(context).pushNamed('/game_main',arguments: {
                  'isFirst':true,
                });
              },
            ),
            AlignImageButton(
              alignment: const Alignment(0,-0.10),
              imageUrl: 'assets/images/user_grow.png',
              onTap: (){
                Navigator.of(context).pushNamed('/grow');
              },
            ),
            AlignImageButton(
              alignment: const Alignment(0,0.15),
              imageUrl: 'assets/images/rank.png',
              onTap:(){
                Navigator.of(context).pushNamed('/rank');
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
