import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

void main() => runApp(NetDemo());

class NetDemo extends StatefulWidget {
  @override
  _NetDemoState createState() => _NetDemoState();
}

class _NetDemoState extends State<NetDemo> {
  String content = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NetDemo",
      home: Scaffold(
        appBar: AppBar(
          title: Text("NetDemo"),
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Text(content.replaceAll(new RegExp(r"\s"), ""),),
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          getNetContent();
        }),
      ),
    );
  }

  Future<Null> getNetContent() async{
    final client = HttpClient();
    HttpClientRequest request = await client.getUrl(Uri.parse("http://www.baidu.com"));
    HttpClientResponse response = await request.close();
    content = await response.transform(utf8.decoder).join();
    print(content);
    client.close();
    setState(() {
    });
  }
}


