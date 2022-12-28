import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/project_variables.dart';
import '../view_model/favorite_news_page_model.dart';
import '../widgets/custom_card_widget.dart';

class NewsFavoritePageView extends StatelessWidget {
  const NewsFavoritePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.scaffoldBackgroundColor,
      body: SizedBox(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Text(
                        "User Favorites",
                        style: ProjectStyles.titleStyle,
                      ),
                      const Expanded(
                          child: SizedBox(
                        width: 10,
                      )),
                      ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: context.watch<FavoriteNewsPageModel>().isClearButtonClicked
                                  ? MaterialStateProperty.all(Colors.grey[300])
                                  : MaterialStateProperty.all(Colors.transparent)),
                          onPressed: () =>
                              Provider.of<FavoriteNewsPageModel>(context, listen: false).clearButtonClick(),
                          child: Icon(
                            Icons.clear_sharp,
                            color: ProjectColors.iconRedColor,
                            size: 30,
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                      child: context.watch<FavoriteNewsPageModel>().state == FavoriteNewsPageStatus.busy
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: context.watch<FavoriteNewsPageModel>().news.length,
                              itemBuilder: ((context, index) {
                                return Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: CustomCardWidget(
                                      newsModel: context.watch<FavoriteNewsPageModel>().news[index],
                                      erasable: context.watch<FavoriteNewsPageModel>().isClearButtonClicked,
                                    ));
                              }),
                            )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
