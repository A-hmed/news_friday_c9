import 'package:flutter/material.dart';
import 'package:news_friday_c9/ui/screens/home/tabs/news/news_tabs_view_model.dart';
import 'package:news_friday_c9/ui/widgets/error_view.dart';
import 'package:news_friday_c9/ui/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

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

    return ChangeNotifierProvider(
      create: (_) => newsTabsViewModel,
      child: Consumer<NewsTabsViewModel>(
          builder: (context, viewModel, _){
            Widget currentWidget = const SizedBox();
            if (newsTabsViewModel.isLoading) {
              currentWidget = const LoadingWidget();
            } else if (newsTabsViewModel.sources.isNotEmpty) {
              currentWidget = buildTabs();
            } else if (newsTabsViewModel.errorMessage != null) {
              currentWidget = ErrorView(message: newsTabsViewModel.errorMessage!);
            }
            return currentWidget;
          }
      ),
    );
  }

  Widget buildTabs() => DefaultTabController(
        length: newsTabsViewModel.sources.length,
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
                tabs: newsTabsViewModel.sources
                    .map((singleSource) => buildTabWidget(
                        singleSource.name ?? "",
                        currentTabIndex ==
                            newsTabsViewModel.sources.indexOf(singleSource)))
                    .toList()),
            Expanded(
              child: TabBarView(
                  children: newsTabsViewModel.sources
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
