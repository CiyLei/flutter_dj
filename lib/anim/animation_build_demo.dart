import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: AnimationBuildDemo(),
      ),
    );
  }

}

class AnimationBulidWidget extends StatelessWidget {

  AnimationBulidWidget({this.child, this.animation});

  Widget child;
  Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      child: child,
      animation: animation,
      builder: (context, child) => Container(
        width: animation.value,
        height: animation.value,
        child: child,
      ),
    );
  }
}

class AnimationBuildDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimationBuildDemoState();
  }
}

class _AnimationBuildDemoState extends State<AnimationBuildDemo> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
    );
    _animation = Tween(begin: 100.0, end: 400.0).animate(_controller)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed)
          _controller.reverse();
        else if (state == AnimationStatus.dismissed)
          _controller.forward();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          AnimationBulidWidget(
            child: Image.network('http://wx2.sinaimg.cn/mw690/00747wQSgy1fw0lglarzuj30f008wqd5.jpg'),
            animation: _animation,
          ),
          RaisedButton(
            onPressed: () {
              _controller.forward();
            },
          )
        ],
      ),
    );
  }
}