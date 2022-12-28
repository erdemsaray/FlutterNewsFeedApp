import 'package:flutter/widgets.dart';

import '../model/news.dart';
import '../service/news_service.dart';

enum NewsSearchPageState { idle, busy, error }

class NewsSearchPageModel with ChangeNotifier {
  List<News> news = [];
  NewsSearchPageState _state = NewsSearchPageState.idle;
  String searchText = '';

  NewsSearchPageModel() {
    getNewsSearch();
  }

  NewsSearchPageState get state => _state;
  set state(NewsSearchPageState state) {
    _state = state;
    notifyListeners();
  }

  void changeSearchText(String newSearch) {
    searchText = newSearch;
    notifyListeners();
    getNewsSearch();
  }

  Future<void> getNewsSearch() async {
    state = NewsSearchPageState.busy;
    news = await NewsService().getNews(searchText, 1);
    state = NewsSearchPageState.idle;
    notifyListeners();
  }
}
