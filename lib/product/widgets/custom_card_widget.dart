import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/project_variables.dart';
import '../model/news.dart';
import '../service/favorite_service.dart';
import '../view/news_details_page_view.dart';
import '../view_model/news_details_page_model.dart';

class CustomCardWidget extends StatefulWidget {
  final News newsModel;
  final bool erasable;
  const CustomCardWidget({
    super.key,
    required this.newsModel,
    required this.erasable,
  });

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  final FavoriteService _favoriteNewsController = FavoriteService();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: ProjectColors.splashColor,
      onTap: () {
        if (widget.erasable) {
          setState(() {
            _favoriteNewsController.clearFavoriteNews(widget.newsModel);
          });
        } else {
          Provider.of<NewsDetailsPageModel>(context, listen: false).changeNewsModel(widget.newsModel);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NewsDetailsPageView(),
            ),
          );
        }
      },
      child: Card(
        color: ProjectColors.cardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: ListTile(
            trailing: Padding(
              padding: const EdgeInsets.all(6.0),
              child: SizedBox(
                width: 80,
                child: Image.network(
                  widget.newsModel.imageURL,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.newsModel.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, color: ProjectColors.textColorBlack, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.newsModel.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: ProjectColors.textColorBlack,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DefaultTextStyle(
                    style: ProjectStyles.newsCardBottomDetails,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Source: ${widget.newsModel.source}'),
                        Text('Date: ${widget.newsModel.date.split('T').first}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
