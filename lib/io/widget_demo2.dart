import 'package:flutter/material.dart';

void main() => runApp(WidgetTest2());
//void main() {
//  print(getTest());
//}
//
//int getTest() {
//  assert (() {
//    return true;
//  }());
//  if (true == false) {
//    print(1);
//    print(2);
//  }
//  return 0;
//}

class WidgetTest2 extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _WidgetTest2State();
  }
}

class _WidgetTest2State extends State<WidgetTest2> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: Text("123123123", textDirection: TextDirection.ltr,),
    );
  }
}