import 'package:flutter/material.dart';
import 'package:newsapp/controllers/favorite_news_controller.dart';
import 'package:newsapp/modals/news.dart';
import 'package:newsapp/utils/project_variables.dart';
import 'package:newsapp/views/news_details_page.dart';

class CustomCardWidget extends StatefulWidget {
  final News newsModel;
  final bool erasable;
  CustomCardWidget({
    super.key,
    required this.newsModel,
    required this.erasable,
  });

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  final FavoriteNewsController _favoriteNewsController = FavoriteNewsController();

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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NewsDetailsPage(
                newsModel: widget.newsModel,
              ),
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
