import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(WaterDropletsDemo());

class WaterDropletsDemo extends StatefulWidget {
  @override
  _WaterDropletsDemoState createState() => _WaterDropletsDemoState();
}

class _WaterDropletsDemoState extends State<WaterDropletsDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  bool showAuxiliaryPaint;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    showAuxiliaryPaint = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("123"),
      ),
      backgroundColor: Colors.redAccent,
      floatingActionButton: FloatingActionButton(onPressed: () {
        if (_controller.status == AnimationStatus.completed)
          _controller.reverse();
        else if (_controller.status == AnimationStatus.dismissed)
          _controller.forward();
      }),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              showAuxiliaryPaint = !showAuxiliaryPaint;
            });
          },
          child: Container(
            width: 100,
            height: 300,
            child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size.infinite,
                    painter: WaterDroplets(
                        bigRadius: 40.0,
                        smallRadius: 10.0,
                        bottomOffset: _animation.value * 200,
                        strokeWidth: 2.0,
                        showAuxiliaryPaint: showAuxiliaryPaint),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class WaterDroplets extends CustomPainter {
  WaterDroplets(
      {@required this.bigRadius,
      this.smallRadius = 10.0,
      this.bottomOffset = 0.0,
      this.strokeWidth = 1.0,
      this.color = Colors.lightBlue,
      this.strokeColor = Colors.white,
      this.showAuxiliaryPaint = true})
      : assert(showAuxiliaryPaint != null);

  final double strokeWidth;
  final double bottomOffset;
  final double bigRadius;
  final double smallRadius;
  final Color color;
  final Color strokeColor;
  bool showAuxiliaryPaint;

  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()..isAntiAlias = true;
    // 背景
    _paint
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), _paint);
    // 开一个画布
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), _paint);
    // 大圆
//    final radius_big = min(size.height, size.width) / 2;
    _paint
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(size.width / 2, strokeWidth + bigRadius), bigRadius, _paint);
    _paint
      ..color = strokeColor
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(
        Offset(size.width / 2, strokeWidth + bigRadius), bigRadius, _paint);

    // 两圆相差多少
    double distance = max(0.0, bottomOffset - smallRadius);
    // 两圆相差多少时分离
    double separationValue = smallRadius * 3;
    double c = min(1.0, distance / separationValue) * smallRadius;
    Point p1 = Point(size.width / 2 - smallRadius + c, bigRadius * 2);
    Point p2 =
        Point(size.width / 2, bigRadius * 2 + bottomOffset / 2 - smallRadius);
    Point p3 = Point(size.width / 2 - smallRadius,
        bigRadius * 2 + bottomOffset - smallRadius);
    Point p4 = Point(size.width / 2 + smallRadius,
        bigRadius * 2 + bottomOffset - smallRadius);
    Point p5 = Point(size.width / 2 + smallRadius - c, bigRadius * 2);

    if (bottomOffset > 0) {
      // 水滴
      if (bottomOffset > smallRadius * 2) {
        if (c < smallRadius) {
          _paint
            ..color = color
            ..style = PaintingStyle.fill
            ..blendMode = BlendMode.srcOut;
          Path path = Path();
          path.moveTo(p1.x, p1.y);
          path.quadraticBezierTo(p2.x, p2.y, p3.x, p3.y);
          path.lineTo(p4.x, p4.y);
          path.quadraticBezierTo(p2.x, p2.y, p5.x, p5.y);
          canvas.drawPath(path, _paint);

          _paint
            ..color = strokeColor
            ..style = PaintingStyle.stroke
            ..blendMode = BlendMode.srcOver;
          Path leftPath = Path();
          leftPath.moveTo(p1.x, p1.y + strokeWidth / 2);
          leftPath.quadraticBezierTo(
              p2.x, p2.y + strokeWidth / 2, p3.x, p3.y + strokeWidth / 2);
          canvas.drawPath(leftPath, _paint);
          Path rightPath = Path();
          rightPath.moveTo(p4.x, p4.y + strokeWidth / 2);
          rightPath.quadraticBezierTo(
              p2.x, p2.y + strokeWidth / 2, p5.x, p5.y + strokeWidth / 2);
          canvas.drawPath(rightPath, _paint);
        }
      }
//       小圆
      // 开一个画布
      canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), _paint);
      // 保存现在画布
      canvas.restore();
      _paint
        ..color = color
        ..style = PaintingStyle.fill
        ..blendMode = BlendMode.srcOver;
      canvas.drawCircle(
          Offset(size.width / 2,
              (strokeWidth + bigRadius) * 2 - smallRadius + bottomOffset),
          smallRadius + strokeWidth / 2,
          _paint);
      // 开一个画布
      canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), _paint);
      // 保存现在画布
      canvas.restore();
      _paint
        ..color = strokeColor
        ..style = PaintingStyle.stroke
        ..blendMode = BlendMode.dstOver;
      canvas.drawCircle(
          Offset(size.width / 2,
              (strokeWidth + bigRadius) * 2 - smallRadius + bottomOffset),
          smallRadius + strokeWidth,
          _paint);
    }

    //控制辅助点绘制
    if (showAuxiliaryPaint) {
      _paint
        ..color = Colors.redAccent
        ..style = PaintingStyle.fill
        ..blendMode = BlendMode.srcOver;
      canvas.drawCircle(Offset(p1.x, p1.y), 1, _paint);
      canvas.drawCircle(Offset(p2.x, p2.y), 1, _paint);
      canvas.drawCircle(Offset(p3.x, p3.y), 1, _paint);
      canvas.drawCircle(Offset(p4.x, p4.y), 1, _paint);
      canvas.drawCircle(Offset(p5.x, p5.y), 1, _paint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
