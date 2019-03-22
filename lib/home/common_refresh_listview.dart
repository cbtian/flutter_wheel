import 'package:flutter/material.dart';
import 'package:flutter_wheel/flutter_refresh/refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wheel/network/httputil.dart';
import 'package:flutter_wheel/network/article.dart';

/**
 * 自定义刷新Listview
 */
class CommonRefreshLv extends StatefulWidget {
  Map<String, String> params;
  String hostStr; //请求的数据类别
  CommonRefreshLv({this.hostStr,this.params}) : assert(hostStr != null);

  @override
  CommonRefreshLvState createState() => CommonRefreshLvState(hostStr:hostStr,params: params);
}

class CommonRefreshLvState extends State<CommonRefreshLv>
    with AutomaticKeepAliveClientMixin {
  bool isHasBanner;
  int _index = 0;
  List<Article> _networkResult = [];

  Map<String, String> params;
  String hostStr; //请求的数据类别
  CommonRefreshLvState({this.hostStr, this.params}) : assert(hostStr != null);

  _getPageData() async {
    var url = HttpUtils.getUrl(article: hostStr, index: _index);
    HttpController.getData(url, (data) {
      if (!mounted) return;
      setState(() {
        ArticleBean articleBean = ArticleBean.from(data["data"]);
        if (articleBean.curPage < articleBean.pageCount) {
          _index++;
        }
        _networkResult.addAll(articleBean.datas);
      });
    }, params: params);
  }

  Future<Null> _loadMoreData() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        _getPageData();
      });
    });
  }

  Future<Null> _onRefresh() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        _index = 0;
        _networkResult.clear();
        _getPageData();
      });
    });
  }

  _getRowView(int i) {
    if (_networkResult[i].tags.length == 0) {
      return Text("分类：" +
          _networkResult[i].superChapterName +
          "/" +
          _networkResult[i].chapterName);
    } else {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
              _networkResult[i].tags[0].name,
              style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(16)),
            ),
            padding: EdgeInsets.only(
                left: ScreenUtil.getInstance().setWidth(10),
                top: ScreenUtil.getInstance().setWidth(2),
                right: ScreenUtil.getInstance().setWidth(10),
                bottom: ScreenUtil.getInstance().setWidth(2)),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
          Container(
            width: ScreenUtil.getInstance().setWidth(10),
          ),
          Text("分类：" +
              _networkResult[i].superChapterName +
              "/" +
              _networkResult[i].chapterName)
        ],
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPageData();
  }

  @override
  Widget build(BuildContext context) {
    int size = _networkResult == null ? 0 : _networkResult.length;
    return Container(
      child: Refresh(
        onFooterRefresh: _loadMoreData,
        onHeaderRefresh: _onRefresh,
        childBuilder: (BuildContext context,
            {ScrollController controller, ScrollPhysics physics}) {
          return new Container(
            child: ListView.builder(
              physics: physics,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Padding(
                      padding:
                          EdgeInsets.all(ScreenUtil.getInstance().setSp(30)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _networkResult[index].title,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(32)),
                          ),
                          _getRowView(index),
                          Text(_networkResult[index].niceDate +
                              " By作者：" +
                              _networkResult[index].author),
                        ],
                      )),
                );
              },
              itemCount: size,
              controller: controller,
            ),
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
