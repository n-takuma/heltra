import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    // 画面の指定
    return PieChart(
      PieChartData(
        startDegreeOffset: 270,
          pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          }),
          // グラフのborder
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 100,
          sections: showingSections()),
    );

    //   // グラフの一つのインジケーターについて
    // Column(
    //   mainAxisSize: MainAxisSize.min,
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: const <Widget>[
    //     Indicator(
    //       color: Color(0xff0293ee),
    //       text: 'First',
    //       isSquare: true,
    //     ),
    //     SizedBox(
    //       height: 4,
    //     ),
    //     Indicator(
    //       color: Color(0xfff8b250),
    //       text: 'Second',
    //       isSquare: true,
    //     ),
    //     SizedBox(
    //       height: 4,
    //     ),
    //     Indicator(
    //       color: Color(0xff845bef),
    //       text: 'Third',
    //       isSquare: true,
    //     ),
    //     SizedBox(
    //       height: 4,
    //     ),
    //     Indicator(
    //       color: Color(0xff13d38e),
    //       text: 'Fourth',
    //       isSquare: true,
    //     ),
    //   ],
    // )
    //   ],
    // );
  }

  // インジケーターの値代入
  List<PieChartSectionData> showingSections() {
     List<double> values = [
      10,
      10,
      10,
      10,
      10,
      10,
      40,
    ];
    List<Color> colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
      ];
    return List.generate(7, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: colors[0],
            value: values[0],
            title: values[0].toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white
                ),
          );
        case 1:
          return PieChartSectionData(
            color: colors[1],
            value: values[1],
            title: values[1].toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white
                ),
          );
        case 2:
            return PieChartSectionData(
            color: colors[2],
            value: values[2],
            title: values[2].toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white
                ),
          );
        case 3:
          return PieChartSectionData(
            color: colors[3],
            value: values[3],
            title: values[3].toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white
                ),
          );
        case 4:
        return PieChartSectionData(
            color: colors[4],
            value: values[4],
            title: values[4].toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white
                ),
          );
          case 5:
          return PieChartSectionData(
            color: colors[5],
            value: values[5],
            title: values[5].toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white
                ),
          );
          case 6:
          return PieChartSectionData(
            color: colors[6],
            value: values[6],
            title: values[6].toString() + '%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white
                ),
          );
        default:
          throw Error();
      }
    });
  }
}

// インジケータークラス
class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 分からない
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}
