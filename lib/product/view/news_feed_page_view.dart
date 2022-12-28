import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/project_variables.dart';
import '../view_model/news_feed_page_model.dart';
import '../widgets/custom_card_widget.dart';
import '../widgets/search_widget.dart';

class NewsFeedPage extends StatelessWidget {
  NewsFeedPage({super.key});
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: context.watch<NewsFeedPageModel>().state == NewsFeedPageState.busy
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    CustomSearchWidget(
                      textFormController: _searchController,
                      hintText: 'Type a word',
                      formIcon: Icons.search,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: context.read<NewsFeedPageModel>().news.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: CustomCardWidget(
                                newsModel: context.read<NewsFeedPageModel>().news[index],
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

  void searchButtonClicked() {}
}
