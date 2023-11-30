// ignore_for_file: must_be_immutable

part of 'news_bloc.dart';

class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class AppStartEvent extends NewsEvent {}

class FetchEverythingNewsEvent extends NewsEvent {
  String search;
  FetchEverythingNewsEvent({required this.search});
}

class FetchTopHeadlineNewsEvent extends NewsEvent {
  String? country;
  String? category;
  FetchTopHeadlineNewsEvent({
    required this.country,
    required this.category,
  });
}

class ViewArticleDetailEvent extends NewsEvent {
  NewsResponse news;
  int index;
  ViewArticleDetailEvent({required this.news, required this.index});
}

class ChangeNewsPropertiesEvent extends NewsEvent {
  String selectedCountry;
  String selectedCategory;
  ChangeNewsPropertiesEvent(
      {required this.selectedCategory, required this.selectedCountry});
}
