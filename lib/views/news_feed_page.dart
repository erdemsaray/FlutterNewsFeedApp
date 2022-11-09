import 'package:flutter/material.dart';
import 'package:newsapp/controllers/news_controller.dart';
import 'package:newsapp/utils/project_variables.dart';
import 'package:newsapp/views/news_search_page.dart';
import 'package:newsapp/widgets/custom_card_widget.dart';
import 'package:newsapp/widgets/search_widget.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  final TextEditingController _searchController = TextEditingController();
  final NewsController _newsController = NewsController();
  bool loading = true;

  void getNewsData() async {
    //kullanıcıyı ilk karşılayan feeds sayfasında, genel haber akışına yer veriyoruz. Bu sayfada kullanıcı anahtar kelimeye göre arama yapabiliyor.
    await _newsController.getNewsGeneral();
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getNewsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              CustomSearchWidget(
                  textFormController: _searchController,
                  hintText: 'Type a word',
                  formIcon: Icons.search,
                  searchClicked: searchButtonClicked),
              const SizedBox(
                height: 10,
              ),
              loading
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _newsController.news.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: CustomCardWidget(
                                newsModel: _newsController.news[index],
                                erasable: false,
                              ));
                        }),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void searchButtonClicked() {
    if (_searchController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NewsSearchPage(
            searchValue: _searchController.text,
          ),
        ),
      );
    }
  }
}
