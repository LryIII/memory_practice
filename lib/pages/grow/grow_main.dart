import 'package:flutter/material.dart';
import 'package:memory_practice/pages/grow/grow_line_chart.dart';
import 'package:memory_practice/pages/grow/grow_state_box.dart';

import '../../components/global.dart';

class GrowContent extends StatefulWidget {
  const GrowContent({Key? key}) : super(key: key);

  @override
  _GrowContentState createState() => _GrowContentState();
}

class _GrowContentState extends State<GrowContent> {
  final unitH=GlobalUnit().unitHeight;
  final unitW=GlobalUnit().unitWidth;
  @override
  void initState() {
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
          image: AssetImage('assets/images/user_grow_background.png'),
          fit: BoxFit.cover,
        )),
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0, 0),
              child: SizedBox(
                height: 690.1*unitH,
                width: 317 * 1.05*unitW,
                child: const Image(
                  image: AssetImage(
                      'assets/images/user_grow_background_transparent.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0,0),
              child: SizedBox(
                height: 690.1*unitH,
                width: 317 * 1.05*unitW,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30*unitH,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "自我提升",
                            style: TextStyle(
                              fontSize: 33.3,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30*unitH,),
                      Container(
                        height: 100.0*unitH,
                        width: 307.0*unitW,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          //border: Border.all(),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 30*unitH,
                              width: 307.0*unitW,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(0xff, 208, 230, 253),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              child:Padding(
                                padding: EdgeInsets.only(
                                  left: 8.0*unitW,
                                  top: 3.0*unitH,
                                ),
                                child: const Text(
                                  '20连对最佳记录',
                                  style: TextStyle(
                                    color: Color.fromARGB(0xff, 70, 109, 212),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 70.0*unitH,
                              width: 307.2*unitW,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(0xff, 255, 255, 255),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                              ),
                              child: Row(
                                children: [
                                  GrowStateBox(
                                    title: "6秒666",
                                    subtitle: "最佳记录",
                                  ),
                                  GrowStateBox(
                                    title: "666",
                                    subtitle: "排行榜上",
                                  ),
                                  GrowStateBox(
                                    title: "江湖豪侠",
                                    subtitle: "等级状态",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0*unitH,),
                      Container(
                        height: 436.6*unitH,
                        width: 307.0*unitW,
                        decoration: BoxDecoration(
                          color: const Color(0x933F51B5),//Colors.indigo[300],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const GrowLineChart(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
