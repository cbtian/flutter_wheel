import 'package:flutter/material.dart';
import 'package:flutter_wheel/home/homepage.dart' show MainHomePage;
import 'package:flutter/services.dart';
import 'dart:io';

void main(){
  runApp(MyApp());
  //判断如果是Android版本的话 设置Android状态栏透明沉浸式
  if(Platform.isAndroid){//沉浸式状态栏
    //写在组件渲染之后，是为了在渲染后进行设置赋值，覆盖状态栏，写在渲染之前对MaterialApp组件会覆盖这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

}
BadCertificateCallback badCertificateCallback;
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Wheel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainHomePage(),
    );
  }
}
