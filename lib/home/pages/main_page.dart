import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wheel/network/home/article.dart'
    show Article, ArticleBean;
import 'package:flutter_wheel/banner/banner_view.dart' show BannerView;
import 'package:flutter_wheel/network/banner/banners.dart' ;
import 'package:flutter_wheel/network/httputil.dart';
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

/**
 * AutomaticKeepAliveClientMixin 保存当前page的状态切换回来的时候不重新刷新界面
 */
class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  ArticleBean _networkResult = new ArticleBean();
  BannerBean _bannerBean = new BannerBean();
  int index = 0;

  _getMainPageData() async {
    var url = HttpUtils.getUrl(article: HttpUtils.Articles, index: index);
    HttpController.getData(url, (data){
      if (!mounted) return;
      setState(() {
        _networkResult = ArticleBean.from(data["data"]);
      });
    });
  }

  _getBannerContent(){
    var url = HttpUtils.getUrl(article: HttpUtils.Banner);
    HttpController.getData(url, (data){
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
    if (_networkResult.datas[i].tags.length == 0) {
      return Text("分类：" +
          _networkResult.datas[i].superChapterName +
          "/" +
          _networkResult.datas[i].chapterName);
    } else {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
              _networkResult.datas[i].tags[0].name,
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
              _networkResult.datas[index].superChapterName +
              "/" +
              _networkResult.datas[index].chapterName)
        ],
      );
    }
  }

  _getBannerView(){
    List<Widget> banners = [Container(), Container()];
    if(_bannerBean.data != null){
      banners.clear();
      for (var i = 0; i < _bannerBean.data.length; ++i) {
        banners.add(Image.network(_bannerBean.data[i].imagePath));
      }
    }
    return
      Container(alignment: Alignment.center,
        height: 200.0,
        child: new BannerView(
          data: banners,
          ontap: (index){
            print("点击第$index个控件");
          },
        ),
      );
  }
  
  
  @override
  Widget build(BuildContext context) {
    int size = _networkResult.datas == null ? 0 : _networkResult.datas.length;
    return new Scaffold(
      appBar: AppBar(
        title: Text("首页"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if(index == 0){
            return _getBannerView();
          }
          return Card(
            child: Padding(
                padding: EdgeInsets.all(ScreenUtil.getInstance().setSp(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _networkResult.datas[index-1].title,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(32)),
                    ),
                    _getRowView(index-1),
                    Text(_networkResult.datas[index-1].niceDate +
                        " By作者：" +
                        _networkResult.datas[index-1].author),
                  ],
                )),
          );
        },
        itemCount: size+1,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
