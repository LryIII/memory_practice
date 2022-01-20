import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class EndFailDialog extends Dialog{
   const EndFailDialog({Key? key}) : super(key: key);


  //SmartDialog _dialog=SmartDialog();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                      Navigator.pushReplacementNamed(context, '/game_main');
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
                                // side: MaterialStateProperty.all(
                                // )
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 270.0/2.0,
                            height: 36.0,
                            child: ElevatedButton(
                              onPressed: (){
                                Navigator.pop(context);
                                Navigator.pushReplacementNamed(context, '/game_main');
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
  late int second;
  late int minute;
  late int millisecond;
  EndWinDialog({
    Key? key,
    required this.minute,
    required this.second,
    required this.millisecond
  }) : super(key: key) ;

  String getString(){
    if(minute==0){
      return second.toString()+"秒"+millisecond.toString();
    }
    return minute.toString()+"分"+second.toString()+"秒";
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                      Navigator.pushReplacementNamed(context, '/game_main');
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
                  bottom: 36,
                  left: 270/2-108/2,
                  child: TextButton(
                    child: const Text(
                      "点击查看排行榜"
                    ),
                    onPressed: (){

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
                                // side: MaterialStateProperty.all(
                                // )
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 270.0/2.0,
                            height: 36.0,
                            child: ElevatedButton(
                              onPressed: (){
                                Navigator.pop(context);
                                Navigator.pushReplacementNamed(context, '/game_main');
                                //Navigator.pushNamed(context, '/game_main');
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