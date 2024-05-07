import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'article_model.dart';

part 'news_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NewsModel {
  NewsModel(this.status, this.totalResults, this.articles);

  String status;
  int totalResults;
  List<Article> articles;

  factory NewsModel.newsFromJson(String str) => _$NewsModelFromJson(jsonDecode(str));

  factory NewsModel.fromJson(Map<String, dynamic> json) => _$NewsModelFromJson(json);
}
