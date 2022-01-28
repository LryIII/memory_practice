import 'package:flutter/material.dart';
import 'package:memory_practice/pages/grow/grow_line_chart.dart';
import 'package:memory_practice/pages/grow/grow_state_box.dart';

class GrowContent extends StatefulWidget {
  const GrowContent({Key? key}) : super(key: key);

  @override
  _GrowContentState createState() => _GrowContentState();
}

class _GrowContentState extends State<GrowContent> {
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
            const Align(
              alignment: Alignment(0, 0),
              child: SizedBox(
                height: 690.1,
                width: 317 * 1.05,
                child: Image(
                  image: AssetImage(
                      'assets/images/user_grow_background_transparent.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, -0.74),
              child: SizedBox(
                height: 70 * 1.01,
                width: 317 * 1.05,
                //color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "自我提升",
                      style: TextStyle(
                          fontSize: 33.3, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, -0.49),
              child: Container(
                width: 307.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  //border: Border.all(),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 307.0,
                      height: 30,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(0xff, 208, 230, 253),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          )),
                      child: const Padding(
                        padding: EdgeInsets.only(
                          left: 8.0,
                          top: 3.0,
                        ),
                        child: Text(
                          '20连对最佳记录',
                          style: TextStyle(
                              color: Color.fromARGB(0xff, 70, 109, 212),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      width: 307.2,
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(0xff, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Row(
                        children: const [
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
            ),
            Align(
              alignment: const Alignment(0,0.645),
              child: Container(
                width: 307.0,
                height: 418.0,
                decoration: BoxDecoration(
                  color: const Color(0x933F51B5),//Colors.indigo[300],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: GrowLineChart(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
