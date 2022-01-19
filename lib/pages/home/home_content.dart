import 'dart:ui';

import 'package:flutter/material.dart';

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
            image: AssetImage('assets/images/home.jpg'),
            fit: BoxFit.cover,
          )
        ),
        child: Stack(
          children: [
            Positioned(
              top: 36.0*screenSize.width/386.0,
              left: 32.0*screenSize.height/686.0,
              child: GestureDetector(
                child: SizedBox(
                  height: 40.0*screenSize.width/386.0,
                  width: 40.0*screenSize.width/386.0,
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/twt_round.png'),
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
                onTap: (){

                },
              ),
            ),
            Positioned(
              top: 32.0*screenSize.width/386.0,
              left: 78.0*screenSize.height/686.0,
              child: TextButton(
                child: const Text(
                  "用户名",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: (){

                },
              ),
            ),
            Positioned(
              top: 32.0*screenSize.width/386.0,
              left: 255.0*screenSize.height/686.0,
              child: TextButton(
                child: const Text(
                  "排行榜",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: (){

                },
              ),
            ),
            Positioned(
              top: 275,
              left: 145,
              child: TextButton(
                child: const Text(
                  "自我\n提升",
                  style: TextStyle(
                    color: Color.fromARGB(0xff, 132, 0, 255),
                    fontSize: 24.0,
                  ),
                ),
                onPressed: (){
                  Navigator.of(context).pushNamed('/entrance');
                },
              ),
            ),
            Positioned(
              top: 590,
              left: 240,
              child: TextButton(
                child: const Text(
                  "走过\n的路",
                  style: TextStyle(
                    color: Color.fromARGB(0xff, 132, 0, 255),
                    fontSize: 30.0,
                  ),
                ),
                onPressed: (){
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
