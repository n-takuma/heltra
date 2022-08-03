import 'dart:html';
import 'dart:js';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'setting.dart';
import 'toppage.dart';
import 'previous-data.dart';

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
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('heltra'),
            bottom: const TabBar(tabs: <Widget>[
              Tab(text: 'トップ'),
              Tab(text: '過去データ'),
              // Tab(text: 'フレンド'),
              Tab(text: '設定'),
            ]),
          ),
          body: TabBarView(
            children: <Widget>[
              Builder(builder: (BuildContext context) {
                return TopPage(context);
              }),
              Builder(builder: (BuildContext context) {
                return PreviousData(context);
              }),
              Setting()
            ],
          ),
        ),
      ),
    );
  }
}
