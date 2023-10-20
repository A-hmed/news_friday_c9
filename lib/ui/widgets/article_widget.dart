import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_friday_c9/data/model/articles_response.dart';
import 'package:news_friday_c9/ui/widgets/loading_widget.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: article.urlToImage ?? "",
              placeholder: (_, __) => LoadingWidget(),
              errorWidget: (_, __, ___) => Icon(Icons.error),
              height: MediaQuery.of(context).size.height * .1,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 4,),
          Text(article.source?.name ?? ""),
          SizedBox(height: 4,),
          Text(article.title ?? ""),
          SizedBox(height: 4,),
          Text(article.publishedAt ?? "", textAlign: TextAlign.end,)
        ],
      ),
    );
  }
}
