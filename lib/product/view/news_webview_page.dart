import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../view_model/news_webiew_page_model.dart';

class NewsWebViewPageView extends StatefulWidget {
  const NewsWebViewPageView({Key? key}) : super(key: key);

  @override
  State<NewsWebViewPageView> createState() => _NewsWebViewPageViewState();
}

class _NewsWebViewPageViewState extends State<NewsWebViewPageView> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: context.watch<NewsWebViewPageModel>().newsURL,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(),
        ],
      ),
    );
  }
}
