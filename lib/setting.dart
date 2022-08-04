
import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Setting extends StatefulWidget{
  @override
  _SettingState createState() => _SettingState();
}
class _SettingState extends State<Setting> {

  List _jsonList = [];
  String name = "";

  @override
  void initState() {
    super.initState();

    _request();
  }

  Future<void> _request() async {
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
      _jsonList = jsonResponse['Details'];
      name = _jsonList[0]["Name"];
      // title = _jsonList[0]["Name"];
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: size.width,
              padding: EdgeInsets.only(top: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    // padding: EdgeInsets.only(right: 500),
                    child: Text(
                      name + "さん",
                      style: TextStyle(
                        fontSize: 40
                        ),
                      ),
                  ),
                  // Padding(padding: EdgeInsets.only(right: 450)),
                  ElevatedButton (
                    child: Text(
                      'ログアウト',
                      style: TextStyle(
                        fontSize: 20 
                      ),
                    ),
                    onPressed: () {
                      // ログアウトを押したときの処理
                    },
                  ),
                  // Padding(padding: EdgeInsets.only(right: 30))
                ],
              ),
            ),
            Container(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // padding: EdgeInsets.only(left: 100),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 50,right: 400),
                          child: Text(
                            // textAlign: TextAlign.left,
                            '目標',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left:100,top: 50,bottom: 50,right: 100),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 100),
                                child: Text(
                                  '消費カロリー',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20, bottom: 30),
                                width: 300,
                                child: TextField(
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 20, 
                                  ),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  // 消費カロリー入力
                                ),
                              ),
                              ElevatedButton(
                                child: Text('送信'),
                                onPressed: () {
                                  // 送信の処理
                                },
                              ),
                            ]
                          ),
                        )
                      ],
                    ),

                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 200),
                    child: Column(
                      children: [
                        ElevatedButton (
                          // padding: EdgeInsets.all(20),
                          child: Text('基本データ編集'),
                          onPressed: () {
                            //基本データ編集を押したときの処理
                            Navigator.push(
                              context,
                              MaterialPageRoute (
                                builder: (context) => BasicData(),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 20)),
                        ElevatedButton (
                          // padding: EdgeInsets.all(20),
                          child: Text('種目を追加・編集'),
                          onPressed: () {
                            // 種目を追加・編集を押したときの処理
                            Navigator.push(
                              context,
                              MaterialPageRoute (
                                builder: (context) => TodoListPage(),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        )
                      ]
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}


class BasicData extends StatefulWidget {
  @override
  _BasicDataState createState() => _BasicDataState();
}
class _BasicDataState extends State<BasicData> {

  List _jsonList = [];
  List _user = ["", "", "", "", "", ""];
  // List parameter = ["Birthdate","ConsumptedC","ID","Name","Sex"];
  // List parameter = ["ID", "Name", "Birthdate", "Sex", "Height", "Weight", "Objective", "Password"]

  List<String> user_item = ['名前','誕生日','性別','身長','体重','目標消費カロリー'];
  // List user = ['Pi','ASDF','2002-1-2','男',100, 50,'**********'];

  
  @override
  void initState() {
    super.initState();

    _request();
  }

  Future<void> _request() async {
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
    String sex = '男';
    setState(() {
      var jsonResponse = jsonDecode(resp.body);
      _jsonList = jsonResponse['Details'];
      _user.insert(0, _jsonList[0]['Name']);
      DateTime date = DateTime.fromMicrosecondsSinceEpoch(_jsonList[0]['Birthdate']);
      String time = DateFormat("yyyy年MM月dd日").format(date).toString();
      _user.insert(1, time);
      if ( _jsonList[0]['Sex'] == 1 ) {
        sex = '男性';
      } else if( _jsonList[0]['Sex'] == 1 ) {
        sex = '女性';
      } else {
        sex = 'その他';
      }
      _user.insert(2, sex);
      _user.insert(3, _jsonList[0]['Height'].toString() + 'cm');
      _user.insert(4, _jsonList[0]['Weight'].toString() + 'kg');
      _user.insert(5, _jsonList[0]['Objective'].toString() + 'kcal');
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String input = '';
    
    return Scaffold(
      appBar: AppBar(title: Text('基本データ入力')),
      body: Container(
        width: double.infinity,
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text(user_item[index]),
              title: Text(_user[index].toString()),
              onTap: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(user_item[index] + 'を変更'),
                    content: TextField(
                      onChanged: (value) {
                        setState(() {
                          input = value;
                        });
                      },
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
                            _user[index] = input;
                          });
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            );
          }
       ),
      ),
    );
  }
}

// リスト一覧画面用Widget
class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {

  List _jsonList = [];
  List training_name = [];
  List training_calorie = [];

  @override
  void initState() {
    super.initState();

    _request_train();
  }

  Future<void> _request_train() async {
    // GETを投げる
    var resp = await http.get(Uri.http(
        '163.44.255.164:3000',
        '/api/training/',
        ));
    print(resp);
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
      for(var i = 0; i < _jsonList.length; i++ ) {
        training_name.add(_jsonList[i]["Name"]);
        training_calorie.add(_jsonList[i]["ConsumptingC"]);
      }
      // title = _jsonList[0]["Name"];
    });
  }

  String input_todo = "";
  int input_calorie = 0;
  String change_todo = "";
  int change_calorie = 0;

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

  // Todoリストのデータ
  // List<String> todoList = ['腹筋','背筋'];
  // List<int> calorie = [20, 30];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // AppBarを表示し、タイトルも設定
      appBar: AppBar(
        title: Text('リスト一覧'),
      ),
      // データを元にListViewを作成
      body: ListView.builder(
        itemCount: training_name.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(training_name[index] + ' ： '+ training_calorie[index].toString() + "Kcal"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('種目を変更'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: '種目名を入力してください',
                          ),
                          onChanged: (value) {
                            setState(() {
                              change_todo = value;
                            });
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: '種目のカロリーを入力してください',
                          ),
                          onChanged: (value) {
                            setState(() {
                              change_calorie = int.parse(value);
                            });
                          },
                        )
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            training_name.removeAt(index);
                            training_calorie.removeAt(index);
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          '削除',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('キャンセル'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            training_name[index] = change_todo;
                            training_calorie[index] = change_calorie;
                          });
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
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
                      training_name.add(input_todo);
                      training_calorie.add(input_calorie);
                      AddTraining();
                    });
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}