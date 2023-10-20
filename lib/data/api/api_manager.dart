import 'dart:convert';

import 'package:http/http.dart';
import 'package:news_friday_c9/data/model/articles_response.dart';
import 'package:news_friday_c9/data/model/sources_response.dart';

abstract class ApiManager {
  static const baseUrl = "newsapi.org";
  static const sourcesApi = "/v2/top-headlines/sources";
  static const articlesApi = "/v2/everything";
  static const apiKey = "a2803275cc264f5ab82151862011361a";

  static Future<List<Source>> getSources(String category) async {
    Uri url = Uri.parse("https://$baseUrl$sourcesApi?apiKey=$apiKey&category=$category");
    Response serverResponse = await get(url);
    Map json = jsonDecode(serverResponse.body);
    SourcesResponse sourcesResponse = SourcesResponse.fromJson(json);
    print("Sources api response: $json");
    if (serverResponse.statusCode >= 200 &&
        serverResponse.statusCode < 300 &&
        sourcesResponse.sources?.isNotEmpty == true) {
      return sourcesResponse.sources!;
    } else {
      throw Exception("Something went wrong please try again later");
    }
  }

  static Future<List<Article>> getArticles(String source) async {
    // Uri url = Uri.
    // parse("https://newsapi.org/v2/everything?apiKey=a2803275cc264f5ab82151862011361a&sources=al-jazeera-english");
    //
    Uri url =
        Uri.https(baseUrl, articlesApi, {"apiKey": apiKey, "sources": source});
    Response serverResponse = await get(url);
    Map json = jsonDecode(serverResponse.body);
    ArticlesResponse articlesResponse = ArticlesResponse.fromJson(json);
    print("Articles api response: $json");
    if (serverResponse.statusCode >= 200 &&
        serverResponse.statusCode < 300 &&
        articlesResponse.articles?.isNotEmpty == true) {
      return articlesResponse.articles!;
    }
    throw "Something went wrong please try again later";
  }
}
