import 'package:flutter/material.dart';

class EndWinDialog extends Dialog{
  const EndWinDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 350,
              width: 270,
              decoration: BoxDecoration(
                color: const Color.fromARGB(0xff, 246, 246, 246),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(height: 18,),
                  Text(
                    "继续努力鸭",
                    style: TextStyle(
                      fontSize: 19.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EndFailDialog extends Dialog{
  const EndFailDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Column(
          children: const [
            Text("hhhh"),
          ],
        ),
      ),
    );
  }
}