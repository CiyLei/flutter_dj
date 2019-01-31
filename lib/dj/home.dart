import 'package:flutter/material.dart';
import 'dart:math';
import 'company.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_demo/anim/water_droplets_anim2.dart';

class Home extends StatefulWidget {
  Home({this.radiusWidth});

  double radiusWidth = 0;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController expansionButtonController;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expansionButtonController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Scaffold(
          appBar: _buildAppBar(),
          bottomNavigationBar: _buildBottomNavigationBar(),
          body: Company(),
        ),
        Positioned(
          bottom: 30.0 + max(0.0, MediaQuery.of(context).padding.bottom - 10.0),
          width: 50,
          height: 50,
          child: Material(
            color: Colors.transparent,
            child: _buildExpansionButton(),
          ),
        )
      ],
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    return Stack(
//      alignment: Alignment.bottomCenter,
//      children: <Widget>[
//        Scaffold(
//          appBar: _buildAppBar(),
//          bottomNavigationBar: _buildBottomAppBar(),
//          body: Company(),
//          floatingActionButton: FloatingActionButton(
//            onPressed: () {},
//            child: _buildExpansionButton(),
//          ),
//          floatingActionButtonLocation:
//          FloatingActionButtonLocation.centerDocked,
//        ),
//      ],
//    );
//  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text("东经科技"),
      leading: Icon(Icons.apps),
      actions: <Widget>[
        _bulidScannerBar(),
        _buildMessageBar(),
      ],
    );
  }

  IconButton _bulidScannerBar() {
    return IconButton(
      icon: Icon(Icons.scanner),
      color: Colors.white,
      onPressed: () {},
    );
  }

  IconButton _buildMessageBar() {
    return IconButton(
      icon: Icon(Icons.message),
      color: Colors.white,
      onPressed: () {},
    );
  }

  Widget _buildExpansionButton() {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 0.125).animate(CurvedAnimation(
          parent: expansionButtonController, curve: Curves.bounceOut)),
      child: Transform.rotate(
        angle: pi / 4,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                )
              ]),
          child: IconButton(
            iconSize: 50,
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.cancel,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              if (expansionButtonController.status ==
                  AnimationStatus.completed) {
                expansionButtonController.reverse();
                Navigator.of(context).pop();
              } else if (expansionButtonController.status ==
                  AnimationStatus.dismissed) {
                expansionButtonController.forward();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (c) => WaterDropletsDemo()));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            width: 50.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.comment,
                  color: Theme.of(context).primaryColor,
                ),
                Text("公司")
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            width: 50.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.work,
                  color: Theme.of(context).primaryColor,
                ),
                Text("工作")
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            alignment: Alignment.bottomCenter,
            width: 50.0,
            height: 50.0,
            child: Text("发布"),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            width: 50.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.book,
                  color: Theme.of(context).primaryColor,
                ),
                Text("通讯录")
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            width: 50.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
                Text("我的")
              ],
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          title: Text("公司"),
          icon: Icon(Icons.comment),
        ),
        BottomNavigationBarItem(title: Text("工作"), icon: Icon(Icons.work)),
        BottomNavigationBarItem(title: Text("发布"), icon: Icon(null)),
        BottomNavigationBarItem(title: Text("通讯录"), icon: Icon(Icons.book)),
        BottomNavigationBarItem(title: Text("我的"), icon: Icon(Icons.person)),
      ],
    );
  }
}
