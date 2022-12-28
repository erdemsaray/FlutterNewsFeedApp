import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'product/view/homepage.dart';
import 'product/view_model/favorite_news_page_model.dart';
import 'product/view_model/news_details_page_model.dart';
import 'product/view_model/news_feed_page_model.dart';
import 'product/view_model/news_search_page_model.dart';
import 'product/view_model/news_webiew_page_model.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<NewsFeedPageModel>(
      create: (context) => NewsFeedPageModel(),
    ),
    ChangeNotifierProvider<NewsSearchPageModel>(
      create: (context) => NewsSearchPageModel(),
    ),
    ChangeNotifierProvider<NewsDetailsPageModel>(
      create: (context) => NewsDetailsPageModel(),
    ),
    ChangeNotifierProvider<FavoriteNewsPageModel>(
      create: (context) => FavoriteNewsPageModel(),
    ),
    ChangeNotifierProvider<NewsWebViewPageModel>(
      create: (context) => NewsWebViewPageModel(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Feed App',
      theme: ThemeData.dark().copyWith(
        progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.grey),
        listTileTheme: const ListTileThemeData(contentPadding: EdgeInsets.zero),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: const HomePage(),
    );
  }
}
