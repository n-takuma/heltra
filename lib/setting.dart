
import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:heltra/main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Setting extends StatefulWidget{
  @override
  _SettingState createState() => _SettingState();
}
class _SettingState extends State<Setting> {

  List _jsonList = [];
  String name = "";

  List _user = [];

  @override
  void initState() {
    super.initState();

    _request();
  }

  Future<void> _request() async {
    String url = 'http://163.44.255.164:3000/api/users/getUser';
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({
      'ID': "Pi",
    });

    http.Response resp = await http.post(Uri.parse(url), headers: headers, body: body);

    // GETãæãã
    // var resp = await http.get(Uri.http(
    //     '163.44.255.164:3000',
    //     '/api/users/getUser',
    //     ));
    // if (resp.statusCode != 200) {
    //   setState(() {
    //     int statusCode = resp.statusCode;
    //     // _content = "Failed to get $statusCode";
    //   });
    //   return;
    // }
    print(resp);
    setState(() {
      var jsonResponse = jsonDecode(resp.body);
      print(jsonResponse);
      _jsonList = jsonResponse['Details'];
      name = _jsonList[0]["Name"];
      // title = _jsonList[0]["Name"];
      _user.insert(0, _jsonList[0]['ID']);
      _user.insert(1, _jsonList[0]['Name']);
      _user.insert(2, _jsonList[0]['Birthdate']);
      _user.insert(3, _jsonList[0]['Sex']);
      _user.insert(4, _jsonList[0]['Height'].toString());
      _user.insert(5, _jsonList[0]['Weight'].toString());
      _user.insert(6, _jsonList[0]['Objective'].toString());
    });
  }

  String consumption = "";

  //  put
  void _put_request() async {
    String url = 'http://163.44.255.164:3000/api/users/editUser';
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({
      'ID': _user[0],
      'Name': _user[1],
      'Birthdate': _user[2],
      'Sex': _user[3],
      'Height': _user[4],
      'Weight': _user[5],
      'Objective': consumption,
      'Password':"aaaaa",
      'NPassword': "aaaaa",
      });

    http.Response resp = await http.put(Uri.parse(url), headers: headers, body: body);
    if (resp.statusCode != 200) {
      setState(() {
        int statusCode = resp.statusCode;
        print("Failed to put $statusCode");
      });
      return;
    }
    setState(() {
      print(resp.body);
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
                      name + "ãã",
                      style: TextStyle(
                        fontSize: 40
                        ),
                      ),
                  ),
                  // Padding(padding: EdgeInsets.only(right: 450)),
                  ElevatedButton (
                    child: Text(
                      'ã­ã°ã¢ã¦ã',
                      style: TextStyle(
                        fontSize: 20 
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage(),
                        )
                      );
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
                            'ç®æ¨',
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
                                  'æ¶è²»ã«ã­ãªã¼',
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
                                  // æ¶è²»ã«ã­ãªã¼å¥å
                                  onChanged: (String value) {
                                    setState(() {
                                      consumption = value;
                                    });
                                  },
                                ),
                              ),
                              ElevatedButton(
                                child: Text('éä¿¡'),
                                onPressed: () {
                                  // éä¿¡ã®å¦ç
                                  _put_request();
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
                          child: Text('åºæ¬ãã¼ã¿ç·¨é'),
                          onPressed: () {
                            //åºæ¬ãã¼ã¿ç·¨éãæ¼ããã¨ãã®å¦ç
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
                          child: Text('ç¨®ç®ãè¿½å ã»ç·¨é'),
                          onPressed: () {
                            // ç¨®ç®ãè¿½å ã»ç·¨éãæ¼ããã¨ãã®å¦ç
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
  List _user = ["", "", "", "", "", "","",""];
  // List parameter = ["Birthdate","ConsumptedC","ID","Name","Sex"];
  // List parameter = ["ID", "Name", "Birthdate", "Sex", "Height", "Weight", "Objective", "Password"]

  List<String> user_item = ['ID','åå','èªçæ¥','æ§å¥','èº«é·','ä½é','ç®æ¨æ¶è²»ã«ã­ãªã¼','ãã¹ã¯ã¼ã'];
  // List user = ['Pi','ASDF','2002-1-2','ç·',100, 50, 100, '**********'];

  
  @override
  void initState() {
    super.initState();

    print("testtest");
    _request();
  }

  // get 
  Future<void> _request() async {
    String url = 'http://163.44.255.164:3000/api/users/getUser';
    Map<String, String> headers = {'content-type': 'application/json'};
    String body = json.encode({
      'ID': "Pi",
    });

    http.Response resp = await http.post(Uri.parse(url), headers: headers, body: body);
    // GETãæãã
    // var resp = await http.get(Uri.http(
    //     '163.44.255.164:3000',
    //     '/api/users/getUser',
    //     ));
    // if (resp.statusCode != 200) {
    //   setState(() {
    //     int statusCode = resp.statusCode;
    //     // _content = "Failed to get $statusCode";
    //   });
    //   return;
    // }
    print(resp);
    String sex = 'ç·';
    setState(() {
      var jsonResponse = jsonDecode(resp.body);
      print(resp.body);
      _jsonList = jsonResponse['Details'];
      _user.insert(0, _jsonList[0]['ID']);
      _user.insert(1, _jsonList[0]['Name']);
      DateTime date = DateTime.fromMicrosecondsSinceEpoch(_jsonList[0]['Birthdate']);
      String time = DateFormat("yyyyå¹´MMæddæ¥").format(date).toString();
      _user.insert(2, time);
      if ( _jsonList[0]['Sex'] == 1 ) {
        sex = 'ç·æ§';
      } else if( _jsonList[0]['Sex'] == 1 ) {
        sex = 'å¥³æ§';
      } else {
        sex = 'ãã®ä»';
      }
      _user.insert(3, sex);
      _user.insert(4, _jsonList[0]['Height'].toString() + 'cm');
      _user.insert(5, _jsonList[0]['Weight'].toString() + 'kg');
      _user.insert(6, _jsonList[0]['Objective'].toString() + 'kcal');
    });
  }

  void _put_request() async {
  String url = 'http://163.44.255.164:3000/api/users/editUser';
  Map<String, String> headers = {'content-type': 'application/json'};
  String body = json.encode({
    'ID': _user[0],
    'Name': _user[1],
    'Birthdate': _user[2],
    'Sex': _user[3],
    'Height': _user[4],
    'Weight': _user[5],
    'Objective': _user[6],
    'Password':"ââââââââââ",
    // 'NPassword': _user[7],
    'NPassword': "ââââââââââ",
    });

  http.Response resp = await http.put(Uri.parse(url), headers: headers, body: body);
  if (resp.statusCode != 200) {
    setState(() {
      int statusCode = resp.statusCode;
      print("Failed to put $statusCode");
    });
    return;
  }
  setState(() {
    print(resp.body);
  });
}

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String input = '';
    
    return Scaffold(
      appBar: AppBar(title: Text('åºæ¬ãã¼ã¿å¥å')),
      body: Container(
        width: double.infinity,
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text(user_item[index]),
              title: Text(_user[index].toString()),
              onTap: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(user_item[index] + 'ãå¤æ´'),
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
                        child: Text('ã­ã£ã³ã»ã«'),
                      ),
                      TextButton(
                        onPressed: () {
                          _put_request();
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

// ãªã¹ãä¸è¦§ç»é¢ç¨Widget
class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {

  List _jsonList = [];
  List training_name = [];
  List training_calorie = [];
  List training_id = [];

  @override
  void initState() {
    super.initState();
    _request_train();
  }

  Future<void> _request_train() async {
    // GETãæãã
    var resp = await http.get(Uri.http(
        '163.44.255.164:3000',
        '/api/customeTR/',
        // '/api/training/',
        ));
    print(resp);
    print(resp.statusCode);
    if (resp.statusCode != 200) {
      setState(() {
        int statusCode = resp.statusCode;
        // _content = "Failed to get $statusCode";
      });
      return;
    }
    setState(() {
      print(resp.body);
      var jsonResponse = jsonDecode(resp.body);
      _jsonList = jsonResponse['Details'];
      for(var i = 0; i < _jsonList.length; i++ ) {
        training_name.add(_jsonList[i]["Name"]);
        training_calorie.add(_jsonList[i]["ConsumptingC"]);
        training_id.add(_jsonList[i]["ID"]);
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

  void _delete_train(int id) async {

    http.Response resp = await http.delete(Uri.parse('http://163.44.255.164:3000/api/training/delete/$id'));
    if (resp.statusCode != 200) {
      setState(() {
        int statusCode = resp.statusCode;
        // _content = "Failed to delete $statusCode";
      });
      return;
    }
    setState(() {
      print(resp.body);
    });
  }

  // Todoãªã¹ãã®ãã¼ã¿
  // List<String> todoList = ['è¹ç­','èç­'];
  // List<int> calorie = [20, 30];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // AppBarãè¡¨ç¤ºããã¿ã¤ãã«ãè¨­å®
      appBar: AppBar(
        title: Text('ãªã¹ãä¸è¦§'),
      ),
      // ãã¼ã¿ãåã«ListViewãä½æ
      body: ListView.builder(
        itemCount: training_name.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(training_name[index] + ' ï¼ '+ training_calorie[index].toString() + "Kcal"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('ç¨®ç®ãå¤æ´'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'ç¨®ç®åãå¥åãã¦ãã ãã',
                          ),
                          onChanged: (value) {
                            setState(() {
                              change_todo = value;
                            });
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'ç¨®ç®ã®ã«ã­ãªã¼ãå¥åãã¦ãã ãã',
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
                            _delete_train(training_id[index]);
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          'åé¤',
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
                        child: Text('ã­ã£ã³ã»ã«'),
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
              title: Text('ç¨®ç®ãè¿½å '),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'ç¨®ç®ãå¥åãã¦ãã ãã',
                    ),
                    onChanged: (value) {
                      setState(() {
                        input_todo = value;
                      });
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'ç¨®ç®ã®ã«ã­ãªã¼ãå¥åãã¦ãã ãã',
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
                  child: Text('ã­ã£ã³ã»ã«'),
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