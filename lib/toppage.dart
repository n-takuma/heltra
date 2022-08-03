import 'package:flutter/material.dart';
import 'glaphSample.dart';


class Dropdown extends StatefulWidget {
  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  Object _selectitem = 'item0';
  Object _selectevent = 'brother0';
  final controller = TextEditingController();
  var conting = 0;
  @override
  Widget build(BuildContext context) {
    const data = [
      "item0",
      "item1",
      "item2",
      "item3",
      "item4",
    ];
    const example = [
      "brother0",
      "brother1",
      "brother2",
      "brother3",
      "brother4",
    ];
    final Size size = MediaQuery.of(context).size;
    return Column(children: [
      Container(
        width: size.width,
        padding: EdgeInsets.only(top: 100),
        // alignment: Alignment.centerRight,
        // 画面幅を取って、カラムの画面幅を常にその画面幅にする

        // ドロップダウンはループのマップ

        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // padding:EdgeInsets.only(top: 100),
            children: [
              Container(
              //   // padding: EdgeInsets.only(top: 100),
              //   // child: Text('達成度'), 
                // child:PieChartSample2(
                  
                // )
                child: Text('達成度',style: TextStyle(fontSize: 50),),
              ),
              Container(
                child: Column(children: [
                  Container(
                    child: Text(
                      '今日の消費カロリー',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                  Container(
                    child: Text(
                      '600Kcal',
                      style: TextStyle(fontSize: 50),
                    ),
                  )
                ]),
              )
            ]),
      ),
      Container(
        width: size.width,
        padding: EdgeInsets.only(top: 100),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          // Container(
          //   child: Row(
          //     children[
          DropdownButton(
            items: [
              for (final item in data)
                DropdownMenuItem(
                  child: Text(item),
                  value: item,
                ),
            ],
            hint: Text('現在の日付'),
            // 指定していないをisEmptyで指定できるかも
            value: _selectitem,
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _selectitem = value;
              });
            },
          ),
          //   ],
          //   )
          // ),
          // ],
          // )
          DropdownButton(
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
            },
          ),
          // Container(
          //   padding: EdgeInsets.only(right: 50),
          //   child: Text(
          //     '現在の日付',
          //     style: TextStyle(fontSize: 20),
          //   ),
          // ),
          // Text(
          //   '種目を選択',
          //   style: TextStyle(fontSize: 20),
          // ),
          Container(
            width: 150,
            child: TextFormField(
              style: TextStyle(fontSize: 50),
            ),
          ),
          Container(
            child: Text(
              '分',
              style: TextStyle(fontSize: 50),
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
            child: RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 40),
              color: Colors.red,
              child: Text('登録',style: TextStyle(fontSize: 30),),
              onPressed: () {
                // 送信の処理
              },
            ),
          ),
        ]),
      ),
    ]);
  }
  // @override
  // void initState(){
  //   //アプリ起動時に一度だけ実行される
  //    showDialog(
  //                 context: context,
  //                 builder: (BuildContext context) => AlertDialog(
  //                   title: Text(user_item[index] + 'を変更'),
  //                   content: TextField(
  //                     onChanged: (value) {
  //                       setState(() {
  //                         input = value;
  //                       });
  //                     },
  //                   ),
  //                   actions: [
  //                     TextButton(
  //                       onPressed: () {
  //                         Navigator.pop(context);
  //                       },
  //                       child: Text('キャンセル'),
  //                     ),
  //                     TextButton(
  //                       onPressed: () {
  //                         setState(() {
  //                           user[index] = input;
  //                         });
  //                         Navigator.pop(context);
  //                       },
  //                       child: Text('OK'),
  //                     ),
  //                   ],
  //                 ),
  //   ;
  // }
}
