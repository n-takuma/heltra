
import 'package:flutter/material.dart';

Widget PreviousData(BuildContext context) {
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
  return Column(
    children: [
    Container(
      width: size.width,
      padding: EdgeInsets.only(top: 100),
      // alignment: Alignment.centerRight,
      // 画面幅を取って、カラムの画面幅を常にその画面幅にする

      // ドロップダウンはループのマップ

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // padding:EdgeInsets.only(top: 100),
        children: [
        Container(
          // padding: EdgeInsets.only(top: 100),
          child: Text(
            '達成度',
            style: TextStyle(fontSize: 50),
          ),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton(
              items: [
                for(final item in data)
                DropdownMenuItem(
                  child: Text(item),
                  value: item,
                  ),
              ],
              hint: Text('現在の日付'),
              onChanged: (Object? value) {
                print(value);
              },
            ),
            DropdownButton(
              items: [
                for(final item in example)
                DropdownMenuItem(
                  child: Text(item),
                  value: item,
                  ),
              ],
              hint: Text('種目を選択'),
              onChanged: (Object? value) {
                
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
            child: Text(
              // textfieldでtextarea的なことができる

              '～分',
              style: TextStyle(fontSize: 50),
            ),
          ),
        ]),
      ),
      Container(
        width: size.width,
        padding: EdgeInsets.only(top: 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          Container(
            margin: EdgeInsets.only(right: 30),
            padding: EdgeInsets.symmetric(horizontal: 40),
            color: Colors.red,
            child: Text(
              '登録',
              style: TextStyle(fontSize: 30),
            ),
          )
        ]),
      ),
  ]);
}



// class TopPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(children: [
//         ConstrainedBox(
//           constraints: BoxConstraints(
//             maxWidth: 1000,
//           ),
//           child: Container(
//             padding: EdgeInsets.only(top: 100, left: 100, right: 100),
//             // alignment: Alignment.centerRight,
//             child: Row(
//               children: [
//               Container(
//                 padding: EdgeInsets.only(right: 300),
//                 child: Text(
//                   '達成度',
//                   style: TextStyle(fontSize: 50),
//                 ),
//               ),
//               Container(
//                 child: Column(
//                   children:[
//                     Container(  
//                 child: Text(
//                   '今日の消費カロリー',
//                   style: TextStyle(fontSize: 35),
//                 ),
//               ),
//               Container(
//                 child: Text(
//                   '600Kcal',style: TextStyle(fontSize: 50),
//                 ),
//               )
//                 ]
//                 ),
//               )
//             ]),
//           ),
//         ),
//         ConstrainedBox(
//           constraints: BoxConstraints(
//             maxWidth: 1000,
//           ),
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 100, vertical: 100),
//             child: Row(children: [
//               Container(
//                 padding: EdgeInsets.only(right: 50),
//                 child: Text(
//                   '現在の日付',
//                   style: TextStyle(fontSize: 20),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.only(right: 250),
//                 child: Text(
//                   '種目を選択',
//                   style: TextStyle(fontSize: 20),
//                 ),
//               ),
//               Container(
//                 child: Text(
//                   '～分',
//                   style: TextStyle(fontSize: 50),
//                 ),
//               )
//             ]),
//           ),
//         ),
//         ConstrainedBox(
//           constraints: BoxConstraints(
//             maxWidth: 1000,
//           ),
//           child: Container(
//             child: Row(children: [
//               Container(
//                 margin: EdgeInsets.only(left: 800),
//                 padding: EdgeInsets.symmetric(horizontal: 40),
//                 color: Colors.red,
//                 child: Text('登録',style: TextStyle(fontSize: 30),),
//               )
//             ]),
//           ),
//         ),
//       ]),
//     );
//   }
// }