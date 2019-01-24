import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TurnBoxDemo",
      home: BaseViewWidget(
        child: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ToastDemo"),),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                ToastNotification("吐司一下").dispatch(context);
              },
              child: Text("吐司一下"),
            ),
            RaisedButton(
              onPressed: () {
                ToastNotification("吐司两下").dispatch(context);
              },
              child: Text("吐司两下"),
            )
          ],
        ),
      ),
    );
  }
}

class BaseViewWidget extends StatefulWidget {

  const BaseViewWidget({Key key, this.child}): super(key: key);

  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return _BaseViewWidgetState();
  }

}

class _BaseViewWidgetState extends State<BaseViewWidget> with SingleTickerProviderStateMixin{

  String _toastMessage = "";
  AnimationController _toastController;
  Animation<double> _toastAnimation;

  @override
  void initState() {
    super.initState();
    _toastController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this
    );
    _toastController.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        _toastController.reset();
      }
    });
    _toastAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _toastController,
        curve: Interval(0.9, 1)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ToastNotification>(
      onNotification: (ToastNotification notification) {
        if (_toastController.status == AnimationStatus.forward)
          return;
        _toastMessage = notification.toastMessage;
        _toastController.forward();
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          widget.child,
          Positioned(
            bottom: 20.0,
            child: AnimatedBuilder(
              animation: _toastController,
              builder: (BuildContext context, Widget child) => Opacity(
                opacity: _toastAnimation.status == AnimationStatus.dismissed ? 0 : _toastAnimation.value,
                child: IgnorePointer(
                  child: ToastWidget(_toastMessage),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ToastWidget extends StatelessWidget {
  ToastWidget(this.message);

  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      child: DefaultTextStyle(
        style: TextStyle(),
        child: Text(message,),
      ),
    );
  }

}

class ToastNotification extends Notification {
  ToastNotification(this.toastMessage);
  final String toastMessage;
}