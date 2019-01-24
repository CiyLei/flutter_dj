import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TurnBoxDemo",
      home: TurnBoxWidgetTest(),
    );
  }
}

class TurnBoxWidget extends StatefulWidget {

  TurnBoxWidget({Key key, this.turns, this.speed, this.child}): super(key: key);

  double turns;
  int speed;
  Widget child;

  @override
  State<StatefulWidget> createState() {
    return _TurnBoxWidgetState();
  }

}

class _TurnBoxWidgetState extends State<TurnBoxWidget> with SingleTickerProviderStateMixin{

  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this
    );
  }

  @override
  void didUpdateWidget(TurnBoxWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turns != this.widget.turns) {
      _controller.animateTo(
        widget.turns,
        duration: Duration(milliseconds: widget.speed),
        curve: Curves.easeOut
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }
}

class TurnBoxWidgetTest extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _TurnBoxWidgetTestState();
  }
}

class _TurnBoxWidgetTestState extends State<TurnBoxWidgetTest> {

  double turns = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TurnBoxWidgetTest'),),
      body: Center(
        child: Column(
          children: <Widget>[
            TurnBoxWidget(
              turns: turns,
              speed: 2000,
              child: Icon(
                Icons.refresh,
                size: 100,
              ),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  turns += 0.5;
                });
              },
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  turns -= 0.5;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}