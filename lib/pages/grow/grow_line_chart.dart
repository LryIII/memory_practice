
import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GrowLineChart extends StatefulWidget {
  const GrowLineChart({Key? key}) : super(key: key);

  @override
  _GrowLineChartState createState() => _GrowLineChartState();
}

class _GrowLineChartState extends State<GrowLineChart> {
  late int pointCounts;
  List<FlSpot> iniPointsData=[],pointsData=[];
  late Timer _timer;
  @override
  void initState() {
    iniPointsData=[
    const FlSpot(1, -1),
    const FlSpot(2, -4),
    const FlSpot(3, -1.8),
    const FlSpot(4, -5),
    const FlSpot(5, -2),
    const FlSpot(6, -2.2),
    const FlSpot(7, -1.8),
    ];
    _timer=Timer.periodic(const Duration(milliseconds: 200),
      (timer) {
        if(_timer.tick<=iniPointsData.length){
          pointsData.add(iniPointsData[_timer.tick-1]);
          setState(() {

          });
        }
        else{
          _timer.cancel();
        }
      }
    );
    super.initState();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 400,
        width: 500,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: 8.0,
          ),
          child: LineChart(
            LineChartData(
              //? 是否可以点击
              lineTouchData: LineTouchData(
                enabled: false,
              ),
              //? 网格线配置
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                horizontalInterval: 0.50,
                getDrawingHorizontalLine: getDrawingHorizontalLine,
                drawVerticalLine: false,
              ),
              //axisTitleData: _buildFlAxisTitleData(),
              //? 标题
              titlesData: _buildTitles(),
              //? 边框
              borderData: _buildBorderData(),
              // minX: 0,
              // //maxX: 14,
              // maxY: 0,
              // minY: -6,
              //? 线条数据
              lineBarsData: linesBarData(),
            ),
          ),
        ),
      ),
    );
  }

  //? 边框信息
  FlBorderData _buildBorderData() {
    return FlBorderData(
        show: true,
        border: const Border(
          top: BorderSide(
            color: Color(0xff4e4965),
            width: 2,
          ),
          left: BorderSide(
            color: Color(0xff4e4965),
            width: 2,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          bottom: BorderSide(
            color: Colors.transparent,
          ),
        )
    );
  }

  linesBarData() {
    return [LineChartBarData(
      spots: pointsData,
      //? 是否是曲线
      isCurved: false,
      // curveSmoothness: 0,
      colors: const [
        Color(0x444af699),
        Color(0xffffffff),
      ],
      //? 线的宽度
      barWidth: 4,
      //? 线头是否是圆形
      isStrokeCapRound: true,
      //? 是否显示数据点
      dotData: FlDotData(
        show: false,
      ),
      //? 是否显示线上区域
      aboveBarData: BarAreaData(
        show: true,
        colors: [
          const Color(0x444af699),
          Colors.blueAccent,
          Colors.purple
        ],
      ),
    )];
  }
  FlTitlesData _buildTitles() {
    return FlTitlesData(
      //? 下边标题
      topTitles:_buildTopTitle(),
      //? 左侧标题
      leftTitles: _buildLeftTitle(),
      rightTitles: SideTitles(
        showTitles: false,
      ),
      bottomTitles: SideTitles(
        showTitles: false,
      )
    );
  }

  TextStyle? getTextStyles(BuildContext context,double value){
    return const TextStyle(
      color: Colors.orange,//Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
  }
  SideTitles _buildLeftTitle() {
    return SideTitles(
      showTitles: true,
      getTextStyles: getTextStyles,
      getTitles: (value) {
        value= value==0.0 ? 0 : -value;
        return "$value""s";
      },
      interval: 0.5,
      margin: 8,
      reservedSize: 30,
    );
  }

  SideTitles _buildTopTitle() {
    return SideTitles(
      showTitles: true,
      getTextStyles: getTextStyles,
      getTitles: (value) {
        int temp=value.toInt();
        return "$temp";
      },
      interval: 1,
      margin: 8,
      reservedSize: 30,
    );
  }

  FlLine getDrawingHorizontalLine(double value) {
    return FlLine(
      color: Colors.deepOrange,
      strokeWidth: 3,
      dashArray: [11,2,],
    );
  }
}
