import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GrowLineChart extends StatefulWidget {
  const GrowLineChart({Key? key}) : super(key: key);

  @override
  _GrowLineChartState createState() => _GrowLineChartState();
}

class _GrowLineChartState extends State<GrowLineChart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LineChart(
        LineChartData(
          //? 是否可以点击
          lineTouchData: LineTouchData(
            enabled: false,
          ),
          //? 网格线配置
          gridData: FlGridData(
            show: false,
          ),
          //axisTitleData: _buildFlAxisTitleData(),
          //? 标题
          titlesData: _buildTitles(),
          //? 边框
          borderData: _buildBorderData(),
          minX: 0,
          maxX: 14,
          maxY: 6,
          minY: 0,
          //? 线条数据
          lineBarsData: linesBarData(),
        ),
      ),
    );
  }

  //? 边框信息
  FlBorderData _buildBorderData() {
    return FlBorderData(
        show: true,
        border: const Border(
          bottom:  BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Color(0xff4e4965),
            width: 2,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        )
    );
  }

  linesBarData() {
    return [LineChartBarData(
      spots: [
        const FlSpot(1, 1),
        const FlSpot(3, 4),
        const FlSpot(5, 1.8),
        const FlSpot(7, 5),
        const FlSpot(10, 2),
        const FlSpot(12, 2.2),
        const FlSpot(13, 1.8),
      ],
      //? 是否是曲线
      isCurved: false,
      // curveSmoothness: 0,
      colors: const [
        Color(0x444af699),
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
        //show: showAboveBarData,
        colors: [
          const Color(0x444af699),
        ],
      ),
    )];
  }
  FlTitlesData _buildTitles() {
    return FlTitlesData(
      //? 下边标题
      //bottomTitles: _buildBottomTitle(),
      //? 左侧标题
      leftTitles: _buildLeftTitle(),
      rightTitles: SideTitles(
        showTitles: false,
      ),
      topTitles: SideTitles(
        showTitles: false,
      )
    );
  }

  TextStyle? getTextStyles(BuildContext context,double value){
    return const TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
  }
  SideTitles _buildLeftTitle() {
    return SideTitles(
      showTitles: true,
      getTextStyles: getTextStyles,
      getTitles: (value) {
        switch (value.toInt()) {
          case 1:
            return '1s';
          case 2:
            return '2s';
          case 3:
            return '3s';
          case 4:
            return '5s';
          case 5:
            return '6s';
        }
        return '';
      },
      margin: 8,
      reservedSize: 30,
    );
  }
}
