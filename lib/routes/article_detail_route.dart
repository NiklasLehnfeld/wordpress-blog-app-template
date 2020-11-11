import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_blog_app_template/models/article.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/extensions/int_ext.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_article_appbar.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_html.dart';

class ArticleDetailRoute extends StatelessWidget {
  final Article article;

  ArticleDetailRoute(this.article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WPArticleAppBar(article),
            _buildSummaryArea(context),
            _buildImage(context),
            _buildContentArea(context)
          ],
        ),
      ),
    );
  }

  String get creationDate =>
      '${creation.day.zeroFill(2)}.${creation.month.zeroFill(2)}.${creation.year.zeroFill(4)} um ${creation.hour.zeroFill(2)}:${creation.minute.zeroFill(2)} Uhr';

  DateTime get creation => article.creationTime;

  Widget _buildContentArea(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: WPHtml(article.content),
  );

  Widget _buildSummaryArea(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubtitle(context),
            _buildTitle(context),
            WPHtml(article.summary),
            Text('$creationDate - $authorNames - in $categoryName - $numberOfReplies ${context.getString('replies')}', style: context.body2.copyWith( fontWeight: FontWeight.bold)),
            SizedBox(height: 12)
          ],
        ),
      );
  
  String get authorNames => article.authors.map((a) => a.name).join(', ');
  String get categoryName => article.categories.first.name;

  int get numberOfReplies => article.replies.length;


  Widget _buildTitle(BuildContext context) => Text(
    article.title,
    style: context.headline1.copyWith(color: Colors.black),
  );

  Widget _buildSubtitle(BuildContext context) => Text(article.subTitle, style: context.headline2);

  Widget _buildImage(BuildContext context) => Image.network(
    article.imageUrl,
    fit: BoxFit.fitWidth,
    width: context.width,
  );
}
