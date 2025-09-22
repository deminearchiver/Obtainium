// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
// import 'package:web/web.dart' as web;

import 'dynamic_color_platform_interface.dart';

/// A web implementation of the DynamicColorPlatform of the DynamicColor plugin.
class DynamicColorWeb extends DynamicColorPlatform {
  /// Constructs a DynamicColorWeb
  DynamicColorWeb();

  static void registerWith(Registrar registrar) {
    DynamicColorPlatform.instance = DynamicColorWeb();
  }

  // /// Returns a [String] containing the version of the platform.
  // @override
  // Future<String?> getPlatformVersion() async {
  //   final version = web.window.navigator.userAgent;
  //   return version;
  // }
}
