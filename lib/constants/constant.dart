class AppColors{
  static const AppBarColor = 0xff303030;
  static const AppTabTextColor = 0xffff7830;
}
class TabConfig{
  //以下三个数据保证长度一致，这里未做判断 后续添加
  /**
   * //底部title
   */
  static const HOME_TAB_TITLES = const ["首页", "项目", "公众号", "我的"];
  /**
   * 底部正常情况下按钮
   */
  static const HOME_TAB_NORMALICON = const [
    "assets/images/main/tab/ic_tab_home_no_selected.png",
    "assets/images/main/tab/ic_tab_category_no_selected.png",
    "assets/images/main/tab/ic_tab_bookshelf_no_selected.png",
    "assets/images/main/tab/ic_tab_mine_no_selected.png"
  ];
  /**
   * 底部选中情况下按钮
   */
  static const HOME_TAB_ACTIVEICON = const [
    "assets/images/main/tab/ic_tab_home_selected.png",
    "assets/images/main/tab/ic_tab_category_selected.png",
    "assets/images/main/tab/ic_tab_bookshelf_selected.png",
    "assets/images/main/tab/ic_tab_mine_selected.png"
  ];
  /**
   * 按钮的宽高
   */
  static const double width = 30.0, height = 30.0;

}

