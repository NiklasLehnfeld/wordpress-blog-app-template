import 'package:wordpress_blog_app_template/app_specific/netzpolitik_title.dart';
import 'package:wordpress_blog_app_template/config/app_configuration.dart';
import 'package:wordpress_blog_app_template/config/rest_configuration.dart';

const _APP_CONFIGS = {
  App.NETZPOLITIK: AppConfiguration(name: 'NETZPOLITIK.ORG', restConfiguration: RestConfiguration(baseUrl: 'https://netzpolitik.org'), title: NetzpolitikTitle())
};

enum App { NETZPOLITIK }

extension AppConfigurations on App {
  AppConfiguration get configuration => _APP_CONFIGS[this];
}