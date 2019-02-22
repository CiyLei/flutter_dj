import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: 0.5, child: Text("123", textDirection: TextDirection.ltr,),);
  }
}
