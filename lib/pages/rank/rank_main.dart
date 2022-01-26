import 'package:flutter/material.dart';
import 'package:memory_practice/pages/rank/rank_network.dart';
import 'package:memory_practice/pages/rank/rank_time_text.dart';

class RankContent extends StatefulWidget {
  const RankContent({Key? key}) : super(key: key);

  @override
  _RankContentState createState() => _RankContentState();
}

class _RankContentState extends State<RankContent> {
  late int itemCount;
  @override
  void initState() {
    itemCount=20;
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
            const Align(
              alignment: Alignment(0,0),
              child: SizedBox(
                height: 747*0.94,
                width: 317*0.94,
                child: Image(
                  image: AssetImage('assets/images/transparent_rank.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0,-0.74),
              child: Container(
                height: 50*0.9,
                width: 257*0.9,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/transparent_rank_1.png'),
                    fit: BoxFit.fill,
                  )
                ),
                child: Row(
                  children: const [
                    Text(
                      "我的排名:"
                    ),
                    SizedBox(width: 50,),
                    Text("称号秒数:")
                  ],
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0,0.55),
              child: Container(
                width: 317*0.94,
                height: 420+162.5,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 0.0),
                  itemCount: itemCount,
                  itemBuilder: (context,index){
                    int rankIndex=index+1;
                    return Container(
                      height: 60,
                      child: Row(
                        children: [
                          Text(
                            rankIndex<=9?"$rankIndex ":"$rankIndex",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10,),
                          const CircleAvatar(
                            backgroundImage: AssetImage('assets/images/twt_round.png'),
                          ),
                          const Text(
                            "这是昵称",
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                          // const Text(
                          //   "0秒xxx",
                          //   style: TextStyle(
                          //       color: Colors.white
                          //   ),
                          //),
                          const SizedBox(width: 30,),
                          RankTimeText(
                            type: 1,
                            child: const Text(
                              "超凡入圣 8秒888",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      // decoration: BoxDecoration(
                      //   border: Border.all(
                      //     color: Colors.black,
                      //   )
                      // ),
                    );
                  },
                  physics: const BouncingScrollPhysics(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
