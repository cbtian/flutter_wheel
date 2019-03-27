import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wheel/network/article.dart' show Article, ArticleBean;
import 'package:flutter_wheel/banner/banner_view.dart' show BannerView;
import 'package:flutter_wheel/network/banners.dart';
import 'package:flutter_wheel/network/httputil.dart';
import 'package:flutter_wheel/flutter_refresh/refresh.dart';
import 'package:flutter_wheel/home/route.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

/**
 * AutomaticKeepAliveClientMixin 保存当前page的状态切换回来的时候不重新刷新界面
 */
class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  List<Article> _networkResult = [];
  BannerBean _bannerBean = new BannerBean();
  int _index = 0;

  _getMainPageData() async {
    var url = HttpUtils.getUrl(article: HttpUtils.Articles, index: _index);
    HttpController.getData(url, (data) {
      if (!mounted) return;
      setState(() {
        ArticleBean articleBean = ArticleBean.from(data["data"]);
        if (articleBean.curPage < articleBean.pageCount) {
          _index++;
        }
        _networkResult.addAll(articleBean.datas);
      });
    });
  }

  Future<Null> _loadMoreData() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        _getMainPageData();
      });
    });
  }

  _getBannerContent() {
    var url = HttpUtils.getUrl(article: HttpUtils.Banner);
    HttpController.getData(url, (data) {
      print("data = " + data.toString());
      if (!mounted) return;
      setState(() {
        _bannerBean = BannerBean.formJson(data);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMainPageData();
    _getBannerContent();
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

  _getBannerView() {
    List<Widget> banners = [Container(), Container()];
    if (_bannerBean.data != null) {
      banners.clear();
      for (var i = 0; i < _bannerBean.data.length; ++i) {
        banners.add(Image.network(_bannerBean.data[i].imagePath));
      }
    }
    return Container(
      alignment: Alignment.center,
      height: 200.0,
      child: new BannerView(
        data: banners,
        ontap: (index) {
          _push(_bannerBean.data[index].title,_bannerBean.data[index].url);
        },
      ),
    );
  }

  Future<Null> _onRefresh() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        _index = 0;
        _networkResult.clear();
        _getMainPageData();
      });
    });
  }

  _push( title, url) {
//    Navigator.pushNamed(context, "routeDemo");
    Navigator.push(context,new MaterialPageRoute(
      builder: (context) {
        return new RouteDemo(
          title: title,
          url: url,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    int size = _networkResult == null ? 0 : _networkResult.length;
    return new Scaffold(
      appBar: AppBar(
        elevation: 0.0, //去阴影
        title: Text("首页"),
        centerTitle: true,
      ),
      body: Refresh(
        onFooterRefresh: _loadMoreData,
        onHeaderRefresh: _onRefresh,
        childBuilder: (BuildContext context,
            {ScrollController controller, ScrollPhysics physics}) {
          return new Container(
            child: ListView.builder(
              physics: physics,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return _getBannerView();
                }
                int tempIndex = index - 1;
                return GestureDetector(
                    onTap: (){
                      _push(_networkResult[tempIndex].title,_networkResult[tempIndex].link);
                    },
                    child: Card(
                      child: Padding(
                          padding: EdgeInsets.all(
                              ScreenUtil.getInstance().setSp(30)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _networkResult[tempIndex].title,
                                softWrap: true,
                                style: TextStyle(
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(32)),
                              ),
                              _getRowView(tempIndex),
                              Text(_networkResult[tempIndex].niceDate +
                                  " By作者：" +
                                  _networkResult[tempIndex].author),
                            ],
                          )),
                    ));
              },
              itemCount: size + 1,
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
