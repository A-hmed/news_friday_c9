import 'package:flutter/material.dart';
import 'package:news_friday_c9/data/api/api_manager.dart';
import 'package:news_friday_c9/data/model/sources_response.dart';

class NewsTabsViewModel extends ChangeNotifier{
  List<Source> sources = [];
  bool isLoading = false;
  String? errorMessage;

  getSources(String category) async {
    try{
      isLoading = true;
      notifyListeners();
      sources = await ApiManager.getSources(category);
       isLoading = false;
       notifyListeners();
    }catch(e){
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

}