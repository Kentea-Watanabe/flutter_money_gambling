import 'dart:math' as math;

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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        '/result': (BuildContext context) => new ResultPage(),
      },
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
  int _counter = 1;
  var _text = '';
  var String_count = "hoge";
  final _editController = TextEditingController();
  void _incrementCounter() {
    setState(() {
      var random = math.Random();
      // 0になったら永遠と0円
      // if (_counter == 0) {
      //   _counter = 1;
      // }
      _counter *= random.nextInt(10);
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
            Text(
              'Write your name and click UP.',
              style: TextStyle(
                fontSize: 44,
                height: 2,
              ),
            ),
            new TextField(
              controller: _editController,
              decoration: InputDecoration(
                hintText: 'please give me a nickname',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            Text(
              '所持金 : $_counter円',
              style: Theme.of(context).textTheme.headline4,
            ),
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: Text('UP'),
            ),
            TextButton(
              onPressed: () {
                // 入力フォームの値を取得
                _text = _editController.text;
                // int型を文字型に変換
                String String_count = _counter.toString();
                // 結果表示のため、result_val = ニックネーム, 所持金とする
                var result_val = "$_text , $String_count";
                // 所持金を初期化
                _counter = 1;
                // 入力フォームを初期化
                _editController.clear();
                Navigator.of(context)
                    .pushNamed('/result', arguments: result_val);
              },
              child: Text(
                'END',
                style: TextStyle(
                  fontSize: 44,
                  height: 1.5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

var get_result = <String>[];

class ResultPage extends StatelessWidget {
  int result = 9999;
  String name = "hoge";
  Object? args;
  @override
  Widget build(BuildContext context) {
    if (args == null) {
      args = ModalRoute.of(context)!.settings.arguments;
      // result = args as int; //Object型なので型を指定する
      // list.add(result);
      name = args as String; //Object型なので型を指定する
      get_result.add(name);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // for (final list_ in list)
            for (final result_ in get_result)
              Text(
                '$result_円',
                style: Theme.of(context).textTheme.headline4,
              ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Go Back Home'),
            )
          ],
        ),
      ),
    );
  }
}
