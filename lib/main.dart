import 'package:flutter/material.dart';
import 'package:json_data/Screens/mainpage.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("DashBoard"),),
        body: main_page(),
      ),
    );
  }
}
