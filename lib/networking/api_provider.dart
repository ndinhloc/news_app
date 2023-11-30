import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/news_response.dart';

class ApiProvider {
  final String _baseUrl = "https://newsapi.org/v2/";

  Future<dynamic> get(String url) async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + url));
      // ignore: avoid_print
      print(_baseUrl + url);
      NewsResponse temp = NewsResponse.fromJson(jsonDecode(response.body));
      print(temp.articles.length);
      return temp;
      //return NewsResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return NewsResponse.withError(e.toString());
    }
  }
}
