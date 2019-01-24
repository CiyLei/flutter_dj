import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:ui' as ui show ImageFilter, Gradient, Image;

class SectionWidget extends StatefulWidget {

  SectionWidget({@required this.backgroupImage, this.progress = 1.0, this.color, this.bottomOffsetY})
      : assert(() {
    if (progress < 1.0 && color == null)
      return false;
    return true;
  }());

  double progress;
  double bottomOffsetY;
  Color color;
  ui.Image backgroupImage;

  @override
  _SectionWidgetState createState() => _SectionWidgetState();
}

class _SectionWidgetState extends State<SectionWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.progress == 1.0 ? Text("") : CustomPaint(
      size: Size.infinite,
      painter: SectionPainter(
        backgroupImage: widget.backgroupImage,
        progress: widget.progress,
        color: widget.color,
        bottomOffsetY: widget.bottomOffsetY
      ),
    );
  }
}

class SectionPainter extends CustomPainter {

  SectionPainter({this.backgroupImage, this.progress, this.color, this.bottomOffsetY});

  double progress;
  Color color;
  ui.Image backgroupImage;
  double bottomOffsetY;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..color = color;
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    canvas.drawImage(backgroupImage, Offset.zero, paint);
    paint.blendMode = BlendMode.dstOut;
    paint.color = Colors.amberAccent;
    double c_size = progress * sqrt(size.width * size.width + size.height * size.height);
    canvas.drawCircle(Offset(size.width / 2, size.height - bottomOffsetY), c_size, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}