import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/project_variables.dart';
import '../view_model/news_search_page_model.dart';
import '../widgets/custom_card_widget.dart';

class NewsSearchPageView extends StatelessWidget {
  const NewsSearchPageView({super.key, required this.query});
  final String query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: context.watch<NewsSearchPageModel>().state == NewsSearchPageState.busy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Text(
                      "Result for: ${context.watch<NewsSearchPageModel>().searchText}",
                      style: ProjectStyles.resultTextStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: context.watch<NewsSearchPageModel>().news.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: CustomCardWidget(
                              newsModel: context.watch<NewsSearchPageModel>().news[index],
                              erasable: false,
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
