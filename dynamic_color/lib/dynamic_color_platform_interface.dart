import 'dart:ui' show Color;

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'dynamic_color_method_channel.dart';

import 'src/json.dart';

abstract class DynamicColorPlatform extends PlatformInterface {
  /// Constructs a DynamicColorPlatform.
  DynamicColorPlatform() : super(token: _token);

  static final Object _token = Object();

  static DynamicColorPlatform _instance = MethodChannelDynamicColor();

  /// The default instance of [DynamicColorPlatform] to use.
  ///
  /// Defaults to [MethodChannelDynamicColor].
  static DynamicColorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DynamicColorPlatform] when
  /// they register themselves.
  static set instance(DynamicColorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> isDynamicColorAvailable() {
    throw UnimplementedError(
      "isDynamicColorAvailable() has not been implemented.",
    );
  }

  Future<Color?> accentColor() {
    throw UnimplementedError("accentColor() has not been implemented.");
  }

  Future<DynamicTonalPalette?> dynamicTonalPalette() {
    throw UnimplementedError("dynamicTonalPalette() has not been implemented.");
  }

  Future<DynamicColorScheme?> dynamicLightColorScheme() {
    throw UnimplementedError(
      "dynamicLightColorScheme() has not been implemented.",
    );
  }

  Future<DynamicColorScheme?> dynamicDarkColorScheme() {
    throw UnimplementedError(
      "dynamicDarkColorScheme() has not been implemented.",
    );
  }

  Future<DynamicColorSchemes?> dynamicColorSchemes() {
    throw UnimplementedError("dynamicColorSchemes() has not been implemented.");
  }
}
