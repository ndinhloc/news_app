part of 'news_bloc.dart';

sealed class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

final class NewsInitial extends NewsState {}

class NewsEmptyState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final NewsResponse news;

  const NewsLoadedState({required this.news});

  @override
  List<Object> get props => [news];
}

class NewsErrorState extends NewsState {
  String error;
  NewsErrorState(this.error);
}

class ViewingNewsState extends NewsState {}
