import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: AnimactionImageDemo(),
      ),
    );
  }

}

class AnimactionImageDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AnimactionImageDemoState();
  }
}

class _AnimactionImageDemoState extends State<AnimactionImageDemo> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animation = Tween(
        begin: 100.0,
        end: 300.0
    ).animate(_controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          AnimactionImageWidget(animation: _animation,),
          RaisedButton(
            onPressed: () {
              _controller.forward();
            },
          ),
          RaisedButton(
            onPressed: () {
              setState(() { });
            },
          ),
        ],
      ),
    );
  }
}

class AnimactionImageWidget extends AnimatedWidget {

  AnimactionImageWidget({Key key, Animation<double> animation}) :
      super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "http://wx2.sinaimg.cn/mw690/00747wQSgy1fw0lglarzuj30f008wqd5.jpg",
      width: (listenable as Animation<double>).value,
      height: (listenable as Animation<double>).value,
    );
  }
}