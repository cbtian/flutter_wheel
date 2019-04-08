import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController phoneEditingController = new TextEditingController();
  TextEditingController pswEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = ScreenUtil.screenWidthDp * 2 / 3;
    return Scaffold(
      appBar: AppBar(title: Text("登陆")),
      body: Container(child: Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: phoneEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    icon: Icon(Icons.phone),
                    labelText: "请输入用户名",
                  ),
                  autofocus: true,
                ),
                TextField(
                  controller: pswEditingController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      icon: Icon(Icons.lock),
                      labelText: "请输入密码"),
                  autofocus: true,
                ),
                Container(height: ScreenUtil.getInstance().setHeight(30),)
                ,
                RaisedButton(
                  color: Colors.red,
                  onPressed: () {
                    print("登陆");
                  },
                  child: Container(
                    child: Text("登陆",style: TextStyle(color: Colors.white,fontSize: ScreenUtil.getInstance().setSp(36)),),
                    width: width,
                    alignment: Alignment.center,
                  ),
                )
              ],
            ),
          ))),
      resizeToAvoidBottomPadding: false, //输入框抵住键盘
    );

  }
}
