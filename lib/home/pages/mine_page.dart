import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 30),
            child: Container(
              width: 80,
              height: 80,
              child: Image.asset("assets/images/flutter_wheel.jpeg"),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: 15.0, top: 20.0, right: 15.0, bottom: 5.0),
              child: GestureDetector(
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.topLeft,
                    child: Text("我的收藏"),
                  ),
                ),
                onTap: () {
                  print("点击我的收藏");
                },
              )),
          Padding(
            padding: EdgeInsets.only(
                left: 15.0, top: 5.0, right: 15.0, bottom: 10.0),
            child: GestureDetector(
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: Text("代办清单"),
                ),
              ),
              onTap: () {
                print("点击代办清单");
              },
            ),
          )
        ],
      ),
    );
  }
}
