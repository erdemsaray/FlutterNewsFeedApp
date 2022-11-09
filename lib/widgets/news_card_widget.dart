import 'package:flutter/material.dart';
import 'package:newsapp/utils/project_variables.dart';
import 'package:newsapp/views/news_details_page.dart';

class NewsCardWidget extends StatelessWidget {
  const NewsCardWidget(
      {super.key,
      required this.newsTitle,
      required this.newsImageURL,
      required this.newsDetails,
      required this.newsURL,
      required this.newsDate,
      required this.newsSource});

  final String newsTitle;
  final String newsImageURL;
  final String newsDetails;
  final String newsURL;
  final String newsDate;
  final String newsSource;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: ProjectColors.splashColor,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => NewsDetailsPage(
                  newsTitle: newsTitle,
                  newsImageURL: newsImageURL,
                  newsDetails: newsDetails,
                  newsURL: newsURL,
                  newsDate: newsDate,
                  newsSource: newsSource)),
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
                  newsImageURL,
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
                    newsTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    newsDetails,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DefaultTextStyle(
                    style: ProjectStyles.newsCardBottomDetails,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('Source: $newsSource'), Text('Date: ${newsDate.split('T').first}')],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
