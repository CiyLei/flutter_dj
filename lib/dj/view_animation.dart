import 'package:flutter/material.dart';

class AnimatedOpacityTranslation extends StatefulWidget{

  AnimatedOpacityTranslation({@required this.widget, this.duration = const Duration(milliseconds: 600), this.type = 0});

  Duration duration;
  Widget widget;
  int type;

  @override
  State<StatefulWidget> createState() {
    return _AnimatedOpacityTranslationState();
  }
}

class _AnimatedOpacityTranslationState extends State<AnimatedOpacityTranslation> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation<double> _opacity;
  Animation<double> _translation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration
    );

    _opacity = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _translation = Tween(begin: (100.0), end: 0.0).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.translate(
            offset: widget.type == 0 ? Offset(_translation.value, 0) : Offset(0, _translation.value),
            child: widget.widget,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}