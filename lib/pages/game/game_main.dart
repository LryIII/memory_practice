
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../components/dialog.dart';

class GameMain extends StatefulWidget {
  const GameMain({Key? key}) : super(key: key);

  @override
  _GameMainState createState() => _GameMainState();
}

class _GameMainState extends State<GameMain> {

  late int nowIndex;
  late int nowQuestion;
  late List<String> questions;
  late List answersUser;
  late List answersRight;
  late List<Widget> smallImages;
  late int gameStatus;
  late List<Widget> bottomWidgets;
  late List<Widget> nowThreeImages;
  late int finishTime;
  final Size screenSize= window.physicalSize/window.devicePixelRatio;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
    // onChange: (value) {
    //   final displayTime = StopWatchTimer.getDisplayTime(value);
    //   print('displayTime $displayTime');
    // },
    //onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    //onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  void gameStart(){
    nowIndex=0;
    nowQuestion=0;
    questions=[];
    answersUser=[];
    answersRight=[];
    smallImages=[];
    gameStatus=0;
    bottomWidgets=[];
    nowThreeImages=[];
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);

    for(int i=0;i<10;i++){
      questions.add('assets/images/resource/question_'+i.toString()+'.jpg');
    }
    answersRight.add(Random().nextInt(10));
    getAllSmallImage();
    nowThreeImages=[
      smallImages[0],
      const SizedBox(width: 10,),
      smallImages[0],
      const SizedBox(width: 10,),
      smallImages[0],
    ];
  }
  void newQuestion(){
    //_stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    if(gameStatus==0){
      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    }
    if(gameStatus!=2){
      // Start

      nowQuestion++;
      if(nowQuestion==21){
        gameOver();
        return;
      }
      answersRight.add(Random().nextInt(10));
      getThreeImages();
      print(answersRight);
      print(answersUser);
      setState(() {
      });
    }
  }
  void getThreeImages(){
    List _list=List<bool>.filled(10, true);
    int n=0;
    while(n<3){
      int temp=Random().nextInt(10);
      if(_list[temp]){
        nowThreeImages[2*n]=smallImages[temp];
        _list[temp]=false;
        n++;
      }
    }
    if(_list[answersRight[nowQuestion-1]]){
      nowThreeImages[Random().nextInt(3)*2]=smallImages[answersRight[nowQuestion-1]];
    }
  }
  List<Widget> getGameStatusWidget(){
    switch(gameStatus){
      case 0 :
        return [
          const SizedBox(
            height: 30,
            width: double.infinity,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "第0题",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30,),
          Container(
            height: 300.0*618.0/772.0,
            width: 300,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(questions[answersRight[0]]),
                )
            ),
          ),
          SizedBox(height: screenSize.height-550.0,),
          Container(
            height: 45,
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: ElevatedButton(
              onPressed: (){
                newQuestion();
                setState(() {
                  gameStatus=1;
                });
              },
              child: const Text(
                "我记住了",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 23.0,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(180.0),
                  ),
                ),
              ),
            ),
          ),
        ];
      case 1:
        return [
          const SizedBox(
            height: 30,
            width: double.infinity,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "第$nowQuestion题",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30,),
          Container(
            height: 300.0*618.0/772.0,
            width: 300,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(questions[answersRight[nowQuestion]]),
                )
            ),
          ),
          const SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "请在下方 选中上一题 出现的图",
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: nowThreeImages,
          ),
          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.access_time,color: Colors.blueAccent,),
              // Text(
              //   "time",
              //   style: TextStyle(
              //     color: Colors.blueAccent,
              //   ),
              // ),
              StreamBuilder<int>(
                stream: _stopWatchTimer.secondTime,
                initialData: 0,
                builder: (context, snap) {
                  final value = snap.data;
                  if(value!=null){
                    String minute=(value~/60)<10 ?
                    '0'+(value~/60).toString() : (value~/60).toString();
                    //String minute=(value~/60)<10 ? '0' : ''+(value~/60).toString();
                    String second=(value%60)<10 ?
                    '0'+(value%60).toString() : (value%60).toString();
                    return Text(
                      minute+":"+second,
                      style: const TextStyle(
                        color: Colors.blueAccent,
                      ),
                    );
                  }
                  return const Text("time");
                },

              ),
            ],
          ),
          const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: (){
                    setState(() {
                      gameStart();
                    });
                  },
                  icon: const Icon(Icons.refresh_outlined),
                  label: const Text(
                    "重来",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(180.0),
                        )
                    ),
                  ),
                ),
              )
            ],
          ),
        ];
      default:
        return [Container()];
    }
  }

  Widget getSmallImage(int index){
    return GestureDetector(
      onTap: (){
        answersUser.add(index);
        newQuestion();
      },
      child: Container(
        height: 110.0*618.0/772.0,
        width: 110,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(questions[index]),
            fit: BoxFit.cover,
          )
        ),
      ),
    );
  }
  void getAllSmallImage(){
    for(int i=0;i<10;i++){
      smallImages.add(getSmallImage(i));
    }
  }

  bool gameJudge(){
    for(int i=0;i<19;i++){
      if(answersUser[i]!=answersRight[i]){
        return false;
      }
    }
    return true;
  }
  void gameWin(){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return const EndWinDialog();
      },
    );
  }
  void gameFail(){
    showDialog(
      barrierDismissible: false,//为false时点击背景dialog不会消失
      context: context,
      builder: (context){
        return const EndWinDialog();
      },
    );
  }
  void gameOver(){
    finishTime=_stopWatchTimer.secondTime.value;
    print(finishTime);
    gameStatus=2;
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    if(gameJudge()){
      gameWin();
    }else{
      gameFail();
    }
  }

  @override
  void initState() {
    gameStart();
    super.initState();
  }
  @override
  void dispose() {
    _stopWatchTimer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20.0,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        elevation: 0.8,
        backgroundColor: const Color.fromARGB(0xff, 246, 246, 246),
        title: const Text(
          "专注力测试",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(0xff, 246, 246, 246)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: getGameStatusWidget(),
        ),
      ),
    );
  }
}
