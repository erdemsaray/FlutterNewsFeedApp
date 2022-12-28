import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/project_variables.dart';
import '../view_model/news_details_page_model.dart';

class NewsDetailsPageView extends StatelessWidget {
  const NewsDetailsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    var heightSize = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ProjectColors.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          color: ProjectColors.iconBlackColor,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
              color: ProjectColors.iconBlackColor,
              onPressed: () {
                Provider.of<NewsDetailsPageModel>(context, listen: false).shareButtonClicked();
              },
              icon: const Icon(Icons.share)),
          IconButton(
              color: ProjectColors.iconBlackColor,
              onPressed: () {
                Provider.of<NewsDetailsPageModel>(context, listen: false).addToFavorites();
              },
              icon: Icon(context.watch<NewsDetailsPageModel>().isFavorite ? Icons.favorite : Icons.favorite_border))
        ],
        title: const Text(
          "News Details",
          style: ProjectStyles.titleStyle,
        ),
      ),
      body: SizedBox(
        height: heightSize,
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: heightSize - 110,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Image.network(
                        context.watch<NewsDetailsPageModel>().newsModel.imageURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      context.watch<NewsDetailsPageModel>().newsModel.title,
                      style: ProjectStyles.newsDetailsTitle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DefaultTextStyle(
                      style: ProjectStyles.newsCardBottomDetails,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.source,
                                color: ProjectColors.iconBlackColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(context.watch<NewsDetailsPageModel>().newsModel.source),
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.date_range,
                                color: ProjectColors.iconBlackColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(context.watch<NewsDetailsPageModel>().newsModel.date.split('T').first)
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      context.watch<NewsDetailsPageModel>().newsModel.description,
                      style: ProjectStyles.newsDetailsDetail,
                    ),
                    const Expanded(child: SizedBox(height: 40)),
                    ElevatedButton(
                        onPressed: () {
                          Provider.of<NewsDetailsPageModel>(context, listen: false).webviewButtonClicked(context);
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(const Size(200, 40)),
                          backgroundColor: MaterialStateProperty.all(ProjectColors.elevatedButtonColorDark),
                        ),
                        child: Text(
                          "News Source",
                          style: TextStyle(color: ProjectColors.iconTextColorLight, fontSize: 18),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
