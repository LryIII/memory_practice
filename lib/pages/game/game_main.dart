import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memory_practice/pages/game/game_small_image.dart';
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
  late List<int> nowThreeImages;
  late List stateList;
  late int finishTime;
  late int finishTimeMillisecond;
  late bool isWin;
  final Size screenSize= window.physicalSize/window.devicePixelRatio;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  //late Timer _timer;
    // onChange: (value) {
    //   final displayTime = StopWatchTimer.getDisplayTime(value);
    //   print('displayTime $displayTime');
    // },
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
    isWin=true;
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    stateList=[0,0,0];
    for(int i=0;i<10;i++){
      questions.add('assets/images/resource/question_'+i.toString()+'.png');
    }
    answersRight.add(Random().nextInt(10));
    getAllSmallImage();
    nowThreeImages=[0,0,0];
  }
  void newQuestion(){

    if(gameStatus==0){
      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    }
    if(gameStatus!=2){
      // Start
      stateList=[0,0,0];
      nowQuestion++;
      if(nowQuestion==21){
        gameOver();
        return;
      }
      if(nowQuestion>=2){
        if(answersRight[nowQuestion-2]!=answersUser[nowQuestion-2]){
          isWin=false;
        }
      }
      answersRight.add(Random().nextInt(10));
      getThreeImages();
      //print(isWin);
      //print(answersRight);
      //print(answersUser);
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
        nowThreeImages[n]=temp;
        _list[temp]=false;
        n++;
      }
    }
    if(_list[answersRight[nowQuestion-1]]){
      nowThreeImages[Random().nextInt(3)]=answersRight[nowQuestion-1];
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
          const SizedBox(height: 50,),
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
            children: showSmallImages(nowThreeImages),
          ),
          const SizedBox(height:30,),
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
  List<Widget> showSmallImages(List _list){
    //0未选中,1对,2错
    return [
      SmallImage(
        onTap: ()async {
          answersUser.add(_list[0]);
          if(nowQuestion>=1){
            if(answersRight[nowQuestion-1]==answersUser[nowQuestion-1]){
              stateList[0]=1;
            }else{
              stateList[0]=2;
            }
          }
          setState(() {});
          Future.delayed(
            const Duration(milliseconds: 250), (){
              newQuestion();
            },
          );
        },
        imageUrl: questions[_list[0]],
        state:stateList[0],//1,
      ),
      const SizedBox(width: 10,),
      SmallImage(
        onTap: (){
          answersUser.add(_list[1]);
          if(nowQuestion>=1){
            if(answersRight[nowQuestion-1]==answersUser[nowQuestion-1]){
              //isWin=false;
              stateList[1]=1;
            }else{
              stateList[1]=2;
            }
            setState(() {});
            Future.delayed(
              const Duration(milliseconds: 250), (){
                newQuestion();
              },
            );
          }
        },
        imageUrl: questions[_list[1]],
        state: stateList[1],
      ),
      // smallImages[0],
      const SizedBox(width: 10,),
      SmallImage(
        onTap: (){
          answersUser.add(_list[2]);
          if(nowQuestion>=1){
            if(answersRight[nowQuestion-1]==answersUser[nowQuestion-1]){
              //isWin=false;
              stateList[2]=1;
            }else {
              stateList[2] = 2;
            }
            setState(() {});
            Future.delayed(
              const Duration(milliseconds: 250), (){
                newQuestion();
              },
            );
          }
        },
        imageUrl: questions[_list[2]],
        state: stateList[2],
      ),
      // smallImages[0],
    ];
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
        return EndWinDialog(
          second: finishTime%60,
          minute: finishTime~/60,
          millisecond: finishTimeMillisecond%1000,
        );
      },
    );
  }
  void gameFail(){
    showDialog(
      barrierDismissible: false,//为false时点击背景dialog不会消失
      context: context,
      builder: (context){
        return const EndFailDialog();
        // return EndWinDialog(
        //   second: finishTime%60,
        //   minute: finishTime~/60,
        //   millisecond: finishTimeMillisecond%1000,
        // );
      },
    );
  }
  void gameOver(){
    finishTime=_stopWatchTimer.secondTime.value;
    finishTimeMillisecond=_stopWatchTimer.rawTime.value;
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: getGameStatusWidget(),
          ),
        ),
      ),
    );
  }
}

