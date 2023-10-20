import 'package:flutter/material.dart';
import 'package:news_friday_c9/data/api/api_manager.dart';
import 'package:news_friday_c9/data/model/sources_response.dart';
import 'package:news_friday_c9/ui/widgets/error_view.dart';
import 'package:news_friday_c9/ui/widgets/loading_widget.dart';

import 'news_list.dart';

class NewsTab extends StatefulWidget {
  final String category;
  const NewsTab(this.category, {super.key});

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManager.getSources(widget.category),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildTabs(snapshot.data!);
          } else if (snapshot.hasError) {
            return ErrorView(message: snapshot.error.toString());
          } else {
            return LoadingWidget();
          }
        });
  }

  Widget buildTabs(List<Source> sourcesList) => DefaultTabController(
        length: sourcesList.length,
        child: Column(
          children: [
            SizedBox(height: 8,),
            TabBar(
                isScrollable: true,
                indicatorColor: Colors.transparent,
                onTap: (index){
                  currentTabIndex = index;
                  setState(() {});
                },
                tabs: sourcesList
                    .map((singleSource) =>
                        buildTabWidget(singleSource.name ?? ""
                          , currentTabIndex == sourcesList.indexOf(singleSource)))
                    .toList()),
            Expanded(
              child: TabBarView(
                  children: sourcesList
                      .map((singleSource) => NewsList(singleSource.id!))
                      .toList()),
            )
          ],
        ),
      );

  Widget buildTabWidget(String sourceName, bool isSelected) =>
      Container(
        padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.blue, width: 1)
          ),
          child: Text(sourceName,
              style: TextStyle(color:isSelected? Colors.white: Colors.blue)));
}
