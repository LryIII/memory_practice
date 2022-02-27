import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class EndFailDialog extends Dialog{
   const EndFailDialog({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(240, 0, 0, 15),
                  child: IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      size: 30,
                      color: Colors.grey,
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/game_main',arguments: {
                        'isFirst':false
                      });
                    },
                  ),
                )
              ],
            ),
            Stack(
              children: [
                Container(
                  height: 350,
                  width: 270,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(0xff, 246, 246, 246),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                const Positioned(
                  left: 270.0/2.0-95.0/2.0,
                  top: 20,
                  child: Text(
                    "继续努力鸭",
                    style: TextStyle(
                      fontSize: 19.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  left: 31,
                  top: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height:148*1.1,
                        width: 187*1.1,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/fail_bee.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 43,
                  left: 270/2-108/2,
                  child: TextButton(
                    child: const Text(
                        "点击查看排行榜"
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(context, '/rank');
                    },
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                          Colors.transparent,//设置水波纹的颜色
                        )
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1.0,
                        width: 270,
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 270.0/2.0,
                            height: 36.0,
                            child: ElevatedButton(
                              child: const Text(
                                "分享给好友",
                                style: TextStyle(
                                  color: Colors.black54
                                ),
                              ),
                              onPressed: (){
                                SmartDialog.showToast(
                                  '暂不支持分享，敬请期待',
                                  time: const Duration(milliseconds: 1000),
                                );
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.zero,
                                      topRight: Radius.zero,
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.zero,
                                    ),
                                  )
                                ),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(
                                        color: Colors.black,
                                    )
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(0xff, 246, 246, 246)
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 270.0/2.0,
                            height: 36.0,
                            child: ElevatedButton(
                              onPressed: (){
                                Navigator.pop(context);
                                Navigator.pushReplacementNamed(context, '/game_main',arguments: {
                                  'isFirst':false
                                });
                              },
                              child: const Text("再次挑战"),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.zero,
                                      topRight: Radius.zero,
                                      bottomLeft: Radius.zero,
                                      bottomRight: Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                textStyle: MaterialStateProperty.all(
                                  const TextStyle(
                                    color: Colors.white
                                  )
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.black
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class EndWinDialog extends Dialog{
  final int second;
  final int minute;
  final int millisecond;
  //0 未刷新记录 ，1 刷新纪录 , 2未登录
  final int type;
  const EndWinDialog({
    Key? key,
    required this.minute,
    required this.second,
    required this.millisecond,
    required this.type,
  }) : super(key: key) ;

  String getString(){
    if(minute==0){
      return second.toString()+"秒"+millisecond.toString();
    }
    return minute.toString()+"分"+second.toString()+"秒";
  }
  String getTextString(){
    if(type==0){
      return getString()+"，加油！";
    }
    if(type==1){
      return getString()+"，刷新个人记录！！";
    }
    return getString()+'您还未登录';
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(240, 0, 0, 15),
                  child: IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      size: 30,
                      color: Colors.grey,
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/game_main',arguments: {
                        'isFirst':false
                      });
                    },
                  ),
                )
              ],
            ),
            Stack(
              children: [
                Container(
                  height: 350,
                  width: 270,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(0xff, 246, 246, 246),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                Positioned(
                  left: 270.0/2.0-227.0/2.0,
                  top: 20,
                  child: Text(
                    getString()+"，刷新个人记录！！",
                    style: const TextStyle(
                      fontSize: 19.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  //alignment: const Alignment(0,0),
                  left: 52.1,
                  top: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height:225*0.8,
                        width: 204*0.8,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/success_lion.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        // child: Image(
                        //   image: AssetImage,
                        // ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 36,
                  left: 270/2-108/2,
                  child: TextButton(
                    child: const Text(
                      "点击查看排行榜"
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.popAndPushNamed(context, '/rank');
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                        Colors.transparent,//设置水波纹的颜色
                      )
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1.0,
                        width: 270,
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 270.0/2.0,
                            height: 36.0,
                            child: ElevatedButton(
                              child: const Text(
                                "分享给好友",
                                style: TextStyle(
                                    color: Colors.black54
                                ),
                              ),
                              onPressed: (){
                                SmartDialog.showToast(
                                  '暂不支持分享，敬请期待',
                                  time: const Duration(milliseconds: 1000),
                                );
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.zero,
                                        topRight: Radius.zero,
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.zero,
                                      ),
                                    )
                                ),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(
                                      color: Colors.black,
                                    )
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(0xff, 246, 246, 246)
                                ),
                                overlayColor: MaterialStateProperty.all(
                                  Colors.tealAccent,
                                )
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 270.0/2.0,
                            height: 36.0,
                            child: ElevatedButton(
                              onPressed: (){
                                Navigator.pop(context);
                                Navigator.pushReplacementNamed(context, '/game_main',arguments: {
                                  'isFirst':false
                                });
                              },
                              child: const Text("再次挑战"),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.zero,
                                      topRight: Radius.zero,
                                      bottomLeft: Radius.zero,
                                      bottomRight: Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(
                                        color: Colors.white
                                    )
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.black
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}