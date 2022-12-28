import 'package:flutter/material.dart';

import '../constants/project_variables.dart';
import 'favorite_news_page_view.dart';
import 'news_feed_page_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true, //butonun arkasının saydam olması
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: showFab
            ? FloatingActionButton(
                backgroundColor: Colors.transparent,
                child: const Icon(Icons.newspaper, size: 60),
                onPressed: () {
                  if (_tabController.index == 1) {
                    _tabController.animateTo(0);
                  } else {
                    _tabController.animateTo(1);
                  }
                },
              )
            : null,
        bottomNavigationBar: BottomAppBar(
          notchMargin: 10,
          shape: const CircularNotchedRectangle(),
          child: TabBar(
            indicatorColor: ProjectColors.splashColor,
            labelColor: ProjectColors.labelColor,
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'News Feed',
              ),
              Tab(text: 'Favorites')
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'News App',
            style: ProjectStyles.titleStyle,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [NewsFeedPage(), const NewsFavoritePageView()],
        ),
      ),
    );
  }
}
