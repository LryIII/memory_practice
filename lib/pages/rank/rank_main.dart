
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:memory_practice/components/entrance_to_login.dart';
import 'package:memory_practice/pages/rank/rank_network.dart';
import 'package:memory_practice/pages/rank/rank_time_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../components/global.dart';

class RankContent extends StatefulWidget {
  const RankContent({Key? key}) : super(key: key);

  @override
  _RankContentState createState() => _RankContentState();
}

class _RankContentState extends State<RankContent> {
  int itemCount=0,second=0,millisecond=0,minute=0;
  int currentTime=1;
  late int nowEnd;
  List allRankData=[];
  final unitH=GlobalUnit().unitHeight;
  final unitW=GlobalUnit().unitWidth;

  String rankString='';
  String timeString='';

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  void _onRefresh() async {
    Map temp= await RankMyItem().getAllRank(1, nowEnd);
    allRankData.clear();
    allRankData.addAll(temp['result'].toList());
    if(mounted){
      setState(() {

      });
    }
    _refreshController.refreshCompleted();
  }
  void _onLoading() async{
    if(itemCount<=10){
      nowEnd=itemCount;
      if(mounted){
        setState(() {

        });
      }
      _refreshController.loadNoData();
      return ;
    }
    if((currentTime-1)*10+1>itemCount){
      nowEnd=itemCount;
      _refreshController.loadNoData();
      if(mounted){
        setState(() {
        });
      }
      return ;
    }
    if(currentTime*10>itemCount){
      Map temp= await RankMyItem().getAllRank((currentTime-1)*10+1, itemCount);
      allRankData.addAll(temp['result'].toList());
      currentTime++;
      nowEnd=itemCount;
      if(mounted){
        setState(() {

        });
      }
      _refreshController.loadComplete();
      return ;
    }
    Map temp= await RankMyItem().getAllRank((currentTime-1)*10+1, currentTime*10);
    allRankData.addAll(temp['result'].toList());
    currentTime++;
    nowEnd=currentTime*10;
    if(mounted){
      setState(() {

      });
    }
    _refreshController.loadComplete();
  }
  getData() async{

    if(globalData.isLogin){
      rankString=await globalData.getMyRank();
      timeString=await globalData.getBestTime();
    }
    itemCount= await RankMyItem().getAllNum();
    if(itemCount>=100){
      itemCount=99;
    }
    if(itemCount>=10){
      Map temp= await RankMyItem().getAllRank((currentTime-1)*10+1, currentTime*10);
      allRankData.addAll(temp['result'].toList());
      nowEnd=currentTime*10;
      currentTime++;
    }else{
      nowEnd=itemCount;
      Map temp= await RankMyItem().getAllRank(1, itemCount);
      allRankData.addAll(temp['result'].toList());
    }
    setState(() {

    });
  }
  @override
  void initState() {
    if(globalData.bestTime<=10000){
      globalData.uploadBest();
    }
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
                      GestureDetector(
                        onTap: (){
                          if(globalData.isLogin){

                          }else{
                            SmartDialog.show(
                              // here
                              backDismiss: false,
                              clickBgDismissTemp: false,
                              isLoadingTemp: false,
                              widget: EntranceToLogin(
                                onPressed: (){
                                  SmartDialog.dismiss();
                                  Navigator.of(context).pushNamed('/login');
                                },
                              ),
                            );
                          }
                        },
                        child: Container(
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
                              SizedBox(
                                width: 50*unitW,
                                child: Text(
                                  rankString,
                                ),
                              ),
                              const Text("称号秒数:"),
                              SizedBox(
                                width: 50*unitW,
                                child: Text(
                                  timeString,
                                ),
                              ),
                            ],
                          ),
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
                        child: SmartRefresher(
                          controller: _refreshController,
                          enablePullDown: true,
                          enablePullUp: true,
                          header: const WaterDropHeader(),
                          onLoading: _onLoading,
                          onRefresh: _onRefresh,
                          footer:  CustomFooter(
                            builder: (BuildContext context,LoadStatus? mode){
                              Widget body ;
                              TextStyle _style=const TextStyle(
                                color: Colors.white,
                              );
                              if(mode==LoadStatus.idle){
                                body = Text("上拉加载",style: _style,);
                              }
                              else if(mode==LoadStatus.loading){
                                body =  const CupertinoActivityIndicator();
                              }
                              else if(mode == LoadStatus.failed){
                                body = Text("加载失败！点击重试！",style: _style,);
                              }
                              else if(mode == LoadStatus.canLoading){
                                body = Text("松手,加载更多!",style: _style,);
                              }
                              else{
                                body = Text("没有更多数据了!",style: _style,);
                              }
                              return Container(
                                height: 55.0,
                                child: Center(child:body),
                              );
                            },
                          ),
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 0.0),
                            itemCount: allRankData.length,//
                            itemBuilder: (context,index){
                              int rankIndex=index+1;
                              return SizedBox(
                                height: 60*unitH,
                                child: Row(
                                  children: [
                                    SizedBox(width: 7*unitW,),
                                    SizedBox(
                                      width:18.0*unitW,
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
    if(tempSecond>=100000){
      return '——';
    }
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
