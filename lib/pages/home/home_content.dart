import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memory_practice/components/global.dart';
import 'package:memory_practice/pages/home/my_align_button.dart';

import '../../components/store.dart';
import '../grow/grow_network.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  initAll() async{
    try{
      var isLogin=await SharedPreferenceUnit.getData<bool>("isLogin");
      if(isLogin==true){
        globalData.changeLogin(true);
        globalData.userName=await SharedPreferenceUnit.getData<String>('%userName');
        globalData.passWord=await SharedPreferenceUnit.getData<String>('%passWord');
        globalData.recordList=await GrowNetwork().getData(globalData.userName);
        globalData.getBestTime();
        globalData.getMyRank();
        setState(() {

        });
      }
    }catch(e){
      print(e);
      rethrow;
    }
  }
  @override
  void deactivate() {
    bool? _bool=ModalRoute.of(context)?.isCurrent;
    if(_bool as bool){
      setState(() {

      });
    }
    super.deactivate();
  }
  @override
  void initState() {
    initAll();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  final screenSize= window.physicalSize/window.devicePixelRatio;

  List<Widget> stateRow(){
    setState(() {

    });
    if(globalData.isLogin){
      return [
        Text(
          "hello   "+globalData.userName,
          style: const TextStyle(
              fontSize: 20.0
          ),
        ),
      ];
    }
    return [
      const Text(
        "点此登录",
        style: TextStyle(
            fontSize: 20.0
        ),
      ),
      const Icon(
          Icons.arrow_upward
      )
    ];
  }

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
                  Navigator.of(context).pushNamed('/login').then((value) {
                    setState(() {

                    });
                  });
                },
              ),
            ),
            Align(
              alignment: const Alignment(0,-0.56),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: stateRow(),
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
                Navigator.of(context).pushNamed('/about');
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
