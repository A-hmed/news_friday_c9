import 'package:flutter/material.dart';
import 'package:news_friday_c9/data/api/api_manager.dart';
import 'package:news_friday_c9/data/model/articles_response.dart';
import 'package:news_friday_c9/ui/widgets/article_widget.dart';
import 'package:news_friday_c9/ui/widgets/error_view.dart';
import 'package:news_friday_c9/ui/widgets/loading_widget.dart';

class NewsList extends StatelessWidget {
  final String sourceId;

  const NewsList(this.sourceId, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManager.getArticles(sourceId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildListView(snapshot.data!);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget();
          } else {
            return ErrorView(message: snapshot.error.toString());
          }
        });
  }

  Widget buildListView(List<Article> articlesList) {
    return ListView.builder(
        itemCount: articlesList.length,
        itemBuilder: (context, index) =>
            ArticleWidget(article: articlesList[index]));
  }
}
