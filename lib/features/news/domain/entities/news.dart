import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class News extends Equatable {
  final int? id;
  final String? date;
  final String? dateGmt;
  final Guid? guid;
  final String? modified;
  final String? modifiedGmt;
  final String? slug;
  final String? status;
  final String? type;
  final String? link;
  final Guid? title;
  final Content? content;
  final Content? excerpt;
  final int? author;
  final int? featuredMedia;
  final String? commentStatus;
  final String? pingStatus;
  final bool? sticky;
  final String? template;
  final String? format;
  final List<int>? categories;
  final List<int>? tags;
  final String? yoastHead;
  final String? jetpackFeaturedMediaUrl;

  const News({
    required this.id,
    required this.date,
    required this.dateGmt,
    required this.guid,
    required this.modified,
    required this.modifiedGmt,
    required this.slug,
    required this.status,
    required this.type,
    required this.link,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.author,
    required this.featuredMedia,
    required this.commentStatus,
    required this.pingStatus,
    required this.sticky,
    required this.template,
    required this.format,
    required this.categories,
    required this.tags,
    required this.yoastHead,
    this.jetpackFeaturedMediaUrl,
  });

  @override
  List<Object?> get props => [
        id,
        date,
        dateGmt,
        guid,
        modified,
        modifiedGmt,
        slug,
        status,
        type,
        link,
        title,
        content,
        excerpt,
        author,
        featuredMedia,
        commentStatus,
        pingStatus,
        sticky,
        template,
        format,
        categories,
        tags,
        yoastHead,
        jetpackFeaturedMediaUrl
      ];
}

class Guid {
  String? rendered;

  Guid({this.rendered});

  Guid.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rendered'] = rendered;
    return data;
  }
}

class Content {
  String? rendered;
  bool? protected;

  Content({this.rendered, this.protected});

  Content.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'] as String;
    protected = json['protected'] as bool;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rendered'] = rendered;
    data['protected'] = protected;
    return data;
  }
}
