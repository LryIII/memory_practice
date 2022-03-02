import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:memory_practice/components/global.dart';

class EntranceToLogin extends StatelessWidget {
  final void Function()? onPressed;
  EntranceToLogin({Key? key,required this.onPressed}) : super(key: key);

  final unitH=GlobalUnit().unitHeight;
  final unitW=GlobalUnit().unitWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480*unitH,
      width: 300*unitW,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height:120*unitH,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "您还没有登录哦",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onPressed,
                  child: const Text(
                    "登录",
                  ),
                ),
                SizedBox(width: 30*unitW,),
                ElevatedButton(
                  onPressed: ()=>SmartDialog.dismiss(),
                  child: const Text(
                    "取消",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
