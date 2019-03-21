class TreeBean {
  List<TreeContent> data;

  TreeBean({this.data});

  factory TreeBean.fromJson(Map<String, dynamic> parsedJson) {
    return TreeBean(
        data: (parsedJson["data"] as List)
            .map((i) => TreeContent.fromjson(i))
            .toList());
  }
}

class TreeContent {
//  "children": [],
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  TreeContent(
      {this.courseId,
      this.id,
      this.name,
      this.order,
      this.parentChapterId,
      this.userControlSetTop,
      this.visible});

  factory TreeContent.fromjson(Map<String, dynamic> parsedJson) {
    return TreeContent(
      courseId: parsedJson["courseId"],
      id: parsedJson["id"],
      name: parsedJson["name"],
      order: parsedJson["order"],
      parentChapterId: parsedJson["parentChapterId"],
      userControlSetTop: parsedJson["userControlSetTop"],
      visible: parsedJson["visible"],
    );
  }
}
