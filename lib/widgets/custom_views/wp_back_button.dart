import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wordpress_blog_app_template/extensions/context_ext.dart';

const ICON_SIZE = 25.0;

class WPBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: FaIcon(
        FontAwesomeIcons.arrowCircleLeft,
        color: context.iconButtonColor,
        size: ICON_SIZE,
      ),
    );
  }

}