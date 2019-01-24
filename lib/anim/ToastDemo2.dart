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
  // 0:点击显示 1:正在消失 2:已经消失
  int _toastState = 2;
  AnimationController _toastController;
  Animation<double> _toastAnimation;

  @override
  void initState() {
    super.initState();
    _toastController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this
    )..addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        _toastController.reset();
      }
    });
    _toastAnimation = Tween(begin: 1.0, end: 0.0).animate(_toastController);
  }

  _showToast(String msg) async {
    if (_toastState == 2) {
      setState(() {
        _toastState = 0;
        _toastMessage = msg;
      });
      await Future.delayed(Duration(milliseconds: 2000));
      _toastState = 1;
      _toastController.forward().then((v) {
        setState(() {
          _toastState = 2;
        });
      });
    }
  }

  double _getToastOpacity() {
    if (_toastState == 0)
      return 1.0;
    else if (_toastState == 1)
      return _toastAnimation.value;
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ToastNotification>(
      onNotification: (ToastNotification notification) {
        _showToast(notification.toastMessage);
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
                opacity: _getToastOpacity(),
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