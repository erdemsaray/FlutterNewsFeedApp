import 'package:flutter/material.dart';

enum NewsWebViewState { busy, idle, error }

class NewsWebViewPageModel with ChangeNotifier {
  NewsWebViewState _state = NewsWebViewState.idle;
  String newsURL = '';

  NewsWebViewState get state => _state;

  set state(NewsWebViewState state) {
    _state = state;
    notifyListeners();
  }

  void changeURL(String url) {
    newsURL = url;
    notifyListeners();
  }
}
