import 'package:flutter/material.dart';

class AnimationItemScale extends StatefulWidget {
  AnimationItemScale({@required this.widget});

  Widget widget;
  @override
  _AnimationItemScaleState createState() => _AnimationItemScaleState();

}

class _AnimationItemScaleState extends State<AnimationItemScale> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _scale = Tween(begin: 1.0, end: 0.95).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        _controller.forward();
      },
      onPointerUp: (event) {
        _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Transform.scale(
            scale: _scale.value,
            child: widget.widget,
          );
        },
      ),
    );
  }
}
