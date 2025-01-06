import 'package:expense_tracker_app/bar_graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tuesAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  const BarGraph({
    super.key,
    this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tuesAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunAmount: sunAmount,
      monAmount: monAmount,
      tuesAmount: tuesAmount,
      wedAmount: wedAmount,
      thurAmount: thurAmount,
      friAmount: friAmount,
      satAmount: satAmount,
    );

    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        minY: 0,
        maxY: maxY,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 60,
              getTitlesWidget: getBottomTitles,
            ),
          ),
        ),
        barTouchData: BarTouchData(
          enabled: false,
        ),
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Colors.blue[500],
                    width: 25,
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxY,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text('S', style: style);
      break;
    case 1:
      text = Text('M', style: style);
      break;
    case 2:
      text = Text('T', style: style);
      break;
    case 3:
      text = Text('W', style: style);
      break;
    case 4:
      text = Text('T', style: style);
      break;
    case 5:
      text = Text('F', style: style);
      break;
    case 6:
      text = Text('S', style: style);
      break;
    default:
      text = Text('', style: style);
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 5,
    child: text,
  );
}
