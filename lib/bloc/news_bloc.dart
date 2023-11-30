import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/repo/repository.dart';
import 'package:news_app/utils.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final Repository repo;

  NewsBloc({required this.repo}) : super(NewsInitial()) {
    on<FetchEverythingNewsEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        NewsResponse news = await repo.fetchEverythingNews(event.search);
        emit(NewsLoadedState(news: news));
      } catch (e) {
        emit(NewsErrorState(e.toString()));
      }
    });
    on<FetchTopHeadlineNewsEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        NewsResponse news = await repo.fetchTopHeadlineNews(
            countryMap[event.country.toString()],
            event.category!.toLowerCase());
        emit(NewsLoadedState(news: news));
      } catch (e) {
        emit(NewsErrorState(e.toString()));
      }
    }); // TODO: implement event handler
    on<ViewArticleDetailEvent>((event, emit) {
      viewUrl(event.news.articles[event.index].url!);
    });
    on<ChangeNewsPropertiesEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        NewsResponse news = await repo.fetchTopHeadlineNews(
            countryMap[event.selectedCountry],
            event.selectedCategory.toLowerCase());
        print(countryMap[event.selectedCountry]);
        print(event.selectedCategory.toLowerCase());
        emit(NewsLoadedState(news: news));
      } catch (e) {
        emit(NewsErrorState(e.toString()));
      }
    });
  }
}
