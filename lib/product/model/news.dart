import 'dart:convert';

//haber model sınıfı
class News {
  late String title;
  late String description;
  late String date;
  late String imageURL;
  late String newsURL;
  late String source;

  News(this.title, this.description, this.date, this.imageURL, this.newsURL, this.source);

  factory News.fromJson(Map<String, dynamic> jsonData) {
    return News(
      jsonData['title'],
      jsonData['description'],
      jsonData['date'],
      jsonData['imageURL'],
      jsonData['newsURL'],
      jsonData['source'],
    );
  }

  static Map<String, dynamic> toMap(News news) => {
        'title': news.title,
        'description': news.description,
        'date': news.date,
        'imageURL': news.imageURL,
        'newsURL': news.newsURL,
        'source': news.source,
      };

//encode - decode işlemlerini elimizdeki favoriteNews listesini dönüştürerek shared preferences ile lokale kaydetmek için kullanıyoruz.

  static String encode(List<News> news) => json.encode(
        news.map<Map<String, dynamic>>((news2) => News.toMap(news2)).toList(),
      );
//Favorileri kaydetmek için farklı yollar da izlenebilir.

  static List<News> decode(String news) =>
      (json.decode(news) as List<dynamic>).map<News>((item) => News.fromJson(item)).toList();
}
