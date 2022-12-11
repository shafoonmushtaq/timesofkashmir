import 'dart:convert';

import '/features/news/domain/entities/category.dart';

List<CategoryModel> categoryFromJson(String str) => List<CategoryModel>.from(
    json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel extends Category {
  const CategoryModel(
      {int? id,
      int? count,
      String? description,
      String? link,
      String? name,
      String? slug})
      : super(
            id: id,
            count: count,
            description: description,
            link: link,
            name: name,
            slug: slug);

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        count: json["count"],
        description: json["description"],
        link: json["link"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "count": count,
        "description": description,
        "link": link,
        "name": name,
        "slug": slug,
      };

  bool equalsName(String name) {
    if (this.name == name) {
      return true;
    }
    return false;
  }
}
