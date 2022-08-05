import 'dart:convert';
import 'dart:html';
import 'glaphSample.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import 'glaphSample.dart';

class Dropdown extends StatefulWidget {

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  Object _selectevent = '種目を追加';
  final controller = TextEditingController();
  var conting = 0;
  @override
  DateTime _startDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    // _request();
    // _my_request();
  }

  List _jsonList = [];
  List<String> example = [
    "種目を追加",
    "背筋",
    "腹筋",
  ];

  Future<void> _request() async {
    // GETを投げる
    var resp = await http.get(Uri.http(
        '163.44.255.164:3000',
        '/api/customeTR/',
        // '/api/training/',
        ));
    if (resp.statusCode != 200) {
      setState(() {
        int statusCode = resp.statusCode;
      });
      return;
    }
    setState(() {
      var jsonResponse = jsonDecode(resp.body);
      _jsonList = jsonResponse['Details'];
      for(var i = 0; i < _jsonList.length; i++ ) {
        example.add(_jsonList[i]["Name"]);
        // training_calorie.add(_jsonList[i]["ConsumptingC"]);
      }
      // title = _jsonList[0]["Name"];
    });
  }

  List _my_jsonList = [];
  String calorie = '100';

  Future<void> _my_request() async {
    // GETを投げる
    var resp = await http.get(Uri.http(
        '163.44.255.164:3000',
        '/api/users/getUser',
        ));
    if (resp.statusCode != 200) {
      setState(() {
        int statusCode = resp.statusCode;
        // _content = "Failed to get $statusCode";
      });
      return;
    }
    setState(() {
      var jsonResponse = jsonDecode(resp.body);
      _my_jsonList = jsonResponse['Details'];
      calorie = _my_jsonList[0]['Objective'].toString();
    });
  }

  String input_todo = "";
  int input_calorie = 0;

  Future<http.Response> AddTraining() {
    return http.post(
      Uri.parse('http://163.44.255.164:3000/api/training/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'Name': input_todo,
        'ConsumptingC': input_calorie,
      }),
    );
  }

  Widget build(BuildContext context) {
    DateTime _Date = DateTime.now();

    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(children: [
      Container(
        width: size.width,
        // height: size.height,
        padding: EdgeInsets.only(top: 100),

        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Text(
                    '達成度',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  //   // padding: EdgeInsets.only(top: 100),
                  //   // child: Text('達成度'),
                  child: PieChartSample2(),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    '5000/10000 Kcal',
                    style: TextStyle(fontSize: 30),
                  ),
                )
              ],
            ),
          ),
          Expanded(
          child: Container(
            child: Column(children: [
              Container(
                child: Text(
                  '今日の消費カロリー',
                  style: TextStyle(fontSize: 35),
                ),
              ),
              Container(
                child: Text(
                  '20Kcal',
                  style: TextStyle(fontSize: 50),
                ),
              )
            ]),
          )
          )
        ]),
      ),
      Container(
        // width: size.width,
        padding: EdgeInsets.only(top: 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
          children: [
          Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                  child: Text(
                "${_startDate.year}年${_startDate.month}月${_startDate.day}日",
                style: TextStyle(
                  fontSize: 30,
                ),
              )),
              OutlinedButton(
                  // （2） ボタンを押した時に入力できるようにする
                  onPressed: () => _openSample1(context),
                  child: Text(
                    "日付選択",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
              // : （省略）
            ]),
          ),
          SizedBox(
            height: 80,
            width: 150,
            child: DropdownButton(
              items: [
                for (final item in example)
                  DropdownMenuItem(
                    child: Text(item),
                    value: item,
                  ),
              ],
              hint: Text('種目を選択'),
              value: _selectevent,
              onChanged: (Object? value) {
                if (value == null) return;
                setState(() {
                  _selectevent = value;
                });
                if (value == "種目を追加") {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('種目を追加'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: '種目を入力してください',
                            ),
                            onChanged: (value) {
                              setState(() {
                                input_todo = value;
                              });
                            },
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: '種目のカロリーを入力してください',
                            ),
                            onChanged: (value) {
                              setState(() {
                                input_calorie = int.parse(value);
                              });
                            },
                          )
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('キャンセル'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              example.add(input_todo);
                              AddTraining();
                              // calorie.add(input_calorie);
                              // カロリーの追加
                            });
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  width: 100,
                  child: TextFormField(
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                Container(
                  child: Text(
                    '分',
                    style: TextStyle(fontSize: 40),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
      Container(
        width: size.width,
        padding: EdgeInsets.only(top: 100),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            margin: EdgeInsets.only(right: 30),
            child: ElevatedButton(
              // padding: EdgeInsets.symmetric(horizontal: 40),
              // color: Colors.red,
              child: Text(
                '登録',
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () {
                // 送信の処理
              },
            ),
          ),
        ]),
      ),
    ]));
  }

  Future<void> _openSample1(BuildContext context) async {
    // （3） ダイアログを表示する
    final DateTime? _date = await showDatePicker(
      context: context,
      // （4） 処理指定日付
      initialDate: DateTime.now(),
      // （5） 指定できる日付範囲
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime.now(),
    );
    // （6） 選択された場合に、値を設定する
    if (_date != null) {
      setState(() {
        _startDate = _date;
      });
    }
  }
}
