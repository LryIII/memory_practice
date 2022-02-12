import 'package:flutter/material.dart';
import 'package:memory_practice/pages/rank/rank_network.dart';
import 'package:memory_practice/pages/rank/rank_time_text.dart';

import '../../components/global.dart';

class RankContent extends StatefulWidget {
  const RankContent({Key? key}) : super(key: key);

  @override
  _RankContentState createState() => _RankContentState();
}

class _RankContentState extends State<RankContent> {
  int itemCount=0,second=0,millisecond=0,minute=0;
  List allRankData=[];
  final unitH=GlobalUnit().unitHeight;
  final unitW=GlobalUnit().unitWidth;
  getData() async{
    itemCount= await RankMyItem().getAllNum();
    Map temp= await RankMyItem().getAllRank(1, itemCount);
    allRankData=temp['result'].toList();
    setState(() {

    });
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/rank_background.png'),
            fit: BoxFit.cover,
          )
        ),
        child: Stack(
          children:  [
            Align(
              alignment: const Alignment(0,0),
              child: SizedBox(
                height: 690.1*unitH,
                width: 317*1.05*unitW,
                child: const Image(
                  image: AssetImage('assets/images/transparent_rank.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0,0),
              child: SizedBox(
                height: 690.1*unitH,
                width: 317*1.05*unitW,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30*unitH,),
                      Container(
                        height: 50*1.01*unitH,
                        width: 257*1.01*unitW,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/transparent_rank_1.png'),
                              fit: BoxFit.fill,
                            )
                        ),
                        child: Row(
                          children: [
                            const Text(
                                "我的排名:"
                            ),
                            SizedBox(width: 50*unitW,),
                            const Text("称号秒数:")
                          ],
                        ),
                      ),
                      SizedBox(height: 12.3*unitH,),
                      Container(
                        height: (420+162.5)*unitH,
                        width: 317*1.05*unitW,
                        decoration: BoxDecoration(
                          //border: Border.all(),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 0.0),
                          itemCount: itemCount,//
                          itemBuilder: (context,index){
                            int rankIndex=index+1;
                            return SizedBox(
                              height: 60*unitH,
                              child: Row(
                                children: [
                                  SizedBox(width: 7*unitW,),
                                  SizedBox(
                                    width:8.8*unitW,
                                    child: Text(
                                      rankIndex<=9?"$rankIndex ":"$rankIndex",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.0
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10*unitW,),
                                  const CircleAvatar(
                                    backgroundImage: AssetImage('assets/images/twt_round.png'),
                                  ),
                                  SizedBox(width: 10*unitW,),
                                  SizedBox(
                                    width: 120.3*unitW,
                                    child: Text(
                                      allRankData[index]['name'].toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.0,
                                      ),
                                    ),
                                  ),
                                  RankTimeText(
                                    type: 1,
                                    child: Text(
                                      getRankTimeText(index),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          physics: const BouncingScrollPhysics(),
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
  String getRankTimeText(int index){
    double temp=allRankData[index]['time'].toDouble();
    int tempSecond=temp.toInt();
    second=tempSecond%60;
    minute=tempSecond~/60;
    millisecond=((temp-tempSecond.toDouble())*1000).toInt();
    if(millisecond<=9){
      return '$second秒00$millisecond';
    }else if(millisecond<=99){
      return '$second秒0$millisecond';
    }else{
      return '$second秒$millisecond';
    }
  }
}
