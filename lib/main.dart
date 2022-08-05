import 'dart:convert';

import 'package:flutter/material.dart';

import 'master.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      // アプリ名
      title: 'heltra',
      theme: ThemeData(
        // テーマカラー
        primarySwatch: Colors.blue,
        fontFamily: 'Noto Sans JP'
      ),
      // ログイン画面を表示
      home: LoginPage(),
    );
  }
}

/* --- 省略 --- */

// ログイン画面用Widget
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // メッセージ表示用
  String infoText = '';
  // 入力したメールアドレス・パスワード
  String id = Random().nextInt(100000).toString();
  String password = '';
  String name = '';
  DateTime birthdate = DateTime.now();
  String str_sex = '';
  int sex = 0;
  int height = 0;
  int weight = 0;

  void AddRegist() async {
    if ( str_sex == '男') {
      sex = 1;
    } else {
      sex = 0;
    }
  final birthdateUnixTime = birthdate.millisecondsSinceEpoch;

  String url = "http://163.44.255.164:3000/api/register";
  Map<String, String> headers = {'content-type': 'application/json'};
  String body = json.encode({
    "ID": id,
    "Name": name,
    "Birthdate": birthdateUnixTime,
    "Sex": sex,
    "Height": height,
    "Weight": weight,
    "Password": "Raspberry"
    // "ID": "asd",
    // "Name": "ASDF",
    // "Birthdate": 12341234,
    // "Sex": 1,
    // "Height": 169,
    // "Weight": 55,
    // "Password": "Raspberry"
  });

  http.Response resp = await http.post( Uri.parse(url), headers: headers, body: body);
  if (resp.statusCode != 200) {
    setState(() {
      int statusCode = resp.statusCode;
      print("Failed to post $statusCode");
    });
    return;
  }
  setState(() {
    print(resp.body);
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // 'ID','名前','誕生日','性別','身長','体重','パスワード'
                // ID入力
                TextFormField(
                  decoration: InputDecoration(labelText: 'ID'),
                  onChanged: (String value) {
                    setState(() {
                      id = value;
                    });
                  },
                ),
                // パスワード入力
                TextFormField(
                  decoration: InputDecoration(labelText: 'パスワード'),
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: '名前'),
                  onChanged: (String value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: '誕生日'),
                  onChanged: (String value) {
                    setState(() {
                      birthdate = DateTime(int.parse(value));
                      // birthdate = value + '00:00:00.000';
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: '性別'),
                  onChanged: (String value) {
                    setState(() {
                      str_sex = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: '身長'),
                  onChanged: (String value) {
                    setState(() {
                      height = int.parse(value);
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: '体重'),
                  onChanged: (String value) {
                    setState(() {
                      weight = int.parse(value);
                    });
                  },
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  // メッセージ表示
                  child: Text(infoText),
                ),
                Container(
                  width: double.infinity,
                  // ユーザー登録ボタン
                  child: ElevatedButton(
                    child: Text('ユーザー登録'),
                    onPressed: () async {
                      AddRegist();
                      DateTime.now();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Master(),
                        )
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}