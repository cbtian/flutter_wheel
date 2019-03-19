class ArticleBean {
  int curPage;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;
  List<Article> datas =[];

  ArticleBean(
      {this.curPage,
      this.offset,
      this.over,
      this.pageCount,
      this.size,
      this.total,
      this.datas});

  factory ArticleBean.from(Map<String, dynamic> parsedJson) {
//    var list = parsedJson['datas'] as List;
//    List<Article> articles = new List();
//    articles = list.map((i) => Article.fromJson(i)).toList();
    return ArticleBean(
      curPage: parsedJson["curPage"],
      offset: parsedJson["offset"],
      over: parsedJson["over"],
      pageCount: parsedJson["pageCount"],
      size: parsedJson["size"],
      total: parsedJson["total"],
      datas: (parsedJson['datas'] as List)
          .map((i) => Article.fromJson(i))
          .toList(),
    );
  }
}

class Article {
  final String author;
  final String chapterName;
  final String title;
  final String niceDate;
  final String superChapterName;
  final String link;
  final List<Tag> tags;

  Article(
      {this.author,
      this.chapterName,
      this.title,
      this.niceDate,
      this.superChapterName,
      this.link,
      this.tags});

  factory Article.fromJson(Map<String, dynamic> parsedJson) {
    return Article(
        author: parsedJson['author'],
        chapterName: parsedJson['chapterName'],
        title: parsedJson['title'],
        niceDate: parsedJson['niceDate'],
        superChapterName: parsedJson['superChapterName'],
        link: parsedJson['link'],
      tags: (parsedJson['tags'] as List)
          .map((i) => Tag.fromJson(i))
          .toList(),);
  }

}

class Tag{
  String name;
  String url;

  Tag({this.name, this.url});

  factory Tag.fromJson(Map<String, dynamic> parsedJson){
    return Tag(
      name: parsedJson['name'],
      url: parsedJson['url']
    );
  }
}
