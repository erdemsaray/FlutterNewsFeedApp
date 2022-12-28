import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../model/news.dart';
import '../service/favorite_service.dart';
import '../view/news_webview_page.dart';
import 'news_webiew_page_model.dart';

enum NewsDetailsState { idle, busy, error }

class NewsDetailsPageModel with ChangeNotifier {
  NewsDetailsState _state = NewsDetailsState.idle;
  News newsModel = News("title", "description", "date", "imageURL", "newsURL", "source");
  bool isFavorite = false;

  NewsDetailsState get state => _state;
  set state(NewsDetailsState state) {
    _state = state;
    notifyListeners();
  }

  NewsDetailsPageModel() {
    isNewsFavorited();
  }

  void changeNewsModel(News newModel) {
    newsModel = newModel;
    notifyListeners();
  }

  Future<void> isNewsFavorited() async {
    state = NewsDetailsState.busy;

    bool result = await FavoriteService().isNewsFavorite(newsModel);
    state = NewsDetailsState.idle;
    isFavorite = result;
    notifyListeners();
  }

  void webviewButtonClicked(BuildContext context) {
    Provider.of<NewsWebViewPageModel>(context, listen: false).changeURL(newsModel.newsURL);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => (const NewsWebViewPageView())),
    );
  }

  void addToFavorites() {
    FavoriteService().addToFavorites(newsModel);
  }

  Future<void> shareButtonClicked() async {
    await Share.share('Share this link with your connections!', subject: newsModel.newsURL);
  }
}
