import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TurnBoxDemo",
      home: BaseStatefulWidget(
        child: Home(),
      ),
    );
  }
}

class BaseStatefulWidget extends StatefulWidget {

  const BaseStatefulWidget({Key key, this.child}): super(key: key);

  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return _BaseStatefulWidgetState();
  }

}

class _BaseStatefulWidgetState extends State<BaseStatefulWidget> with SingleTickerProviderStateMixin{

  ToastController _controller;
  String _toastMessage;

  @override
  void initState() {
    super.initState();
    _toastMessage = "哈哈哈";
    _controller = ToastController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<BaseNotification>(
      onNotification: (BaseNotification notification) {
        switch (notification.runtimeType) {
          case ToastNotification:
            if (_controller.toastState == ToastControllerState.isHide) {
              setState(() {
                _toastMessage = (notification as ToastNotification).toast;
                _controller.showToastAnimation((notification as ToastNotification).duration);
              });
            }
            // 阻止冒泡传递
            return true;
        }
        return false;
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          widget.child,
          Positioned(
            bottom: 20.0,
            child: ToastWidget(
              controller: _controller,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                child: DefaultTextStyle(
                  style: TextStyle(),
                  child: Text(_toastMessage ?? "",),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.toastAnimationController.dispose();
  }
}

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ToastDemo"),),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    ToastNotification("一下").dispatch(context);
                  },
                  child: Text("吐司一下"),
                ),
                RaisedButton(
                  onPressed: () {
                    ToastNotification(
                      "两下",
                      duration: const Duration(seconds: 5),
                    ).dispatch(context);
                  },
                  child: Text("吐司两下"),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 20.0,
            child: RaisedButton(
              onPressed: () {},
              child: Text("测试触摸"),
            ),
          )
        ],
      ),
    );
  }
}

class ToastWidget extends StatelessWidget {
  ToastWidget({this.child, this.controller});

  final Widget child;
  final ToastController controller;

  @override
  Widget build(BuildContext context) {
    if (controller == null)
      return IgnorePointer(child: child);
    return AnimatedBuilder(
      animation: controller.toastAnimationController,
      builder: (BuildContext context, Widget w) => Opacity(
        opacity: controller.getToastOpacity(),
        child: IgnorePointer(
          child: child,
        ),
      ),
    );
  }

}

enum ToastControllerState {
  inShow, // 正在显示
  inHide, // 正在消失
  isHide  // 已经消失
}
class ToastController {

  ToastController({@required TickerProvider vsync}) {
    toastAnimationController = AnimationController(
        duration: Duration(milliseconds: 300),
        vsync: vsync
    )..addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        toastAnimationController.reset();
      }
    });
    _toastAnimation = Tween(begin: 1.0, end: 0.0).animate(toastAnimationController);
  }

  // 0:正在显示 1:正在消失 2:已经消失
  ToastControllerState toastState = ToastControllerState.isHide;
  AnimationController toastAnimationController;
  Animation<double> _toastAnimation;

  showToastAnimation(Duration duration) async {
    toastState = ToastControllerState.inShow;
    await Future.delayed(duration);
    toastState = ToastControllerState.inHide;
    toastAnimationController.forward().then((v) {
      toastState = ToastControllerState.isHide;
    });
  }

  double getToastOpacity() {
    if (toastState == ToastControllerState.inShow)
      return 1.0;
    else if (toastState == ToastControllerState.inHide)
      return _toastAnimation.value;
    return 0.0;
  }

}

class ToastNotification extends BaseNotification {
  ToastNotification(this.toast, {this.duration = const Duration(milliseconds: 2000)}):
        assert (toast != null && toast.isNotEmpty);
  final String toast;
  final Duration duration;
}

class BaseNotification extends Notification {}