// （1） 必要なパッケージのimport宣言
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'glaphPrevious.dart';

class PreviousData extends StatefulWidget {
  @override
  _PreviousDataState createState() => _PreviousDataState();
}

class _PreviousDataState extends State<PreviousData> {
  // （1） 入力された日付変数
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  // : （省略）

  List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
  List<String> events = ['腕立て伏せ', '背筋', '腹筋', 'ランニング', 'ハイキング', 'バイキング', 'その他'];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: Center(
              child: Text(
            "${_startDate.year}年${_startDate.month}月${_startDate.day}日~${_endDate.year}年${_endDate.month}月${_endDate.day}日",
            style: TextStyle(
              fontSize: 30,
            ),
          )),
          ),
          OutlinedButton(
              // （2） ボタンを押した時に入力できるようにする
              onPressed: () => _openSample4(context),
              child: Text(
                "日付選択",
                style: TextStyle(
                  fontSize: 20,
                ),
              )),
          // : （省略）

        ]),
      ),
      Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 100),
            height: 400,
            width: 400,
            child: PieChartSample1(),
          ),
          _buildChild(),
        ],
      )
    ]);
  }

  Future<void> _openSample4(BuildContext context) async {
    //  （2） showDateRangePickerを使う
    final DateTimeRange? _range = await showDateRangePicker(
      context: context,
      // （3） 初期の日付期間を指定する
      initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime.now(),
    );
    if (_range != null) {
      setState(() {
        // （4） 期間の開始と終了の設定
        _startDate = _range.start;
        _endDate = _range.end;
      });
    }
  }

  @override
  Widget _buildChild() {
    List<Widget> indicators = [];
    if (events.isEmpty) {
      indicators.add(Container(
        padding: const EdgeInsets.only(top: 30),
        child: const Indicator(
          color: Colors.grey,
          text: '該当なし',
          isSquare: true,
        ),
      ));
    }
    for (var i = 0; i < events.length; i++) {
      indicators.add(
        Container(
          padding: const EdgeInsets.only(top: 30),
          child: Indicator(
            color: colors[i],
            text: events[i],
            isSquare: true,
          ),
        ),
      );
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: indicators);
  }
}