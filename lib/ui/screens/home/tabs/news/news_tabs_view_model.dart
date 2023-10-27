import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_friday_c9/data/api/api_manager.dart';
import 'package:news_friday_c9/data/model/sources_response.dart';

class NewsTabsViewModel extends Cubit{
  NewsTabsViewModel(): super(NewsTabLoadingState());

  getSources(String category) async {
    try{
    //  isLoading = true;
      emit(NewsTabLoadingState());
      var sources = await ApiManager.getSources(category);
       //isLoading = false;
       emit(NewsTabSuccessState(sources));
    }catch(e){
   //   isLoading = false;
    //  errorMessage = e.toString();
      emit(NewsTabErrorState(e.toString()));
    }
  }
}
class NewsTabSuccessState{
  List<Source> sources;
  NewsTabSuccessState(this.sources);
}
class NewsTabLoadingState{}
class NewsTabErrorState{
  String errorMessage;
  NewsTabErrorState(this.errorMessage);
}

class A{
  A(int x);
}
class B extends A{
  B(): super(5);

}