import 'package:flutter/widgets.dart';

class ComModel {
  String version;
  String title;
  String content;
  String extra;
  String url;
  String imgUrl;
  String author;
  String avatar;
  String updatedAt;

  String titleId;

  Widget page;

  ComModel(
      {this.version,
        this.title,
        this.content,
        this.extra,
        this.url,
        this.imgUrl,
        this.author,
        this.avatar,
        this.updatedAt,
        this.titleId,
        this.page});

  ComModel.fromJson(Map<String, dynamic> json)
      : version = json['version'],
        title = json['title'],
        content = json['content'],
        extra = json['extra'],
        url = json['url'],
        imgUrl = json['imgUrl'],
        author = json['author'],
        avatar = json['avatar'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() => {
    'version': version,
    'title': title,
    'content': content,
    'extra': extra,
    'url': url,
    'imgUrl': imgUrl,
    'author': author,
    'avatar': avatar,
    'updatedAt': updatedAt,
  };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"version\":\"$version\"");
    sb.write(",\"title\":\"$title\"");
    sb.write(",\"content\":\"$content\"");
    sb.write(",\"extra\":\"$extra\"");
    sb.write(",\"url\":\"$url\"");
    sb.write(",\"imgUrl\":\"$imgUrl\"");
    sb.write(",\"author\":\"$author\"");
    sb.write(",\"avatar\":\"$avatar\"");
    sb.write(",\"updatedAt\":\"$updatedAt\"");
    sb.write('}');
    return sb.toString();
  }
}