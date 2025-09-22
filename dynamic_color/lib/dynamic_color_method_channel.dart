import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dynamic_color_platform_interface.dart';
import 'src/json.dart';

/// An implementation of [DynamicColorPlatform] that uses method channels.
class MethodChannelDynamicColor extends DynamicColorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel("dynamic_color");

  @override
  Future<bool?> isDynamicColorAvailable() async {
    try {
      return await methodChannel.invokeMethod<bool>("isDynamicColorAvailable");
    } on Object {
      return null;
    }
  }

  @override
  Future<Color?> accentColor() async {
    try {
      final argb = await methodChannel.invokeMethod<int>("accentColor");
      return argb != null ? Color(argb) : null;
    } on Object {
      return null;
    }
  }

  @override
  Future<DynamicTonalPalette?> dynamicTonalPalette() async {
    try {
      final json = await methodChannel.invokeMapMethod<String, int>(
        "dynamicTonalPalette",
      );
      return json != null ? DynamicTonalPalette.fromJson(json) : null;
    } on Object {
      return null;
    }
  }

  @override
  Future<DynamicColorScheme?> dynamicLightColorScheme() async {
    try {
      final json = await methodChannel.invokeMapMethod<String, int>(
        "dynamicLightColorScheme",
      );
      return json != null ? DynamicColorScheme.fromJson(json) : null;
    } on Object {
      return null;
    }
  }

  @override
  Future<DynamicColorScheme?> dynamicDarkColorScheme() async {
    try {
      final json = await methodChannel.invokeMapMethod<String, int>(
        "dynamicDarkColorScheme",
      );
      return json != null ? DynamicColorScheme.fromJson(json) : null;
    } on Object {
      return null;
    }
  }

  @override
  Future<DynamicColorSchemes?> dynamicColorSchemes() async {
    try {
      final json = await methodChannel
          .invokeMapMethod<String, Map<Object?, Object?>>("dynamicColorSchemes")
          .then(
            (result) => result?.map(
              (key, value) => MapEntry(key, value.cast<String, int>()),
            ),
          );
      return json != null ? DynamicColorSchemes.fromJson(json) : null;
    } on Object {
      return null;
    }
  }
}
