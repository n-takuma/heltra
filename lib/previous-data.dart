// （1） 必要なパッケージのimport宣言
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'glaphPrevious.dart';
import 'package:http/http.dart' as http;
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
  List<String> events = ['腕立て伏せ', '背筋', '腹筋', 'ランニング', 'ハイキング', 'バイキング', 'ハッキング'];

  List _jsonList = [];
  // List<String> events = [];
  List<double> each_calorie = [];

  Future<void> _request() async {
    // GETを投げる
    final unixTime1 = _startDate.millisecondsSinceEpoch;
    final unixTime2 = _endDate.millisecondsSinceEpoch;
    String url = "http://163.44.255.164:3000/api/register";
  Map<String, String> headers = {'content-type': 'application/json'};
  String body = json.encode({
    "StartTime": unixTime1.toString(),
    "EndTime": unixTime2.toString(),
  });

  http.Response resp = await http.post( Uri.parse(url), headers: headers, body: body);

    // var resp = await http.get(Uri.http(
    //     '163.44.255.164:3000',
    //     '/api/training/',
    //     ));
    if (resp.statusCode != 200) {
      setState(() {
        int statusCode = resp.statusCode;
        // _content = "Failed to get $statusCode";
      });
      return;
    }
    setState(() {
      var jsonResponse = jsonDecode(resp.body);
      _jsonList = jsonResponse['Details'];
      for (var i = 0; i < _jsonList.length; i++ ) {
        events.add(_jsonList[i]["TName"]);
        each_calorie.add(_jsonList[i]["ConsumptingC"]);
      }
    });
  }

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
        _request();
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