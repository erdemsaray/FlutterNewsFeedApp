import 'package:newsapp/modals/news.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteNewsController {
  //bu kısımda kullanıcının favori olarak isaretledigi haberler veri tabanına kaydedilebilir ve veri tabanından geri çekilebilir.
  List<News> favoriteNews = [];
  getFavoriteNews() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? newsString = await prefs.getString('news_key');
    
    //eğer daha veri eklenmediyse news_key null dönüyor. Hatanın önüne geçmek için null kontrolü. Bu durumda decode işlemi pass geçiliyor. 
    if (newsString != null) {
      favoriteNews = News.decode(newsString);
    }
  }

  clearFavoriteNews(News news) async {
    favoriteNews.remove(news);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = News.encode(favoriteNews);
    await prefs.setString('news_key', encodedData);
  }

  addToFavorites(News news) async {
    if(!favoriteNews.contains(news)){//favorilerde aynı içerik tekrarlanmasın diye kontrol ediyoruz. Favoriler için set yapısı da kullanılabilir ama implemantaston biraz değişiyor. 
      favoriteNews.add(news);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = News.encode(favoriteNews);
    await prefs.setString('news_key', encodedData);
    //endode ettiğimiz veriyi news_key anahtarı ile lokale kaydediyoruz.
    }
    

   
  }
}
