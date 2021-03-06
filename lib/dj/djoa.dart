import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_demo/anim/water_droplets_anim2.dart';
import 'package:flutter_app_demo/dj/CircleClipper.dart';
import 'package:flutter_app_demo/dj/spring_curve.dart';
import 'home.dart';

void main() {
  runApp(DJOA());
}

class DJOA extends StatefulWidget {
  @override
  _DJOAState createState() => _DJOAState();
}

class _DJOAState extends State<DJOA> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OA测试",
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  GlobalKey _loginKey = GlobalKey();
  GlobalKey _backKey = GlobalKey();
  AnimationController _loginControll;
  Animation<double> _widthAnimation;
  Animation<double> _transparentAnimation;
  Animation<double> _pointAnimation;

  Home _home;
  double _pointOffY;

  @override
  void initState() {
    super.initState();
    _home = Home();
    _loginControll =
        AnimationController(vsync: this, duration: Duration(seconds: 4))
          ..addStatusListener((AnimationStatus statu) {
            if (statu == AnimationStatus.completed) {
              openHomePage();
            }
          });
  }

  openHomePage() async {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 2000),
        pageBuilder: (buildContext, animation1, animation2) {
          return AnimatedBuilder(
            animation: animation1,
              builder: (bulidContext, child) => ClipOval(
                clipper: CircleClipper(
                  bottomOffsetY: (55.0 + max(0.0, MediaQuery.of(context).padding.bottom - 10.0)),
                  progress: animation1.value < 0.3 ? 0.0 : ((animation1.value - 0.3) / (1.0 - 0.3)),
                ),
                child: _home,
              ),
          );
        }));
    await Future.delayed(const Duration(milliseconds: 2500));
    _loginControll.reset();
  }

  void initAnimation(double pointOffY) {
    this._pointOffY = pointOffY;
    _widthAnimation = Tween(begin: window.physicalSize.width, end: (50.0))
        .animate(CurvedAnimation(
            parent: _loginControll,
            curve: Interval(0, 0.3, curve: SpringCurve(tension: 0.7))));
    _transparentAnimation = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _loginControll, curve: Interval(0.1, 0.2)));
    _pointAnimation = Tween(begin: 0.0, end: pointOffY).animate(CurvedAnimation(
        parent: _loginControll, curve: Interval(0.30, 1.0, curve: Curves.ease)));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          hintColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white, fontSize: 12),
            border: InputBorder.none,
          )),
      child: RepaintBoundary(
        key: _backKey,
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 80, bottom: 40),
                    child: _buildLogo(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: _buildUserField(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 70),
                    child: _buildPassField(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: AnimatedBuilder(
                      animation: _loginControll,
                      builder: (builderContext, childWidget) {
                        return Stack(
                          children: <Widget>[
                            Center(
                              child: buildLoginAnim(context),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 15, right: 15, top: 65),
                              child: _buildVerificationCodeForgetPassword(),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginAnim(BuildContext context) {
    return (_pointAnimation == null ? 0 : _pointAnimation.value) > 0
        ? CustomPaint(
            size: Size(52.0, _pointOffY + 60.0),
            painter: WaterDroplets(
                color: Theme.of(context).primaryColor,
                bigRadius: 25.0,
                smallRadius: 5.0,
                bottomOffset: _pointAnimation.value,
                strokeWidth: 1.0,
                showAuxiliaryPaint: false),
          )
        : _buildLogin(
            context,
            _widthAnimation == null ? double.infinity : _widthAnimation.value,
            _transparentAnimation == null ? 1 : _transparentAnimation.value);
  }

  SizedBox _buildLogin(
      BuildContext context, double loginWidth, double transparent) {
    return SizedBox(
      width: loginWidth,
      height: 50,
      child: Material(
        key: _loginKey,
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            final y = _loginKey.currentContext
                .findRenderObject()
                .getTransformTo(null)
                .getTranslation()
                .y;
            // 屏幕高度 - 登陆按钮的屏幕位置 - 登陆按钮的高度 - 扩展按钮的底部padding
            initAnimation(MediaQuery.of(context).size.height -
                y -
                50 -
                55 -
                max(0.0, MediaQuery.of(context).padding.bottom - 10.0));
            _loginControll.forward();
          },
          borderRadius: BorderRadius.all(Radius.circular(25)),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Center(
              child: Opacity(
                opacity: transparent,
                child: Text(
                  "登录",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildPoint(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2.0),
      ),
    );
  }

  Row _buildVerificationCodeForgetPassword() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            "验证码登录",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        Expanded(
          child: Text(
            "忘记密码",
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }

  DecoratedBox _buildPassField() {
    return DecoratedBox(
      decoration: BoxDecoration(
          border: BorderDirectional(
              bottom: BorderSide(
        color: Colors.white,
      ))),
      child: TextField(
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white, fontSize: 20),
        decoration: InputDecoration(
          labelText: "用户名/手机号/邮箱",
        ),
      ),
    );
  }

  DecoratedBox _buildUserField() {
    return DecoratedBox(
      decoration: BoxDecoration(
          border: BorderDirectional(
              bottom: BorderSide(
        color: Colors.white,
      ))),
      child: TextField(
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white, fontSize: 20),
        decoration: InputDecoration(
          labelText: "用户名/手机号/邮箱",
        ),
      ),
    );
  }

  CircleAvatar _buildLogo() {
    return CircleAvatar(
      child: Text(
        "OA",
        style: TextStyle(fontSize: 60),
      ),
      backgroundColor: Colors.white,
      radius: 60,
    );
  }
}
