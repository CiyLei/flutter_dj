import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() => runApp(FileDemo());

class FileDemo extends StatefulWidget {
  @override
  _FileDemoState createState() => _FileDemoState();
}

class _FileDemoState extends State<FileDemo> {
  int count = 0;

  @override
  void initState() {
    super.initState();
    getCount().then((v) {
      setState(() {
        count = v;
      });
    });
  }

  Future<File> getFile() async {
    String path = (await getApplicationDocumentsDirectory()).path;
    return File("$path/count.txt");
  }

  Future<int> getCount() async {
    try {
      File file = await getFile();
      String count = await file.readAsString();
      return int.parse(count);
    } on Exception {
      return 0;
    }
  }

  Future<Null> saveCount() async {
    File file  = await getFile();
    await file.writeAsString(count.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FileDemo",
      home: Scaffold(
        appBar: AppBar(title: Text("FileDemo"),),
        body: Center(
          child: Text("$count"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              count++;
              saveCount();
            });
          },
        ),
      ),
    );
  }
}
