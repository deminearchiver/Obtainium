package dev.deminearchiver.dynamic_color

import android.content.Context
import android.os.Build
import dev.deminearchiver.dynamic_color.internal.Cam
import androidx.annotation.ColorRes
import androidx.annotation.FloatRange
import androidx.annotation.RequiresApi
import dev.deminearchiver.dynamic_color.internal.CamUtils

@RequiresApi(Build.VERSION_CODES.S)
internal fun dynamicTonalPalette31(context: Context): Map<String, Int> = mapOf(
  // The neutral tonal range from the generated dynamic color palette.
  "neutral_100" to ColorResourceHelper.getColor(context, android.R.color.system_neutral1_0),
  "neutral_99" to ColorResourceHelper.getColor(context, android.R.color.system_neutral1_10),
  "neutral_98" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral1_600)
      .setLuminance(98f),
  "neutral_96" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral1_600)
      .setLuminance(96f),
  "neutral_95" to ColorResourceHelper.getColor(context, android.R.color.system_neutral1_50),
  "neutral_94" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral1_600)
      .setLuminance(94f),
  "neutral_92" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral1_600)
      .setLuminance(92f),
  "neutral_90" to ColorResourceHelper.getColor(context, android.R.color.system_neutral1_100),
  "neutral_87" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral1_600)
      .setLuminance(87f),
  "neutral_80" to ColorResourceHelper.getColor(context, android.R.color.system_neutral1_200),
  "neutral_70" to ColorResourceHelper.getColor(context, android.R.color.system_neutral1_300),
  "neutral_60" to ColorResourceHelper.getColor(context, android.R.color.system_neutral1_400),
  "neutral_50" to ColorResourceHelper.getColor(context, android.R.color.system_neutral1_500),
  "neutral_40" to ColorResourceHelper.getColor(context, android.R.color.system_neutral1_600),
  "neutral_30" to ColorResourceHelper.getColor(context, android.R.color.system_neutral1_700),
  "neutral_24" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral1_600)
      .setLuminance(24f),
  "neutral_22" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral1_600)
      .setLuminance(22f),
  "neutral_20" to ColorResourceHelper.getColor(context, android.R.color.system_neutral1_800),
  "neutral_17" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral1_600)
      .setLuminance(17f),
  "neutral_12" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral1_600)
      .setLuminance(12f),
  "neutral_10" to ColorResourceHelper.getColor(context, android.R.color.system_neutral1_900),
  "neutral_6" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral1_600)
      .setLuminance(6f),
  "neutral_4" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral1_600)
      .setLuminance(4f),
  "neutral_0" to ColorResourceHelper.getColor(context, android.R.color.system_neutral1_1000),

  // The neutral variant tonal range, sometimes called "neutral 2",  from the
  // generated dynamic color palette.
  "neutral_variant_100" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_0),
  "neutral_variant_99" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_10),
  "neutral_variant_98" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_600)
      .setLuminance(98f),
  "neutral_variant_96" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_600)
      .setLuminance(96f),
  "neutral_variant_95" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_50),
  "neutral_variant_94" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_600)
      .setLuminance(94f),
  "neutral_variant_92" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_600)
      .setLuminance(92f),
  "neutral_variant_90" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_100),
  "neutral_variant_87" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_600)
      .setLuminance(87f),
  "neutral_variant_80" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_200),
  "neutral_variant_70" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_300),
  "neutral_variant_60" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_400),
  "neutral_variant_50" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_500),
  "neutral_variant_40" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_600),
  "neutral_variant_30" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_700),
  "neutral_variant_24" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_600)
      .setLuminance(24f),
  "neutral_variant_22" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_600)
      .setLuminance(22f),
  "neutral_variant_20" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_800),
  "neutral_variant_17" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_600)
      .setLuminance(17f),
  "neutral_variant_12" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_600)
      .setLuminance(12f),
  "neutral_variant_10" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_900),
  "neutral_variant_6" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_600)
      .setLuminance(6f),
  "neutral_variant_4" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_600)
      .setLuminance(4f),
  "neutral_variant_0" to
    ColorResourceHelper.getColor(context, android.R.color.system_neutral2_1000),

  // The primary tonal range from the generated dynamic color palette.
  "primary_100" to ColorResourceHelper.getColor(context, android.R.color.system_accent1_0),
  "primary_99" to ColorResourceHelper.getColor(context, android.R.color.system_accent1_10),
  "primary_95" to ColorResourceHelper.getColor(context, android.R.color.system_accent1_50),
  "primary_90" to ColorResourceHelper.getColor(context, android.R.color.system_accent1_100),
  "primary_80" to ColorResourceHelper.getColor(context, android.R.color.system_accent1_200),
  "primary_70" to ColorResourceHelper.getColor(context, android.R.color.system_accent1_300),
  "primary_60" to ColorResourceHelper.getColor(context, android.R.color.system_accent1_400),
  "primary_50" to ColorResourceHelper.getColor(context, android.R.color.system_accent1_500),
  "primary_40" to ColorResourceHelper.getColor(context, android.R.color.system_accent1_600),
  "primary_30" to ColorResourceHelper.getColor(context, android.R.color.system_accent1_700),
  "primary_20" to ColorResourceHelper.getColor(context, android.R.color.system_accent1_800),
  "primary_10" to ColorResourceHelper.getColor(context, android.R.color.system_accent1_900),
  "primary_0" to ColorResourceHelper.getColor(context, android.R.color.system_accent1_1000),

  // The secondary tonal range from the generated dynamic color palette.
  "secondary_100" to ColorResourceHelper.getColor(context, android.R.color.system_accent2_0),
  "secondary_99" to ColorResourceHelper.getColor(context, android.R.color.system_accent2_10),
  "secondary_95" to ColorResourceHelper.getColor(context, android.R.color.system_accent2_50),
  "secondary_90" to ColorResourceHelper.getColor(context, android.R.color.system_accent2_100),
  "secondary_80" to ColorResourceHelper.getColor(context, android.R.color.system_accent2_200),
  "secondary_70" to ColorResourceHelper.getColor(context, android.R.color.system_accent2_300),
  "secondary_60" to ColorResourceHelper.getColor(context, android.R.color.system_accent2_400),
  "secondary_50" to ColorResourceHelper.getColor(context, android.R.color.system_accent2_500),
  "secondary_40" to ColorResourceHelper.getColor(context, android.R.color.system_accent2_600),
  "secondary_30" to ColorResourceHelper.getColor(context, android.R.color.system_accent2_700),
  "secondary_20" to ColorResourceHelper.getColor(context, android.R.color.system_accent2_800),
  "secondary_10" to ColorResourceHelper.getColor(context, android.R.color.system_accent2_900),
  "secondary_0" to ColorResourceHelper.getColor(context, android.R.color.system_accent2_1000),

  // The tertiary tonal range from the generated dynamic color palette.
  "tertiary_100" to ColorResourceHelper.getColor(context, android.R.color.system_accent3_0),
  "tertiary_99" to ColorResourceHelper.getColor(context, android.R.color.system_accent3_10),
  "tertiary_95" to ColorResourceHelper.getColor(context, android.R.color.system_accent3_50),
  "tertiary_90" to ColorResourceHelper.getColor(context, android.R.color.system_accent3_100),
  "tertiary_80" to ColorResourceHelper.getColor(context, android.R.color.system_accent3_200),
  "tertiary_70" to ColorResourceHelper.getColor(context, android.R.color.system_accent3_300),
  "tertiary_60" to ColorResourceHelper.getColor(context, android.R.color.system_accent3_400),
  "tertiary_50" to ColorResourceHelper.getColor(context, android.R.color.system_accent3_500),
  "tertiary_40" to ColorResourceHelper.getColor(context, android.R.color.system_accent3_600),
  "tertiary_30" to ColorResourceHelper.getColor(context, android.R.color.system_accent3_700),
  "tertiary_20" to ColorResourceHelper.getColor(context, android.R.color.system_accent3_800),
  "tertiary_10" to ColorResourceHelper.getColor(context, android.R.color.system_accent3_900),
  "tertiary_0" to ColorResourceHelper.getColor(context, android.R.color.system_accent3_1000),
);

@RequiresApi(Build.VERSION_CODES.VANILLA_ICE_CREAM)
internal fun dynamicTonalPalette35(context: Context): Map<String, Int> {
  val values31 = dynamicTonalPalette31(context)
  val values35 = mapOf(
    // The error tonal range from the generated dynamic color palette.
    "error_100" to ColorResourceHelper.getColor(context, android.R.color.system_error_0),
    "error_99" to ColorResourceHelper.getColor(context, android.R.color.system_error_10),
    "error_95" to ColorResourceHelper.getColor(context, android.R.color.system_error_50),
    "error_90" to ColorResourceHelper.getColor(context, android.R.color.system_error_100),
    "error_80" to ColorResourceHelper.getColor(context, android.R.color.system_error_200),
    "error_70" to ColorResourceHelper.getColor(context, android.R.color.system_error_300),
    "error_60" to ColorResourceHelper.getColor(context, android.R.color.system_error_400),
    "error_50" to ColorResourceHelper.getColor(context, android.R.color.system_error_500),
    "error_40" to ColorResourceHelper.getColor(context, android.R.color.system_error_600),
    "error_30" to ColorResourceHelper.getColor(context, android.R.color.system_error_700),
    "error_20" to ColorResourceHelper.getColor(context, android.R.color.system_error_800),
    "error_10" to ColorResourceHelper.getColor(context, android.R.color.system_error_900),
    "error_0" to ColorResourceHelper.getColor(context, android.R.color.system_error_1000),
  )
  return values31 + values35
}

@RequiresApi(Build.VERSION_CODES.S)
fun dynamicTonalPalette(context: Context): Map<String, Int> {
  return if (Build.VERSION.SDK_INT >= 35) {
    dynamicTonalPalette35(context)
  } else {
    dynamicTonalPalette31(context)
  }
}

@RequiresApi(Build.VERSION_CODES.S)
fun dynamicLightColorScheme(context: Context): Map<String, Int> {
  return if (Build.VERSION.SDK_INT >= 34) {
    // SDKs 34 and greater return appropriate Chroma6 values for neutral palette
    dynamicLightColorScheme34(context)
  } else {
    // SDKs 31-33 return Chroma4 values for neutral palette, we instead leverage neutral
    // variant which provides chroma8 for less grey tones.
    val tonalPalette = dynamicTonalPalette(context)
    dynamicLightColorScheme31(tonalPalette)
  }
}

@RequiresApi(Build.VERSION_CODES.S)
fun dynamicDarkColorScheme(context: Context): Map<String, Int> {
  return if (Build.VERSION.SDK_INT >= 34) {
    // SDKs 34 and greater return appropriate Chroma6 values for neutral palette
    dynamicDarkColorScheme34(context)
  } else {
    // SDKs 31-33 return Chroma4 values for neutral palette, we instead leverage neutral
    // variant which provides chroma8 for less grey tones.
    val tonalPalette = dynamicTonalPalette(context)
    dynamicDarkColorScheme31(tonalPalette)
  }
}


@RequiresApi(Build.VERSION_CODES.S)
internal fun dynamicLightColorScheme31(tonalPalette: Map<String, Int>): Map<String, Int> {
  @Suppress("UNCHECKED_CAST")
  return mapOf(
    "primary" to tonalPalette["primary_40"],
    "on_primary" to tonalPalette["primary_100"],
    "primary_container" to tonalPalette["primary_90"],
    "on_primary_container" to tonalPalette["primary_30"],
    "inverse_primary" to tonalPalette["primary_80"],
    "secondary" to tonalPalette["secondary_40"],
    "on_secondary" to tonalPalette["secondary_100"],
    "secondary_container" to tonalPalette["secondary_90"],
    "on_secondary_container" to tonalPalette["secondary_30"],
    "tertiary" to tonalPalette["tertiary_40"],
    "on_tertiary" to tonalPalette["tertiary_100"],
    "tertiary_container" to tonalPalette["tertiary_90"],
    "on_tertiary_container" to tonalPalette["tertiary_30"],
    "error" to tonalPalette["error_40"],
    "on_error" to tonalPalette["error_100"],
    "error_container" to tonalPalette["error_90"],
    "on_error_container" to tonalPalette["error_30"],
    "background" to tonalPalette["neutral_variant_98"],
    "on_background" to tonalPalette["neutral_variant_10"],
    "surface" to tonalPalette["neutral_variant_98"],
    "on_surface" to tonalPalette["neutral_variant_10"],
    "surface_variant" to tonalPalette["neutral_variant_90"],
    "on_surface_variant" to tonalPalette["neutral_variant_30"],
    "inverse_surface" to tonalPalette["neutral_variant_20"],
    "inverse_on_surface" to tonalPalette["neutral_variant_95"],
    "outline" to tonalPalette["neutral_variant_50"],
    "outline_variant" to tonalPalette["neutral_variant_80"],
    "scrim" to tonalPalette["neutral_variant_0"],
    "surface_bright" to tonalPalette["neutral_variant_98"],
    "surface_dim" to tonalPalette["neutral_variant_87"],
    "surface_container" to tonalPalette["neutral_variant_94"],
    "surface_container_high" to tonalPalette["neutral_variant_92"],
    "surface_container_highest" to tonalPalette["neutral_variant_90"],
    "surface_container_low" to tonalPalette["neutral_variant_96"],
    "surface_container_lowest" to tonalPalette["neutral_variant_100"],
    "surface_tint" to tonalPalette["primary_40"],
    "primary_fixed" to tonalPalette["primary_90"],
    "primary_fixed_dim" to tonalPalette["primary_80"],
    "on_primary_fixed" to tonalPalette["primary_10"],
    "on_primary_fixed_variant" to tonalPalette["primary_30"],
    "secondary_fixed" to tonalPalette["secondary_90"],
    "secondary_fixed_dim" to tonalPalette["secondary_80"],
    "on_secondary_fixed" to tonalPalette["secondary_10"],
    "on_secondary_fixed_variant" to tonalPalette["secondary_30"],
    "tertiary_fixed" to tonalPalette["tertiary_90"],
    "tertiary_fixed_dim" to tonalPalette["tertiary_80"],
    "on_tertiary_fixed" to tonalPalette["tertiary_10"],
    "on_tertiary_fixed_variant" to tonalPalette["tertiary_30"],
  ).filterValues { it != null } as Map<String, Int>
}


@RequiresApi(Build.VERSION_CODES.UPSIDE_DOWN_CAKE)
internal fun dynamicLightColorScheme34(context: Context): Map<String, Int> {
  return mapOf(
    "primary_palette_key_color" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_palette_key_color_primary_light
    ),
    "secondary_palette_key_color" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_palette_key_color_secondary_light
    ),
    "tertiary_palette_key_color" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_palette_key_color_tertiary_light
    ),
    "neutral_palette_key_color" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_palette_key_color_neutral_light
    ),
    "neutral_variant_palette_key_color" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_palette_key_color_neutral_variant_light
    ),
    "background" to ColorResourceHelper.getColor(context, android.R.color.system_background_light),
    "on_background" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_background_light
    ),
    "surface" to ColorResourceHelper.getColor(context, android.R.color.system_surface_light),
    "surface_dim" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_surface_dim_light
    ),
    "surface_bright" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_surface_bright_light
    ),
    "surface_container_lowest" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_surface_container_lowest_light
    ),
    "surface_container_low" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_surface_container_low_light
    ),
    "surface_container" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_surface_container_light
    ),
    "surface_container_high" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_surface_container_high_light
    ),
    "surface_container_highest" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_surface_container_highest_light
    ),
    "on_surface" to ColorResourceHelper.getColor(context, android.R.color.system_on_surface_light),
    "surface_variant" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_surface_variant_light
    ),
    "on_surface_variant" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_surface_variant_light
    ),
    "inverse_surface" to ColorResourceHelper.getColor(context, android.R.color.system_surface_dark),
    "inverse_on_surface" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_surface_dark
    ),
    "outline" to ColorResourceHelper.getColor(context, android.R.color.system_outline_light),
    "outline_variant" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_outline_variant_light
    ),
    "surface_tint" to ColorResourceHelper.getColor(context, android.R.color.system_primary_light),
    "primary" to ColorResourceHelper.getColor(context, android.R.color.system_primary_light),
    "on_primary" to ColorResourceHelper.getColor(context, android.R.color.system_on_primary_light),
    "primary_container" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_primary_container_light
    ),
    "on_primary_container" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_primary_container_light
    ),
    "inverse_primary" to ColorResourceHelper.getColor(context, android.R.color.system_primary_dark),
    "primary_fixed" to ColorResourceHelper.getColor(context, android.R.color.system_primary_fixed),
    "primary_fixed_dim" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_primary_fixed_dim
    ),
    "on_primary_fixed" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_primary_fixed
    ),
    "on_primary_fixed_variant" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_primary_fixed_variant
    ),
    "secondary" to ColorResourceHelper.getColor(context, android.R.color.system_secondary_light),
    "on_secondary" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_secondary_light
    ),
    "secondary_container" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_secondary_container_light
    ),
    "on_secondary_container" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_secondary_container_light
    ),
    "secondary_fixed" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_secondary_fixed
    ),
    "secondary_fixed_dim" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_secondary_fixed_dim
    ),
    "on_secondary_fixed" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_secondary_fixed
    ),
    "on_secondary_fixed_variant" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_secondary_fixed_variant
    ),
    "tertiary" to ColorResourceHelper.getColor(context, android.R.color.system_tertiary_light),
    "on_tertiary" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_tertiary_light
    ),
    "tertiary_container" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_tertiary_container_light
    ),
    "on_tertiary_container" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_tertiary_container_light
    ),
    "tertiary_fixed" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_tertiary_fixed
    ),
    "tertiary_fixed_dim" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_tertiary_fixed_dim
    ),
    "on_tertiary_fixed" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_tertiary_fixed
    ),
    "on_tertiary_fixed_variant" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_tertiary_fixed_variant
    ),
    "error" to ColorResourceHelper.getColor(context, android.R.color.system_error_light),
    "on_error" to ColorResourceHelper.getColor(context, android.R.color.system_on_error_light),
    "error_container" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_error_container_light
    ),
    "on_error_container" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_error_container_light
    ),
    "control_activated" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_control_activated_light
    ),
    "control_normal" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_control_normal_light
    ),
    "control_highlight" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_control_highlight_light
    ),
    "text_primary_inverse" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_text_primary_inverse_light
    ),
    "text_secondary_and_tertiary_inverse" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_text_secondary_and_tertiary_inverse_light
    ),
    "text_primary_inverse_disable_only" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_text_primary_inverse_disable_only_light
    ),
    "text_secondary_and_tertiary_inverse_disabled" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_text_secondary_and_tertiary_inverse_disabled_light
    ),
    "text_hint_inverse" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_text_hint_inverse_light
    ),
  )
}

@RequiresApi(Build.VERSION_CODES.S)
internal fun dynamicDarkColorScheme31(tonalPalette: Map<String, Int>): Map<String, Int> {
  @Suppress("UNCHECKED_CAST")
  return mapOf(
    "primary" to tonalPalette["primary_80"],
    "on_primary" to tonalPalette["primary_20"],
    "primary_container" to tonalPalette["primary_30"],
    "on_primary_container" to tonalPalette["primary_90"],
    "inverse_primary" to tonalPalette["primary_40"],
    "secondary" to tonalPalette["secondary_80"],
    "on_secondary" to tonalPalette["secondary_20"],
    "secondary_container" to tonalPalette["secondary_30"],
    "on_secondary_container" to tonalPalette["secondary_90"],
    "tertiary" to tonalPalette["tertiary_80"],
    "on_tertiary" to tonalPalette["tertiary_20"],
    "tertiary_container" to tonalPalette["tertiary_30"],
    "on_tertiary_container" to tonalPalette["tertiary_90"],
    "error" to tonalPalette["error_80"],
    "on_error" to tonalPalette["error_20"],
    "error_container" to tonalPalette["error_30"],
    "on_error_container" to tonalPalette["error_90"],
    "background" to tonalPalette["neutral_variant_6"],
    "on_background" to tonalPalette["neutral_variant_90"],
    "surface" to tonalPalette["neutral_variant_6"],
    "on_surface" to tonalPalette["neutral_variant_90"],
    "surface_variant" to tonalPalette["neutral_variant_30"],
    "on_surface_variant" to tonalPalette["neutral_variant_80"],
    "inverse_surface" to tonalPalette["neutral_variant_90"],
    "inverse_on_surface" to tonalPalette["neutral_variant_20"],
    "outline" to tonalPalette["neutral_variant_60"],
    "outline_variant" to tonalPalette["neutral_variant_30"],
    "scrim" to tonalPalette["neutral_variant_0"],
    "surface_bright" to tonalPalette["neutral_variant_24"],
    "surface_dim" to tonalPalette["neutral_variant_6"],
    "surface_container" to tonalPalette["neutral_variant_12"],
    "surface_container_high" to tonalPalette["neutral_variant_17"],
    "surface_container_highest" to tonalPalette["neutral_variant_22"],
    "surface_container_low" to tonalPalette["neutral_variant_10"],
    "surface_container_lowest" to tonalPalette["neutral_variant_4"],
    "surface_tint" to tonalPalette["primary_80"],
    "primary_fixed" to tonalPalette["primary_90"],
    "primary_fixed_dim" to tonalPalette["primary_80"],
    "on_primary_fixed" to tonalPalette["primary_10"],
    "on_primary_fixed_variant" to tonalPalette["primary_30"],
    "secondary_fixed" to tonalPalette["secondary_90"],
    "secondary_fixed_dim" to tonalPalette["secondary_80"],
    "on_secondary_fixed" to tonalPalette["secondary_10"],
    "on_secondary_fixed_variant" to tonalPalette["secondary_30"],
    "tertiary_fixed" to tonalPalette["tertiary_90"],
    "tertiary_fixed_dim" to tonalPalette["tertiary_80"],
    "on_tertiary_fixed" to tonalPalette["tertiary_10"],
    "on_tertiary_fixed_variant" to tonalPalette["tertiary_30"],
  ).filterValues { it != null } as Map<String, Int>
}

@RequiresApi(Build.VERSION_CODES.UPSIDE_DOWN_CAKE)
internal fun dynamicDarkColorScheme34(context: Context): Map<String, Int> {
  return mapOf(
    // Palette key colors
    "primary_palette_key_color" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_palette_key_color_primary_dark
    ),
    "secondary_palette_key_color" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_palette_key_color_secondary_dark
    ),
    "tertiary_palette_key_color" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_palette_key_color_tertiary_dark
    ),
    "neutral_palette_key_color" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_palette_key_color_neutral_dark
    ),
    "neutral_variant_palette_key_color" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_palette_key_color_neutral_variant_dark
    ),

    // Color roles
    "background" to ColorResourceHelper.getColor(context, android.R.color.system_background_dark),
    "on_background" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_background_dark
    ),
    "surface" to ColorResourceHelper.getColor(context, android.R.color.system_surface_dark),
    "surface_dim" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_surface_dim_dark
    ),
    "surface_bright" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_surface_bright_dark
    ),
    "surface_container_lowest" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_surface_container_lowest_dark
    ),
    "surface_container_low" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_surface_container_low_dark
    ),
    "surface_container" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_surface_container_dark
    ),
    "surface_container_high" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_surface_container_high_dark
    ),
    "surface_container_highest" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_surface_container_highest_dark
    ),
    "on_surface" to ColorResourceHelper.getColor(context, android.R.color.system_on_surface_dark),
    "surface_variant" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_surface_variant_dark
    ),
    "on_surface_variant" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_surface_variant_dark
    ),
    "inverse_surface" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_surface_light
    ),
    "inverse_on_surface" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_surface_light
    ),
    "outline" to ColorResourceHelper.getColor(context, android.R.color.system_outline_dark),
    "outline_variant" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_outline_variant_dark
    ),
    "surface_tint" to ColorResourceHelper.getColor(context, android.R.color.system_primary_dark),
    "primary" to ColorResourceHelper.getColor(context, android.R.color.system_primary_dark),
    "on_primary" to ColorResourceHelper.getColor(context, android.R.color.system_on_primary_dark),
    "primary_container" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_primary_container_dark
    ),
    "on_primary_container" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_primary_container_dark
    ),
    "inverse_primary" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_primary_light
    ),
    "primary_fixed" to ColorResourceHelper.getColor(context, android.R.color.system_primary_fixed),
    "primary_fixed_dim" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_primary_fixed_dim
    ),
    "on_primary_fixed" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_primary_fixed
    ),
    "on_primary_fixed_variant" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_primary_fixed_variant
    ),
    "secondary" to ColorResourceHelper.getColor(context, android.R.color.system_secondary_dark),
    "on_secondary" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_secondary_dark
    ),
    "secondary_container" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_secondary_container_dark
    ),
    "on_secondary_container" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_secondary_container_dark
    ),
    "secondary_fixed" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_secondary_fixed
    ),
    "secondary_fixed_dim" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_secondary_fixed_dim
    ),
    "on_secondary_fixed" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_secondary_fixed
    ),
    "on_secondary_fixed_variant" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_secondary_fixed_variant
    ),
    "tertiary" to ColorResourceHelper.getColor(context, android.R.color.system_tertiary_dark),
    "on_tertiary" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_tertiary_dark
    ),
    "tertiary_container" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_tertiary_container_dark
    ),
    "on_tertiary_container" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_tertiary_container_dark
    ),
    "tertiary_fixed" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_tertiary_fixed
    ),
    "tertiary_fixed_dim" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_tertiary_fixed_dim
    ),
    "on_tertiary_fixed" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_tertiary_fixed
    ),
    "on_tertiary_fixed_variant" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_tertiary_fixed_variant
    ),
    "error" to ColorResourceHelper.getColor(context, android.R.color.system_error_dark),
    "on_error" to ColorResourceHelper.getColor(context, android.R.color.system_on_error_dark),
    "error_container" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_error_container_dark
    ),
    "on_error_container" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_on_error_container_dark
    ),
    "control_activated" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_control_activated_dark
    ),
    "control_normal" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_control_normal_dark
    ),
    "control_highlight" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_control_highlight_dark
    ),
    "text_primary_inverse" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_text_primary_inverse_dark
    ),
    "text_secondary_and_tertiary_inverse" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_text_secondary_and_tertiary_inverse_dark
    ),
    "text_primary_inverse_disable_only" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_text_primary_inverse_disable_only_dark
    ),
    "text_secondary_and_tertiary_inverse_disabled" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_text_secondary_and_tertiary_inverse_disabled_dark
    ),
    "text_hint_inverse" to ColorResourceHelper.getColor(
      context,
      android.R.color.system_text_hint_inverse_dark
    ),
  )
}

@RequiresApi(Build.VERSION_CODES.M)
private object ColorResourceHelper {
  fun getColor(context: Context, @ColorRes id: Int): Int {
    return context.resources.getColor(id, context.theme)
  }
}

internal fun Int.setLuminance(@FloatRange(from = 0.0, to = 100.0) newLuminance: Float): Int {
  if ((newLuminance < 0.0001) or (newLuminance > 99.9999)) {
    return CamUtils.argbFromLstar(newLuminance.toDouble())
  }

  val baseCam: Cam = Cam.fromInt(this)
  val baseColor = Cam.getInt(baseCam.hue, baseCam.chroma, newLuminance)

  return baseColor
}
