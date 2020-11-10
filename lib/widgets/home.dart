import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wordpress_blog_app_template/widgets/custom_views/wp_appbar.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/articles/articles_widget.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/settings_widget.dart';
import 'package:wordpress_blog_app_template/widgets/dashboard/categories/categories_widget.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';


class Home extends StatefulWidget {

  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WPAppBar(widget.title),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 8.0,
          showUnselectedLabels: false,
          currentIndex: _currentIndex,
          items: BOTTOM_NAV_ITEMS.map((viewHolder) => BottomNavigationBarItem(
              label: context.getString(viewHolder.titleKey),
              icon: FaIcon(viewHolder.icon)
          )).toList(),
          onTap: (index) => setState(() => _currentIndex = index)
      ),
      body: IndexedStack(
        children: BOTTOM_NAV_ITEMS.map((e) => e.child).toList(),
        index: _currentIndex,
      )
    );
  }
}

const BOTTOM_NAV_ITEMS = [
  BottomNavItemViewHolder(icon: FontAwesomeIcons.newspaper, titleKey: 'articles', child: ArticlesWidget()),
  BottomNavItemViewHolder(icon: FontAwesomeIcons.stream, titleKey: 'topics', child: CategoriesWidget()),
  BottomNavItemViewHolder(icon: FontAwesomeIcons.tools, titleKey: 'settings', child: SettingsWidget()),
];

class BottomNavItemViewHolder {

  final String titleKey;
  final IconData icon;
  final Widget child;

  const BottomNavItemViewHolder({this.titleKey, this.icon, this.child});

}