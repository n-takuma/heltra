
import 'dart:html';

import 'package:flutter/material.dart';

Widget Setting(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  // TODO: implement build
  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: size.width,
          padding: EdgeInsets.only(top: 100),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(right: 500),
                child: Text(
                  'ユーザー名',
                  style: TextStyle(
                    fontSize: 20
                    ),
                  ),
              ),
              // Padding(padding: EdgeInsets.only(right: 450)),
              RaisedButton (
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
              Padding(padding: EdgeInsets.only(right: 30))
            ],
          ),
        ),
        Container(
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          RaisedButton(
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
                padding: EdgeInsets.only(left: 10, top: 200),
                child: Column(
                  children: [
                    RaisedButton (
                      padding: EdgeInsets.all(20),
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
                    RaisedButton (
                      padding: EdgeInsets.all(20),
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
  );
}

class BasicData extends StatefulWidget {
  @override
  _BasicDataState createState() => _BasicDataState();
}
class _BasicDataState extends State<BasicData> {
  List<String> user_item = ['ID','名前','誕生日','性別','身長','体重','パスワード'];
  List<String> user = ['Pi','ASDF','2002-1-2','1','100','50','**********'];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String input = '';
    // const user_item = [
    //   Text("ID"), Text("名前"), Text("誕生日"), Text("性別"), Text("身長"), Text("体重"),
    // ];
    // const user = [
    //   Text("Pi"), Text("ASDF"), Text("2002-1-2"), Text("1"), Text("100"), Text("Raspberry"),
    // ];
    return Scaffold(
      appBar: AppBar(title: Text('基本データ入力')),
      body: Container(
        width: double.infinity,
        child: ListView.builder(
          itemCount: user.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text(user_item[index]),
              title: Text(user[index]),
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
                            user[index] = input;
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
  // Todoリストのデータ
  List<String> todoList = ['腹筋','背筋'];

  @override
  Widget build(BuildContext context) {
    String input = "";
    return Scaffold(
      // AppBarを表示し、タイトルも設定
      appBar: AppBar(
        title: Text('リスト一覧'),
      ),
      // データを元にListViewを作成
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(todoList[index]),
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
                      todoList.add(input);
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