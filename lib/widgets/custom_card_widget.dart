import 'package:flutter/material.dart';
import 'package:newsapp/modals/news.dart';
import 'package:newsapp/utils/project_variables.dart';
import 'package:newsapp/views/news_details_page.dart';

class CustomCardWidget extends StatelessWidget {
  final News newsModel;
  const CustomCardWidget({
    super.key,
    required this.newsModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: ProjectColors.splashColor,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NewsDetailsPage(
              newsModel: newsModel,
            ),
          ),
        );
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
                  newsModel.imageURL,
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
                    newsModel.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, color: ProjectColors.textColorBlack, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    newsModel.description,
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
                      children: [Text('Source: ${newsModel.source}'), Text('Date: ${newsModel.date.split('T').first}'),],
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
