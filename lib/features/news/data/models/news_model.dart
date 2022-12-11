// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

import '/features/news/domain/entities/news.dart';

List<NewsModel> newsModelFromJson(String str) =>
    List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromJson(x)));

String newsModelToJson(List<NewsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsModel extends News {
  const NewsModel(
      {required int? id,
      required String? date,
      required String? dateGmt,
      required Guid? guid,
      required String? modified,
      required String? modifiedGmt,
      required String? slug,
      required String? status,
      required String? type,
      required String? link,
      required Guid? title,
      required Content content,
      required Content excerpt,
      required int? author,
      required int? featuredMedia,
      required String? commentStatus,
      required String? pingStatus,
      required bool? sticky,
      required String? template,
      required String? format,
      required List<int> categories,
      required List<int> tags,
      required String? yoastHead,
      required String? jetpackFeaturedMediaUrl})
      : super(
            id: id,
            date: date,
            dateGmt: dateGmt,
            guid: guid,
            modified: modified,
            modifiedGmt: modifiedGmt,
            slug: slug,
            status: status,
            type: type,
            link: link,
            title: title,
            content: content,
            excerpt: excerpt,
            author: author,
            featuredMedia: featuredMedia,
            commentStatus: commentStatus,
            pingStatus: pingStatus,
            sticky: sticky,
            template: template,
            format: format,
            categories: categories,
            tags: tags,
            yoastHead: yoastHead,
            jetpackFeaturedMediaUrl: jetpackFeaturedMediaUrl);

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
      id: json["id"],
      date: json["date"].toString(),
      dateGmt: json["date_gmt"].toString(),
      guid: Guid.fromJson(json["guid"]),
      modified: json["modified"].toString(),
      modifiedGmt: json["modifiedGmt"].toString(),
      slug: json["slug"],
      status: json["status"],
      type: json["type"],
      link: json["link"],
      title: Guid.fromJson(json["title"]),
      content: Content.fromJson(json["content"]),
      excerpt: Content.fromJson(json["excerpt"]),
      author: json["author"],
      featuredMedia: json["featured_media"],
      commentStatus: json["comment_status"],
      pingStatus: json["ping_status"],
      sticky: json["sticky"],
      template: json["template"],
      format: json["format"],
      categories: List<int>.from(json["categories"].map((x) => x)),
      tags: List<int>.from(json["tags"].map((x) => x)),
      yoastHead: json["yoast_head"],
      jetpackFeaturedMediaUrl: json["jetpack_featured_media_url"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "date_gmt": dateGmt,
        "guid": guid!.toJson(),
        "modified": modified,
        "modified_gmt": modifiedGmt,
        "slug": slug,
        "status": status,
        "type": type,
        "link": link,
        "title": title!.toJson(),
        "content": content!.toJson(),
        "excerpt": excerpt!.toJson(),
        "author": author,
        "featured_media": featuredMedia,
        "comment_status": commentStatus,
        "ping_status": pingStatus,
        "sticky": sticky,
        "template": template,
        "format": format,
        "categories": List<dynamic>.from(categories!.map((x) => x)),
        "tags": List<dynamic>.from(tags!.map((x) => x)),
        "yoast_head": yoastHead,
        "jetpack_featured_media_url": jetpackFeaturedMediaUrl
      };
}
