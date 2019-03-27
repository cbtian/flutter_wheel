import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wheel/constants/constant.dart' show AppColors,TabConfig;
import 'package:flutter_wheel/home/pages/main_page.dart';
import 'package:flutter_wheel/home/pages/project.dart';
import 'package:flutter_wheel/home/pages/official_accounts.dart';
import 'package:flutter_wheel/home/pages/mine_page.dart';
class NavigationIconView {
  final String _title; //
  final Widget _activeIcon; //选中显示图片
  final Widget _icon; //正常情况下显示图片
  final BottomNavigationBarItem item;

  NavigationIconView({Key key, String title, Widget icon, Widget activeIcon})
      : _title = title,
        _activeIcon = activeIcon,
        _icon = icon,
        item = new BottomNavigationBarItem(
            icon: icon,
            activeIcon: activeIcon,
            title: Text(
              title,
              style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(32)),
            ),
            backgroundColor: Colors.white);
}

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  List<NavigationIconView> _navigationViews = [];
  List<Widget> _pages;
  PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController(
        initialPage: _currentIndex, keepPage: true, viewportFraction: 1.0);
    _pages = [
      MainPage(),
      ProjectPage(),
      OfficialAccount(),
      MinePage(),
    ];
  }

  /**
   * 初始化数据
   */
  _initData() {
      _navigationViews.clear();
      for (var i = 0; i < TabConfig.HOME_TAB_TITLES.length; ++i) {
        NavigationIconView navigationIconView = NavigationIconView(
            title: TabConfig.HOME_TAB_TITLES[i],
            icon: Image.asset(
              TabConfig.HOME_TAB_NORMALICON[i],
              width: TabConfig.width,
              height: TabConfig.height,
            ),
            activeIcon: Image.asset(
              TabConfig.HOME_TAB_ACTIVEICON[i],
              width: TabConfig.width,
              height: TabConfig.height,
            )
        );
        _navigationViews.add(navigationIconView);

      }
  }

  @override
  Widget build(BuildContext context) {
    /**
     * 初始化ScreenUtils，宽和高是设计稿的尺寸之后在使用的时候
     * 便可以使用ScreenUtil.getInstance().setSp(int size)
     * ScreenUtil.getInstance().setWidth(int size)
     * ScreenUtil.getInstance().setHeight(int size);
     * size 就是设计稿的上的控件的大小
     */
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    _initData();
    BottomNavigationBar navigationBar = BottomNavigationBar(
        fixedColor: Color(AppColors.AppTabTextColor),
        items: _navigationViews
            .map((NavigationIconView navigationIconView) =>
        navigationIconView.item)
            .toList(),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
          });
        });
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        },
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: navigationBar,
    );
  }
}
