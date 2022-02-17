import 'dart:math';

import 'package:flutter/material.dart';


class VerifyCode extends StatefulWidget {
  final int vCodeNum;
  final double width;
  final double height;
  final Color? backgroundColor;
  //回调
  final ValueChanged<String> verifyCallback;
  const VerifyCode({Key? key, this.vCodeNum=4, this.width=70, this.height=25, this.backgroundColor, required this.verifyCallback}) : super(key: key);


  @override
  _VerifyCodeState createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {

  static const _charsAll = ['1', '2', '3', '4', '5', '6',
    '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',  'j',
    'k', 'm', 'n', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
    'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J',
    'K', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
    'X', 'Y', 'Z'];

  String _rdStr = '';
  double maxWidth = 0.0;
  late Map _drawData;

  String getRandomString(){
    String code = "";
    for (var i = 0; i < widget.vCodeNum; i++) {
      code = code +  _charsAll[Random().nextInt(_charsAll.length)];
    }
    return code;
  }

  //随机生成绘图数据
  Map getRandomData(String srt) {
    // list
    List list = srt.split("");
    // X坐标
    double x = 0.0;
    // 最大字体大小
    double maxFontSize = 25.0;
    //将painter保存起来，先计算出位置
    List mList = [];
    for (String item in list) {
      Color color = Color.fromARGB(255, Random().nextInt(255),
          Random().nextInt(255), Random().nextInt(255));
      int fontWeight = Random().nextInt(9);
      TextSpan span = TextSpan(
        text: item,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.values[fontWeight],
          fontSize: maxFontSize - Random().nextInt(10),
        ),
      );
      TextPainter painter =
      TextPainter(text: span, textDirection: TextDirection.ltr);
      painter.layout();
      double y =
          Random().nextInt(widget.height.toInt()).toDouble() - painter.height;
      if (y < 0) {
        y = 0;
      }
      Map strMap = {"painter": painter, "x": x, "y": y};
      mList.add(strMap);
      x += painter.width + 3;
    }
    double offsetX = (widget.width - x) / 2;
    List dotData = [];
    List lineData = [];
    //绘制干扰点
    for (var i = 0; i < widget.vCodeNum; i++) {
      int r = Random().nextInt(255);
      int g = Random().nextInt(255);
      int b = Random().nextInt(255);
      double x = Random().nextInt(widget.width.toInt() - 5).toDouble();
      double y = Random().nextInt(widget.height.toInt() - 5).toDouble();
      double dotWidth = Random().nextInt(6).toDouble();
      Color color = Color.fromARGB(255, r, g, b);
      Map dot = {"x": x, "y": y, "dotWidth": dotWidth, "color": color};
      dotData.add(dot);
    }

    //绘制干扰线
    for (var i = 0; i < widget.vCodeNum; i++) {
      int r = Random().nextInt(255);
      int g = Random().nextInt(255);
      int b = Random().nextInt(255);
      double x = Random().nextInt(widget.width.toInt() - 5).toDouble();
      double y = Random().nextInt(widget.height.toInt() - 5).toDouble();
      double lineLength = Random().nextInt(20).toDouble();
      Color color = Color.fromARGB(255, r, g, b);
      Map line = {"x": x, "y": y, "lineLength": lineLength, "color": color};
      lineData.add(line);
    }

    Map checkCodeDrawData = {
      "painterData": mList,
      "offsetX": offsetX,
      "dotData": dotData,
      "lineData": lineData,
    };
    return checkCodeDrawData;
  }

  @override
  void initState() {
    _rdStr = getRandomString();
    _drawData = getRandomData(_rdStr);
    //计算最大宽度做自适应
    maxWidth = getTextSize("8" * _rdStr.length,
        TextStyle(fontWeight: FontWeight.values[8], fontSize: 25))
        .width;
    //数据回调
    widget.verifyCallback(_rdStr.toLowerCase());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      width: maxWidth > widget.width ? maxWidth : widget.width,
      height: widget.height,
      child: InkWell(
        onTap: (){
          setState(() {
            _rdStr = getRandomString();
            _drawData = getRandomData(_rdStr);
            //数据回调
            widget.verifyCallback(_rdStr.toLowerCase());
          });
        },
        child: CustomPaint(
          painter: VerifyCodePainter(drawData: _drawData),
        ),
      ),
    );
  }

  Size getTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}

class VerifyCodePainter extends CustomPainter {
  final Map drawData;

  VerifyCodePainter({
    required this.drawData,
  });

  final Paint _paint = Paint()
    ..color = Colors.grey
    ..strokeCap = StrokeCap.square
    ..isAntiAlias = true
    ..strokeWidth = 1.0
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    List mList = drawData["painterData"];

    double offsetX = drawData["offsetX"];
    //居中显示移动画布
    canvas.translate(offsetX, 0);
    //从Map中取出值，直接绘制
    for (var item in mList) {
      TextPainter painter = item["painter"];
      double x = item["x"];
      double y = item["y"];
      painter.paint(
        canvas,
        Offset(x, y),
      );
    }
    // //将画布平移回去
    canvas.translate(-offsetX, 0);
    List dotData = drawData["dotData"];
    for (var item in dotData) {
      double x = item["x"];
      double y = item["y"];
      double dotWidth = item["dotWidth"];
      Color color = item["color"];
      _paint.color = color;
      canvas.drawOval(Rect.fromLTWH(x, y, dotWidth, dotWidth), _paint);
    }

    List lineData = drawData["lineData"];
    for (var item in lineData) {
      double x = item["x"];
      double y = item["y"];
      double lineLength = item["lineLength"];
      Color color = item["color"];
      _paint.color = color;
      canvas.drawLine(Offset(x,y),Offset(x+lineLength,y), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}