import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class RouteDemo extends StatefulWidget {
  String title = "";
  String url = "";

  RouteDemo({this.title,this.url});

  @override
  _RouteDemoState createState() => _RouteDemoState();
}

class _RouteDemoState extends State<RouteDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebviewScaffold(
        url: widget.url,
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
      ),
    );
  }
}
