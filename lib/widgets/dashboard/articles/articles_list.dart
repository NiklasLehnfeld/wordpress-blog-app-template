import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/models/article.dart';
import 'package:wordpress_blog_app_template/models/category.dart';
import 'package:wordpress_blog_app_template/rest/rest_client.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_paged_list.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/articles/article_list_entry.dart';


class ArticlesList extends StatefulWidget {
  final Category categoryFilter;
  final String contentFilter;

  ArticlesList({this.categoryFilter, this.contentFilter});

  @override
  _ArticlesListState createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return WPPagedList<Article>(
      itemBuilder: (article) => ArticleListEntry(article),
      pageBuilder: (listSize) => loadData(context, listSize),
      errorMessage: context.getString('article_loading_error'),
    );
  }

  Future<List<Article>> loadData(
      BuildContext context, int currentListSize) async {
    var restClient = context.read<RestClient>();

    var page = (currentListSize / restClient.pageSize).ceil() + 1;

    var result = await restClient.fetchArticles(
        page: page,
        category: widget.categoryFilter,
        searchTerm: widget.contentFilter);

    result = result.where((element) => element.imageName != null).toList();

    return result;
  }

}
