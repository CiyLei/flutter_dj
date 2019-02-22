import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo'),
        ),
        body: SliverPersistentHeaderDemo(),
      ),
    );
  }
}

class SliverPersistentHeaderDemo extends StatefulWidget {
  @override
  _SliverPersistentHeaderDemoState createState() =>
      _SliverPersistentHeaderDemoState();
}

class _SliverPersistentHeaderDemoState
    extends State<SliverPersistentHeaderDemo> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(delegate: MyHeaderDelegate(),pinned: true,),
        SliverFixedExtentList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(color: Colors.green[(index % 9 + 1) * 100]),
              );
            }, childCount: 30),
            itemExtent: 50.0)
      ],
    );
  }
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    print("shrinkOffset:$shrinkOffset  overlapsContent:$overlapsContent");
    return Container(
      height: 40.0,
      color: Colors.redAccent,
//      decoration: BoxDecoration(
//        gradient: LinearGradient(colors: [
//          Colors.redAccent,
//          Colors.blueAccent
//        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
//      ),
      child: Icon(Icons.ac_unit),
    );
  }

  @override
  double get maxExtent => 40.0;

  @override
  double get minExtent => 40.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

}
