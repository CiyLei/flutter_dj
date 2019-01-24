import 'dart:typed_data';
import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_demo/dj/section_widget.dart';
import 'home.dart';
import 'dart:ui' as ui show ImageFilter, Gradient, Image;

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
  GlobalKey _backKey = new GlobalKey();
  AnimationController loginControll;
  Animation<double> widthAnimation;
  Animation<double> transparentAnimation;
  Animation<double> pointAnimation;
  Animation<double> pointZoomAnimation;
  Home _home;

  @override
  void initState() {
    super.initState();
    _home = Home();
    loginControll =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..addStatusListener((AnimationStatus statu) {
            if (statu == AnimationStatus.completed) {
              openHomePage();
            }
          });
  }

  openHomePage() async {
    Uint8List capturePng = await _capturePng();
    Codec codec = await instantiateImageCodec(capturePng);
    FrameInfo frame = await codec.getNextFrame();
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 2000),
        pageBuilder: (buildContext, animation1, animation2) {
          return AnimatedBuilder(
            animation: animation1,
            builder: (bulidContext, child) => Stack(
              children: <Widget>[
                _home,
                SectionWidget(
                  backgroupImage: frame.image,
                  progress: animation1.value,
                  color: Theme.of(context).primaryColor,
                  // 55为发布按钮的中心位置
                  bottomOffsetY: (55.0 + max(0.0, MediaQuery.of(context).padding.bottom - 10.0)),
                )
              ],
            ),
          );
        }));
    loginControll.reset();
  }

  // 截图boundary，并且返回图片的二进制数据。
  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary = _backKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    // 注意：png是压缩后格式，如果需要图片的原始像素数据，请使用rawRgba
    ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    return pngBytes;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
//    initAnimation();
  }

  void initAnimation(double pointOffY) {
    widthAnimation = Tween(
            begin: window.physicalSize.width,
            end: (50.0))
        .animate(CurvedAnimation(
            parent: loginControll,
            curve: Interval(0, 0.7, curve: ElasticOutCurve(1.8))));
    transparentAnimation = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: loginControll, curve: Interval(0.2, 0.3)));
    pointAnimation =
        Tween(begin: 0.0, end: pointOffY).animate(
            CurvedAnimation(
                parent: loginControll,
                curve: Interval(0.30, 0.85, curve: Curves.ease)));
    pointZoomAnimation = Tween(
            begin: (10.0),
            end: (75.0))
        .animate(
            CurvedAnimation(parent: loginControll, curve: Interval(0.95, 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          hintColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(
                color: Colors.white, fontSize: 12),
            border: InputBorder.none,
          )),
      child: RepaintBoundary(
        key: _backKey,
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20,
                    right: 20),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: 80,
                          bottom: 40),
                      child: _buildLogo(),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(bottom: 15),
                      child: _buildUserField(),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(bottom: 70),
                      child: _buildPassField(),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.only(bottom: 15),
                      child: AnimatedBuilder(
                        animation: loginControll,
                        builder: (builderContext, childWidget) {
                          return Stack(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Center(
                                    child: _buildLogin(
                                        context,
                                        widthAnimation == null
                                            ? double.infinity
                                            : widthAnimation.value,
                                        transparentAnimation == null
                                            ? 1
                                            : transparentAnimation.value),
                                  ),
                                  (pointAnimation == null
                                      ? 0
                                      : pointAnimation.value) >
                                      0
                                      ? Padding(
                                    padding: EdgeInsets.only(
                                        top: (pointAnimation == null
                                            ? 0
                                            : pointAnimation.value) -
                                            ((pointZoomAnimation == null
                                                ? 10
                                                : pointZoomAnimation
                                                .value) /
                                                2) +
                                            5),
                                    child: _buildPoint(
                                        pointZoomAnimation == null
                                            ? 10
                                            : pointZoomAnimation.value),
                                  )
                                      : Padding(
                                    padding: EdgeInsets.zero,
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 65),
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
      ),
    );
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
            final y = _loginKey.currentContext.findRenderObject().getTransformTo(null).getTranslation().y;
            // 屏幕高度 - 登陆按钮的屏幕位置 - 登陆按钮的高度 - 扩展按钮的底部padding
            initAnimation(MediaQuery.of(context).size.height - y - 50 - 55 - max(0.0, MediaQuery.of(context).padding.bottom - 10.0));
            loginControll.forward();
          },
          borderRadius:
              BorderRadius.all(Radius.circular(25)),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.all(
                    Radius.circular(25))),
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
            style: TextStyle(
                color: Colors.white, fontSize: 12),
          ),
        ),
        Expanded(
          child: Text(
            "忘记密码",
            textAlign: TextAlign.right,
            style: TextStyle(
                color: Colors.white, fontSize: 12),
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
