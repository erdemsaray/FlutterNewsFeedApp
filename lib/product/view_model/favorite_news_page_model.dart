import 'package:flutter/widgets.dart';

import '../model/news.dart';
import '../service/favorite_service.dart';

enum FavoriteNewsPageStatus { busy, idle, error }

class FavoriteNewsPageModel with ChangeNotifier {
  FavoriteNewsPageStatus _state = FavoriteNewsPageStatus.idle;
  List<News> news = [];
  bool isClearButtonClicked = false;

  FavoriteNewsPageStatus get state => _state;
  set state(FavoriteNewsPageStatus state) {
    _state = state;
    notifyListeners();
  }

  FavoriteNewsPageModel() {
    getFavoriteNews();
  }

  Future<void> getFavoriteNews() async {
    state = FavoriteNewsPageStatus.busy;
    news = await FavoriteService().getFavoriteNews();
    state = FavoriteNewsPageStatus.idle;

    notifyListeners();
  }

  void clearButtonClick() {
    isClearButtonClicked = !isClearButtonClicked;
    notifyListeners();
  }
}
