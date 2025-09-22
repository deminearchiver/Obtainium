package dev.deminearchiver.dynamic_color

import com.google.android.material.color.DynamicColors
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class DynamicColorPlugin : FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel

  private lateinit var binding: FlutterPluginBinding

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "dynamic_color")
    channel.setMethodCallHandler(this)
    binding = flutterPluginBinding
  }

  override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "isDynamicColorAvailable" -> {
        result.success(DynamicColors.isDynamicColorAvailable())
      }

      "dynamicTonalPalette" -> {
        if (DynamicColors.isDynamicColorAvailable()) {
          val context = binding.applicationContext
          result.success(dynamicTonalPalette(context).toFlutterColors())
        } else {
          result.success(null)
        }
      }

      "dynamicLightColorScheme" -> {
        if (DynamicColors.isDynamicColorAvailable()) {
          val context = binding.applicationContext
          result.success(dynamicLightColorScheme(context).toFlutterColors())
        } else {
          result.success(null)
        }
      }

      "dynamicDarkColorScheme" -> {
        if (DynamicColors.isDynamicColorAvailable()) {
          val context = binding.applicationContext
          result.success(dynamicDarkColorScheme(context).toFlutterColors())
        } else {
          result.success(null)
        }
      }

      "dynamicColorSchemes" -> {
        if (DynamicColors.isDynamicColorAvailable()) {
          val context = binding.applicationContext
          val dynamicColorSchemes = mapOf(
            "light" to dynamicLightColorScheme(context).toFlutterColors(),
            "dark" to dynamicDarkColorScheme(context).toFlutterColors()
          )
          result.success(dynamicColorSchemes)
        } else {
          result.success(null)
        }
      }

      else -> result.notImplemented()
    }
  }
}

fun <K> Map<out K, Int>.toFlutterColors(): Map<K, Long> {
  return this.mapValues { it.value.toLong() and 0xFFFFFFFFL }
}
