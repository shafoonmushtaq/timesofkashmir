import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Category extends Equatable {
  final int? id;
  final int? count;
  final String? description;
  final String? link;
  final String? name;
  final String? slug;

  const Category(
      {required this.id,
      required this.count,
      required this.description,
      required this.link,
      required this.name,
      required this.slug});

  @override
  List<Object?> get props => [id, count, description, link, name, slug];
}
