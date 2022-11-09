import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebviewPage extends StatefulWidget {
  String newsURL;
  NewsWebviewPage({Key? key, required this.newsURL}) : super(key: key);

  @override
  State<NewsWebviewPage> createState() => _NewsWebviewPageState();
}

class _NewsWebviewPageState extends State<NewsWebviewPage> {
  bool isLoading = true;
  late WebViewController _controller;
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
            initialUrl: widget.newsURL,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(),
        ],
      ),
    );
  }
}
