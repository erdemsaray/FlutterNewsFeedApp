import 'package:flutter/material.dart';

import '../model/news.dart';
import '../service/news_service.dart';
import '../view/news_search_page_view.dart';

enum NewsFeedPageState { idle, busy, error }

class NewsFeedPageModel with ChangeNotifier {
  List<News> news = [];
  NewsFeedPageState _state = NewsFeedPageState.idle;

  NewsFeedPageModel() {
    _state = NewsFeedPageState.idle;
    getNewsGeneral();
  }

  NewsFeedPageState get state => _state;
  set state(NewsFeedPageState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> getNewsGeneral() async {
    _state = NewsFeedPageState.busy;
    news = await NewsService().getNewsGeneral();
    _state = NewsFeedPageState.idle;

    notifyListeners();
  }

  searchButtonClicked(BuildContext context, String query) {
    
    notifyListeners();
    if (query.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NewsSearchPageView(query: query),
        ),
      );
    }
  }
}
