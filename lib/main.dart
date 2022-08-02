import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('heltra'),
            bottom: const TabBar(tabs: <Widget>[
              Tab(text: 'トップ'),
              Tab(text: '過去データ'),
              Tab(text: 'フレンド'),
              Tab(text: '設定'),
            ]),
          ),
          body: TabBarView(
            children: <Widget>[
              _title(),
              // Center(child: Text('くもり', style: TextStyle(fontSize: 50))),
              Center(child: Text('雨', style: TextStyle(fontSize: 50))),
              Center(child: Text('晴れ', style: TextStyle(fontSize: 50))),
              Center(child: Text('嵐', style: TextStyle(fontSize: 50)))
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button thi',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget _title() {
  const data = [
      Text("item0"),Text("item1"),Text("item2"),Text("item3"),Text("item4"),
    ];
  return Scaffold(
    body: Column(children: [
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 1000,
        ),
        child: Container(
          padding: EdgeInsets.only(top: 100, left: 100, right: 100),
          // alignment: Alignment.centerRight,
          child: Row(
            children: [
            Container(
              padding: EdgeInsets.only(right: 300),
              child: Text(
                '達成度',
                style: TextStyle(fontSize: 50),
              ),
            ),
            Container(
              child: Column(
                children:[
                  Container(  
              child: Text(
                '今日の消費カロリー',
                style: TextStyle(fontSize: 35),
              ),
            ),
            Container(
              child: Text(
                '600Kcal',style: TextStyle(fontSize: 50),
              ),
            )
              ]
              ),
            )
          ]),
        ),
      ),
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 1000,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 100),
          child: Row(children: [
            Container(
              padding: EdgeInsets.only(right: 50),
              child: Text(
                '現在の日付',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 250),
              child: Text(
                '種目を選択',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              child: Text(
                '～分',
                style: TextStyle(fontSize: 50),
              ),
            )
          ]),
        ),
      ),
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 1000,
        ),
        child: Container(
          child: Row(children: [
            Container(
              margin: EdgeInsets.only(left: 800),
              padding: EdgeInsets.symmetric(horizontal: 40),
              color: Colors.red,
              child: Text('登録',style: TextStyle(fontSize: 30),),
            )
          ]),
        ),
      ),
    ]),
  );
}
