import 'package:news_app/constants/constants.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/networking/api_provider.dart';

class Repository {
  final ApiProvider provider;
  Repository({
    required this.provider,
  });
  Future<NewsResponse> fetchEverythingNews(String? search) async {
    final response = await provider.get("everything?q=$search&apiKey=$apiKey");
    return response;
  }

  Future<NewsResponse> fetchTopHeadlineNews(
      String? country, String? category) async {
    dynamic response;
    if (country == null) {
      response =
          await provider.get("top-headlines?category=$category&apiKey=$apiKey");
    } else if (category == null) {
      response =
          await provider.get("top-headlines?country=$country&apiKey=$apiKey");
    } else {
      response = await provider.get(
          "top-headlines?country=$country&category=$category&apiKey=$apiKey");
    }
    print(response.toString());
    return response;
  }
}
