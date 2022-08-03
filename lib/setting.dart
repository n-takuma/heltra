
import 'dart:html';

import 'package:flutter/material.dart';
class Setting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 100,left: 500),
            child: Row(
              children: [
                Container(
                  child: Text(
                    'ユーザー名',
                    style: TextStyle(
                      fontSize: 20
                      ),
                    ),
                ),
                Padding(padding: EdgeInsets.only(right: 450)),
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
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 100),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 100),
                        child: Text(
                          textAlign: TextAlign.left,
                          '目標',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left:10,top: 20,bottom: 20, right: 400),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Text('消費カロリー'),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 30, left: 20, bottom: 100),
                              width: 340,
                              child: TextField(
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
                  padding: EdgeInsets.only(left: 180, top: 200),
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
}

class BasicData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const user = [
      Text("Pi"), Text("ASDF"), Text("2002-1-2"), Text("1"), Text("100"), Text("Raspberry"),
    ];
    return Scaffold(
      appBar: AppBar(title: Text('基本データ入力')),
      body: ListView(
          children: [

          ],
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
          // "push"で新規画面に遷移
          // リスト追加画面から渡される値を受け取る
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              // 遷移先の画面としてリスト追加画面を指定
              return TodoAddPage();
            }),
          );
          if (newListText != null) {
            // キャンセルした場合は newListText が null となるので注意
            setState(() {
              // リスト追加
              todoList.add(newListText);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  // 入力されたテキストをデータとして持つ
  String _text = '';

  // データを元に表示するWidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト追加'),
      ),
      body: Container(
        // 余白を付ける
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 入力されたテキストを表示
            Text(_text, style: TextStyle(color: Colors.blue)),
            const SizedBox(height: 8),
            // テキスト入力
            TextField(
              // 入力されたテキストの値を受け取る（valueが入力されたテキスト）
              onChanged: (String value) {
                // データが変更したことを知らせる（画面を更新する）
                setState(() {
                  // データを変更
                  _text = value;
                });
              },
            ),
            const SizedBox(height: 8),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // リスト追加ボタン
              child: ElevatedButton(
                onPressed: () {
                  // "pop"で前の画面に戻る
                  // "pop"の引数から前の画面にデータを渡す
                  Navigator.of(context).pop(_text);
                },
                child: Text('リスト追加', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // キャンセルボタン
              child: TextButton(
                // ボタンをクリックした時の処理
                onPressed: () {
                  // "pop"で前の画面に戻る
                  Navigator.of(context).pop();
                },
                child: Text('キャンセル'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}