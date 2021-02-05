library paging;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/articles/article_image.dart';

typedef PaginationBuilder<T> = Future<List<T>> Function(int currentListSize);

typedef ItemWidgetBuilder<T> = Widget Function(int index, T item, bool isBig);

const ERROR_ICON_SIZE = 70.0;

const LIST_ITEM_SPACING = 15.0;

class WPGridPagination<T> extends StatefulWidget {
  WPGridPagination({
    Key key,
    @required this.pageBuilder,
    @required this.itemBuilder,
    this.enableSingleTop = true,
    this.childAspectRatio = ArticleImage.IMAGE_ASPECT_RATIO,
    this.errorLabel,
  })
      : assert(pageBuilder != null),
        assert(itemBuilder != null),
        super(key: key);

  final PaginationBuilder<T> pageBuilder;
  final ItemWidgetBuilder<T> itemBuilder;
  final double childAspectRatio;
  final String errorLabel;
  final bool enableSingleTop;

  @override
  _WPGridPaginationState<T> createState() => _WPGridPaginationState<T>();
}

class _WPGridPaginationState<T> extends State<WPGridPagination<T>> {
  final List<T> _list = [];
  bool _isLoading = false;
  bool _isError = false;
  bool _isEndOfList = false;

  void fetchMore() {
    if (!_isLoading) {
      _isLoading = true;
      widget.pageBuilder(_list.length).then((list) {
        _isLoading = false;
        if (list.isEmpty) {
          _isEndOfList = true;
        }
        setState(() {
          _list.addAll(list);
        });
      }).catchError((error) {
        setState(() {
          _isEndOfList = true;
          _isError = true;
        });
        print(error);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMore();
  }

  @override
  Widget build(BuildContext context) {
    if (_isError) {
      return errorWidget(context);
    }

    if (_list.isEmpty) {
      return defaultLoading();
    }

    var colCount = context.isUltraWide ? 2 : 1;

    return GridView.builder(
      itemCount: _list.length + 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: colCount,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemBuilder: (BuildContext context, int position) {
        if (position < _list.length) {
          return widget.itemBuilder(position, _list[position], false);
        } else if (position == _list.length && !_isEndOfList) {
          fetchMore();
          return defaultLoading();
        }
        return Container();
      });
  }

  Widget defaultLoading() {
    return Align(
      child: SizedBox(
        height: 40,
        width: 40,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget errorWidget(BuildContext context) =>
      Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              IconButton(
                  iconSize: ERROR_ICON_SIZE,
                  icon: FaIcon(
                    FontAwesomeIcons.syncAlt,
                    color: context.primaryColor,
                  ),
                  onPressed: () {
                    setState(() => _isError = false);
                    fetchMore();
                  }),
              Container(
                width: 300,
                child: Text(
                  widget.errorLabel,
                  style: context.headline6,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      );
}
