import 'package:flutter/material.dart';

void main() => runApp(TestDemo());

class TestDemo extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _TestDemoState();
  }
}

class _TestDemoState extends State<TestDemo> {

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FileDemo",
      home: Scaffold(
        appBar: AppBar(title: Text("FileDemo"),),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("$count"),
              TestDemo2()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
        ),
      ),
    );
  }
}

class TestDemo2 extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _TestDemoState2();
  }

}

class _TestDemoState2 extends State<TestDemo2> {

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("$count"),
          RaisedButton(
            onPressed: () {
              setState(() {
                count++;
              });
            },
          )
        ],
      ),
    );
  }
}