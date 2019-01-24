import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(Test());

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AnimationRouteDemo",
      home: Test2(),
    );
  }
}

class Test2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: Text("AnimationRouteDemo"),
      ),
      body: Center(child: Text("123"),),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (c) => MyApp()));
      }),
    );
  }
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Text("AnimationRouteDemo"),
      ),
      body: AnimationRouteDemo(),
    );
  }
}

class AnimationRouteDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimationRouteDemoState();
  }
}

class _AnimationRouteDemoState extends State<AnimationRouteDemo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
//          Navigator.of(context).push(PageRouteBuilder(
//              transitionDuration: const Duration(seconds: 2),
//              pageBuilder: (context, animation, animation2) => FadeTransition(
//                opacity: animation,
//                child: AnimationRouteDemo2(),
//              )
//          ));
//          Navigator.of(context).push(CupertinoPageRoute(builder: (context) => AnimationRouteDemo2()));

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AnimationRouteDemo2(),
              ));
            },
          ),
          Hero(
            tag: "CircleAvatar",
            child: CircleAvatar(
              child: Text("A"),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimationRouteDemo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text("AnimationRouteDemo2"),
      ),
      body: Column(
        children: <Widget>[
          Text('AnimationRouteDemo2'),
          Hero(
            tag: "CircleAvatar",
            child: CircleAvatar(
              child: Text('A'),
            ),
          ),
        ],
      ),
    );
  }
}
