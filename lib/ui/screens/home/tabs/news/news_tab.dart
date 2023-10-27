import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_friday_c9/ui/screens/home/tabs/news/news_tabs_view_model.dart';
import 'package:news_friday_c9/ui/widgets/error_view.dart';
import 'package:news_friday_c9/ui/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../data/model/sources_response.dart';
import 'news_list.dart';

class NewsTab extends StatefulWidget {
  final String category;

  const NewsTab(this.category, {super.key});

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  int currentTabIndex = 0;
  NewsTabsViewModel newsTabsViewModel = NewsTabsViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      newsTabsViewModel.getSources(widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsTabsViewModel, dynamic>(
        bloc: newsTabsViewModel,
        builder: (context, state){
          Widget currentWidget = const SizedBox();
          if (state is NewsTabLoadingState) {
            currentWidget = const LoadingWidget();
          } else if (state is NewsTabSuccessState) {
            currentWidget = buildTabs(state.sources);
          } else  {
            currentWidget = ErrorView(message: (state as NewsTabErrorState).errorMessage);
          }
          return currentWidget;
        }
    );
  }

  Widget buildTabs(List<Source> sources) => DefaultTabController(
        length: sources.length,
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            TabBar(
                isScrollable: true,
                indicatorColor: Colors.transparent,
                onTap: (index) {
                  currentTabIndex = index;
                  setState(() {});
                },
                tabs: sources
                    .map((singleSource) => buildTabWidget(
                        singleSource.name ?? "",
                        currentTabIndex ==
                            sources.indexOf(singleSource)))
                    .toList()),
            Expanded(
              child: TabBarView(
                  children: sources
                      .map((singleSource) => NewsList(singleSource.id!))
                      .toList()),
            )
          ],
        ),
      );

  Widget buildTabWidget(String sourceName, bool isSelected) => Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.blue, width: 1)),
      child: Text(sourceName,
          style: TextStyle(color: isSelected ? Colors.white : Colors.blue)));
}
