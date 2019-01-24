import 'package:flutter/material.dart';

class FadeTransitionPageRoute extends PageRouteBuilder {
  FadeTransitionPageRoute(
      {Widget widget,
      Duration transitionDuration = const Duration(milliseconds: 500)})
      : super(
            transitionDuration: transitionDuration,
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: widget,
              );
            });
}
