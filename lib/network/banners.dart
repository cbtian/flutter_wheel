class BannerBean {
 final List<BannerContent> data;

  BannerBean({this.data});

  factory BannerBean.formJson(Map<String, dynamic> parsedJson){
    return BannerBean(
        data: (parsedJson["data"] as List)
            .map((i) => BannerContent.fromJson(i))
            .toList()
    );
  }

}

class BannerContent {
  final String desc;
  final int id;
  final String imagePath;
  final int isVisible;
  final int order;
  final String title;
  final int type;
  final String url;

  BannerContent({this.desc, this.id, this.imagePath, this.isVisible, this.order,
    this.title, this.type, this.url});

  factory BannerContent.fromJson(Map<String, dynamic> parsedJson){
    return BannerContent(desc: parsedJson["desc"],
        id: parsedJson["id"],
        imagePath: parsedJson["imagePath"],
        isVisible: parsedJson["isVisible"],
        order: parsedJson["order"],
        title: parsedJson["title"],
        type: parsedJson["type"],
        url: parsedJson["url"]);
  }


}