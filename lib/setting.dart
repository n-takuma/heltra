
import 'dart:html';

import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('次'),
      ),
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
                Padding(padding: EdgeInsets.only(right: 400)),
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
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 60),
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
                  padding: EdgeInsets.only(left: 150, top: 200),
                  child: Column(
                    children: [
                      RaisedButton (
                        padding: EdgeInsets.all(20),
                        child: Text('基本データ編集'),
                        onPressed: () {
                          //基本データ編集を押したときの処理
                        },
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20)),
                      RaisedButton (
                        padding: EdgeInsets.all(20),
                        child: Text('種目を追加・編集'),
                        onPressed: () {
                          // 種目を追加・編集を押したときの処理
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