import 'package:flutter/material.dart';
import 'package:newsapp/controllers/favorite_news_controller.dart';
import 'package:newsapp/modals/news.dart';
import 'package:newsapp/utils/project_variables.dart';
import 'package:newsapp/views/news_webview_page.dart';
import 'package:share_plus/share_plus.dart';

class NewsDetailsPage extends StatefulWidget {
  final News newsModel;

  const NewsDetailsPage({super.key, required this.newsModel});

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

FavoriteNewsController _favoriteNewsController = FavoriteNewsController();
bool isFavorited = false;

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  @override
  void initState() {
    isFavorited = false;
    super.initState();
  }

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
              onPressed: () async {
                await Share.share('Share this link with your connections!', subject: widget.newsModel.newsURL);
              },
              icon: const Icon(Icons.share)),
          IconButton(
              color: ProjectColors.iconBlackColor,
              onPressed: () {
                setState(() {
                  isFavorited = !isFavorited;
                  _favoriteNewsController.addToFavorites(widget.newsModel);
                });
              },
              icon: Icon(isFavorited ? Icons.favorite : Icons.favorite_border))
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
                        widget.newsModel.imageURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.newsModel.title,
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
                              Text(widget.newsModel.source),
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
                              Text(widget.newsModel.date.split('T').first)
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.newsModel.description,
                      style: ProjectStyles.newsDetailsDetail,
                    ),
                    const Expanded(child: SizedBox(height: 40)),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => (NewsWebViewPage(
                                      newsURL: widget.newsModel.newsURL,
                                    ))),
                          );
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
