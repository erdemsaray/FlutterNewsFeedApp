import 'package:flutter/material.dart';
import 'package:newsapp/controllers/favorite_news_controller.dart';
import 'package:newsapp/modals/news.dart';
import 'package:newsapp/utils/project_variables.dart';
import 'package:newsapp/views/news_webview_page.dart';
import 'package:share_plus/share_plus.dart';

class NewsDetailsPage extends StatefulWidget {
  final String newsTitle;
  final String newsImageURL;
  final String newsDetails;
  final String newsURL;
  final String newsDate;
  final String newsSource;

  const NewsDetailsPage(
      {super.key,
      required this.newsTitle,
      required this.newsImageURL,
      required this.newsDetails,
      required this.newsURL,
      required this.newsDate,
      required this.newsSource});

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

FavoriteNewsController _favoriteNewsController = FavoriteNewsController();
bool isFavorite = false;

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var heightSize = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
              color: Colors.black,
              onPressed: () async {
                await Share.share('Share this link with your connections!', subject: widget.newsURL);
              },
              icon: const Icon(Icons.share)),
          IconButton(
              color: Colors.black,
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                  News newModel = News(widget.newsTitle, widget.newsDetails, widget.newsDate, widget.newsImageURL,
                      widget.newsURL, widget.newsSource);

                  _favoriteNewsController.addToFavorites(newModel);
                });
              },
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border))
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
                        widget.newsImageURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.newsTitle,
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
                              const Icon(
                                Icons.source,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(widget.newsSource),
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.date_range,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(widget.newsDate.split('T').first)
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.newsDetails,
                      style: ProjectStyles.newsDetailsDetail,
                    ),
                    const Expanded(child: SizedBox(height: 40)),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => (NewsWebviewPage(
                                      newsURL: widget.newsURL,
                                    ))),
                          );
                        },
                        child: const Text(
                          "News Source",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(const Size(200, 40)),
                          backgroundColor: MaterialStateProperty.all(Colors.black54),
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
