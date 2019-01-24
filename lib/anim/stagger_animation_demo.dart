import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin{

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
  }

  _startAnimation() async {
    await _controller.forward().orCancel;
    await _controller.reverse().orCancel;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "StaggerAnimationDemo",
      home: Scaffold(
        appBar: AppBar(title: Text("StaggerAnimationDemo"),),
        body: Center(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _startAnimation();
            },
            child: Container(
              alignment: Alignment.center,
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(
                  color: Colors.black54,
                ),
              ),
              child: StaggerAnimationWidget(controller: _controller,),
            ),
          ),
        ),
      ),
    );
  }
}

class StaggerAnimationWidget extends StatelessWidget {

  StaggerAnimationWidget({Key key, this.controller}): super(key: key) {
    heightAnimation = Tween(begin: 0.0, end: 200.0).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.0, 0.6),
    ));
    colorAnimation = ColorTween(begin: Colors.green, end: Colors.cyan).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.0, 1.0),
    ));
    paddingAnimation = Tween<EdgeInsets>(begin: EdgeInsets.zero, end: EdgeInsets.only(left: 100)).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.6, 1.0),
    ));
  }

  final AnimationController controller;
  Animation<double> heightAnimation;
  Animation<Color> colorAnimation;
  Animation<EdgeInsets> paddingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) => Container(
        alignment: Alignment.topLeft,
        child: Container(
          width: heightAnimation.value,
          height: heightAnimation.value,
          decoration: BoxDecoration(
            color: colorAnimation.value,
          ),
        ),
        padding: paddingAnimation.value,
      ),
      animation: controller,
    );
  }

}
