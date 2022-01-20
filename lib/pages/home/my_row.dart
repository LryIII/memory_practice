import 'dart:ui';

import 'package:flutter/material.dart';

class MyBarRow extends StatelessWidget {
  MyBarRow({Key? key}) : super(key: key);

  final screenSize= window.physicalSize/window.devicePixelRatio;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width:20,
          height: 40.0*screenSize.width/386.0,
        ),
        GestureDetector(
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
        SizedBox(
          width:20,
          height: 40.0*screenSize.width/386.0,
        ),
        TextButton(
          child: const Text(
            "用户名",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          onPressed: (){},
        ),
        SizedBox(
          width:120,
          height: 40.0*screenSize.width/386.0,
        ),
        TextButton(
          child: const Text(
            "排行榜",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          onPressed: (){},
        ),
      ],
    );
  }
}
