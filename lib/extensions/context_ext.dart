import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netzpolitik_mobile/localization/app_localizations.dart';


const TRANSITION_DURATION = 300;

extension ContextExteinsions on BuildContext {

  String getString(String key) => AppLocalizations.of(this)?.translate(key) ?? key;

  void navigate(Widget Function(BuildContext) builder, {bool isDialog = false}) => Navigator.of(this).push(
    CupertinoPageRoute(
      builder: (context) => builder(context),
      fullscreenDialog: isDialog,
      barrierDismissible: isDialog,
    ),
  );

  void showBottomSheet({required Widget Function(BuildContext) builder}) => showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: builder,
    context: this,
  );

  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;


  TextStyle get headline1 => Theme.of(this).textTheme.displayLarge!;
  TextStyle get headline2 => Theme.of(this).textTheme.displayMedium!;
  TextStyle get headline3 => Theme.of(this).textTheme.displaySmall!;
  TextStyle get headline4 => Theme.of(this).textTheme.headlineLarge!;
  TextStyle get headline5 => Theme.of(this).textTheme.headlineMedium!;
  TextStyle get headline6 => Theme.of(this).textTheme.headlineSmall!;

  TextStyle get body1 => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get body2 => Theme.of(this).textTheme.bodySmall!;
  TextStyle get quote => Theme.of(this).textTheme.labelSmall!.copyWith(
    fontStyle: FontStyle.italic
  );

  TextStyle get caption => Theme.of(this).textTheme.labelSmall!;

  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get scaffoldColor => Theme.of(this).scaffoldBackgroundColor;
  Color get iconButtonColor => Theme.of(this).colorScheme.primary  ;
  Color get dialogBackground => Theme.of(this).dialogBackgroundColor;
  Color get audioPlayerBackground => Theme.of(this).scaffoldBackgroundColor;

  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get density => MediaQuery.of(this).devicePixelRatio;
  double get statusBarHeight => MediaQuery.of(this).padding.top;

  bool get isWide => width > 700;
  bool get isUltraWide => width > 1100;

}