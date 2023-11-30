import 'package:news_app/models/article_model.dart';

class NewsResponse {
  final List<Article> articles;
  final String error;

  NewsResponse(this.articles, this.error);

  NewsResponse.fromJson(Map<String, dynamic> json)
      : articles =
            (json["articles"] as List).map((e) => Article.fromJson(e)).toList(),
        error = "";

  NewsResponse.withError(String e)
      : articles = List.empty(),
        error = e;
}
