import 'package:flutter/material.dart';
import 'package:newsapp/controllers/favorite_news_controller.dart';
import 'package:newsapp/utils/project_variables.dart';
import 'package:newsapp/widgets/custom_card_widget.dart';

class FavoriteNewsPage extends StatefulWidget {
  const FavoriteNewsPage({super.key});

  @override
  State<FavoriteNewsPage> createState() => _FavoriteNewsPageState();
}

class _FavoriteNewsPageState extends State<FavoriteNewsPage> {
  final FavoriteNewsController _favoriteNewsController = FavoriteNewsController();
  bool loading = true; //favoriler yüklenene kadar circular progress indicator

  void getNewsData() async {
    await _favoriteNewsController.getFavoriteNews();
    if (mounted) {
      //favoriler gelmeden page'in dispose durumunda mounted kullanmazsak hata verir.
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getNewsData();
  }

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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.favorite,
                          color: ProjectColors.iconBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                      child: loading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: _favoriteNewsController.favoriteNews.length,
                              itemBuilder: ((context, index) {
                                return Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: CustomCardWidget(
                                      newsModel: _favoriteNewsController.favoriteNews[index],
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
