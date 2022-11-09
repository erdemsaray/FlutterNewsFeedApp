import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/modals/news.dart';

//haberleri genel olarak control edecegimiz yapı
class NewsController {
  //eklenen news üyelerini api'den çektiten sonra bu news listesine ekliyoruz.
  List<News> news = [];
  final String baseUrl = 'https://newsapi.org/v2/everything?q=';
  final String apiKey = 'b44b54112787468fb74339f0fca150e4';

  Future<void> getNews(String keyword, int page) async {
    //Kullanıcıdan alınan keyword ve page bilgileri ile api adresi olusturuluyor.
    var response = await http.get(Uri.parse('$baseUrl$keyword&$page&apiKey=$apiKey'));
    var jsonData = jsonDecode(response.body);

    //status yerine statusCode=200 kontrolü de yapılabilir.
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          News newsModel = News(
            element['title'],
            element['description'],
            element['publishedAt'],
            element['urlToImage'],
            element['url'],
            element['source']['name'],
          );
          //Parse edilen datalar news listesine aktarılıyor. Viewsler ile direkt bu listeye erisiyoruz.
          news.add(newsModel);
        }
      });
    }
  }

  //Anasayfada kullanıcı herhangi bir arama yapmadığı durumda karşısına çıkacak ekran için bu metodu kullanıyoruz.
  //US gündemidnen önce çıkan haberleri getiriyor. Farklı etiketler verilerek değiştirilebilir.
  Future<void> getNewsGeneral() async {
    var response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey'));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          News newsModel = News(
            element['title'],
            element['description'],
            element['publishedAt'],
            element['urlToImage'],
            element['url'],
            element['source']['name'],
          );

          news.add(newsModel);
        }
      });
    }
  }
}
