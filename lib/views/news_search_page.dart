import 'package:flutter/material.dart';
import 'package:newsapp/controllers/news_controller.dart';
import 'package:newsapp/utils/project_variables.dart';
import 'package:newsapp/widgets/custom_card_widget.dart';

class NewsSearchPage extends StatefulWidget {
  final String searchValue;
  const NewsSearchPage({super.key, required this.searchValue});

  @override
  State<NewsSearchPage> createState() => _NewsSearchPageState();
}

class _NewsSearchPageState extends State<NewsSearchPage> {
  final NewsController _newsController = NewsController();
  bool loading = true;

  void getNewsData() async {
    await _newsController.getNews(widget.searchValue, 1);
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
              Text(
                "Result for: ${widget.searchValue}",
                style: ProjectStyles.resultTextStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _newsController.news.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: CustomCardWidget(
                              newsModel: _newsController.news[index],
                            ),
                          );
                        }),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
