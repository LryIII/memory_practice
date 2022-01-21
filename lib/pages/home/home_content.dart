import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memory_practice/pages/home/my_row.dart';

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
            Align(
              alignment: const Alignment(0,-0.9),
              child: MyBarRow(),
            ),
            Align(
              alignment: const Alignment(-0.14, -0.215),
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
            Align(
              alignment: const Alignment(0.48,0.735),
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
