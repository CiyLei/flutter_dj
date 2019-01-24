import 'package:flutter/material.dart';

void main() => runApp(TestRoute());

class TestRoute extends StatelessWidget {
  const TestRoute({this.str = ''});

  final String str;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TestRoute',
      home: Scaffold(
        appBar: AppBar(
          title: Text('TestRoute'),
        ),
        body: Center(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.redAccent, Colors.orangeAccent]),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.cyan,
                    borderRadius: BorderRadius.circular(20.0),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Text(
                        '5.20',
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                    ),
                  ),
//                decoration: BoxDecoration(
//                    gradient: RadialGradient(
//                        colors: [Colors.red, Colors.orange],
//                        center: Alignment.topLeft,
//                        radius: .98),
//                    boxShadow: [
//                      //卡片阴影
//                      BoxShadow(
//                          color: Colors.black54,
//                          offset: Offset(2.0, 2.0),
//                          blurRadius: 4.0)
//                    ]),
//            padding: const EdgeInsets.all(50),
//                transform: Matrix4.rotationZ(.2),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.of(context).pop([1, 2, 3]);
        }),
      ),
    );
  }
}
