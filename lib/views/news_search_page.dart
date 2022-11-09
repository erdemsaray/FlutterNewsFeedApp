import 'package:flutter/material.dart';
import 'package:newsapp/controllers/news_controller.dart';
import 'package:newsapp/utils/project_variables.dart';
import 'package:newsapp/widgets/news_card_widget.dart';

class NewsSearchPage extends StatefulWidget {
  final String searchValue;
  const NewsSearchPage({super.key, required this.searchValue});

  @override
  State<NewsSearchPage> createState() => _NewsSearchPageState();
}

class _NewsSearchPageState extends State<NewsSearchPage> {
  NewsController _newsController = NewsController();
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
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  "Result for: ${widget.searchValue}",
                  style: ProjectStyles.resultTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                loading
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: Container(
                            child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 10,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: NewsCardWidget(
                                newsTitle: _newsController.news[index].title,
                                newsImageURL: _newsController.news[index].imageURL,
                                newsDetails: _newsController.news[index].description,
                                newsURL: _newsController.news[index].newsURL,
                                newsDate: _newsController.news[index].date,
                                newsSource: _newsController.news[index].source,
                              ),
                            );
                          }),
                          
                        )

                            
                            ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
