// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:materium/flutter.dart' hide RawScrollbar, RawScrollbarState;
import 'custom_raw_scrollbar.dart';

const Duration _kScrollbarFadeDuration = Duration(milliseconds: 300);
const Duration _kScrollbarTimeToFade = Duration(milliseconds: 600);

class CustomScrollbar extends StatelessWidget {
  const CustomScrollbar({
    super.key,
    required this.child,
    this.controller,
    this.thumbVisibility,
    this.trackVisibility,
    this.notificationPredicate,
    this.interactive,
    this.scrollbarOrientation,
  });

  /// {@macro flutter.widgets.Scrollbar.child}
  final Widget child;

  /// {@macro flutter.widgets.Scrollbar.controller}
  final ScrollController? controller;

  /// {@macro flutter.widgets.Scrollbar.thumbVisibility}
  ///
  /// If this property is null, then [ScrollbarThemeData.thumbVisibility] of
  /// [ThemeData.scrollbarTheme] is used. If that is also null, the default value
  /// is false.
  ///
  /// If the thumb visibility is related to the scrollbar's material state,
  /// use the global [ScrollbarThemeData.thumbVisibility] or override the
  /// sub-tree's theme data.
  final bool? thumbVisibility;

  /// {@macro flutter.widgets.Scrollbar.trackVisibility}
  ///
  /// If this property is null, then [ScrollbarThemeData.trackVisibility] of
  /// [ThemeData.scrollbarTheme] is used. If that is also null, the default value
  /// is false.
  ///
  /// If the track visibility is related to the scrollbar's material state,
  /// use the global [ScrollbarThemeData.trackVisibility] or override the
  /// sub-tree's theme data.
  final bool? trackVisibility;

  /// {@macro flutter.widgets.Scrollbar.interactive}
  final bool? interactive;

  /// {@macro flutter.widgets.Scrollbar.notificationPredicate}
  final ScrollNotificationPredicate? notificationPredicate;

  /// {@macro flutter.widgets.Scrollbar.scrollbarOrientation}
  final ScrollbarOrientation? scrollbarOrientation;

  @override
  Widget build(BuildContext context) {
    return _MaterialScrollbar(
      controller: controller,
      thumbVisibility: thumbVisibility,
      trackVisibility: trackVisibility,
      notificationPredicate: notificationPredicate,
      interactive: interactive,
      scrollbarOrientation: scrollbarOrientation,
      child: child,
    );
  }
}

class _MaterialScrollbar extends RawScrollbar {
  const _MaterialScrollbar({
    required super.child,
    super.controller,
    super.thumbVisibility,
    super.trackVisibility,
    ScrollNotificationPredicate? notificationPredicate,
    super.interactive,
    super.scrollbarOrientation,
  }) : super(
         fadeDuration: _kScrollbarFadeDuration,
         timeToFade: _kScrollbarTimeToFade,
         pressDuration: Duration.zero,
         notificationPredicate:
             notificationPredicate ?? defaultScrollNotificationPredicate,
       );

  @override
  _MaterialScrollbarState createState() => _MaterialScrollbarState();
}

class _MaterialScrollbarState extends RawScrollbarState<_MaterialScrollbar> {
  late AnimationController _hoverAnimationController;
  bool _dragIsActive = false;
  bool _hoverIsActive = false;
  late ColorThemeData _colorTheme;
  late ScrollbarThemeData _scrollbarTheme;
  // On Android, scrollbars should match native appearance.
  late bool _useAndroidScrollbar;

  @override
  bool get showScrollbar =>
      widget.thumbVisibility ??
      _scrollbarTheme.thumbVisibility?.resolve(_states) ??
      false;

  @override
  bool get enableGestures =>
      widget.interactive ??
      _scrollbarTheme.interactive ??
      !_useAndroidScrollbar;

  WidgetStateProperty<bool> get _trackVisibility =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        return widget.trackVisibility ??
            _scrollbarTheme.trackVisibility?.resolve(states) ??
            false;
      });

  Set<WidgetState> get _states => <WidgetState>{
    if (_dragIsActive) WidgetState.dragged,
    if (_hoverIsActive) WidgetState.hovered,
  };

  WidgetStateProperty<Color> get _thumbColor {
    final Color onSurface = _colorTheme.onSurface;
    final Brightness brightness = _colorTheme.brightness;
    late Color dragColor;
    late Color hoverColor;
    late Color idleColor;
    switch (brightness) {
      case Brightness.light:
        dragColor = onSurface.withValues(alpha: 0.6);
        hoverColor = onSurface.withValues(alpha: 0.5);
        idleColor = _useAndroidScrollbar
            ? Theme.of(context).highlightColor.withValues(alpha: 1.0)
            : onSurface.withValues(alpha: 0.1);
      case Brightness.dark:
        dragColor = onSurface.withValues(alpha: 0.75);
        hoverColor = onSurface.withValues(alpha: 0.65);
        idleColor = _useAndroidScrollbar
            ? Theme.of(context).highlightColor.withValues(alpha: 1.0)
            : onSurface.withValues(alpha: 0.3);
    }

    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.dragged)) {
        return _scrollbarTheme.thumbColor?.resolve(states) ?? dragColor;
      }

      // If the track is visible, the thumb color hover animation is ignored and
      // changes immediately.
      if (_trackVisibility.resolve(states)) {
        return _scrollbarTheme.thumbColor?.resolve(states) ?? hoverColor;
      }

      return Color.lerp(
        _scrollbarTheme.thumbColor?.resolve(states) ?? idleColor,
        _scrollbarTheme.thumbColor?.resolve(states) ?? hoverColor,
        _hoverAnimationController.value,
      )!;
    });
  }

  WidgetStateProperty<Color> get _trackColor {
    final Color onSurface = _colorTheme.onSurface;
    final Brightness brightness = _colorTheme.brightness;
    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (showScrollbar && _trackVisibility.resolve(states)) {
        return _scrollbarTheme.trackColor?.resolve(states) ??
            switch (brightness) {
              Brightness.light => onSurface.withValues(alpha: 0.03),
              Brightness.dark => onSurface.withValues(alpha: 0.05),
            };
      }
      return const Color(0x00000000);
    });
  }

  WidgetStateProperty<Color> get _trackBorderColor {
    final Color onSurface = _colorTheme.onSurface;
    final Brightness brightness = _colorTheme.brightness;
    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (showScrollbar && _trackVisibility.resolve(states)) {
        return _scrollbarTheme.trackBorderColor?.resolve(states) ??
            switch (brightness) {
              Brightness.light => onSurface.withValues(alpha: 0.1),
              Brightness.dark => onSurface.withValues(alpha: 0.25),
            };
      }
      return const Color(0x00000000);
    });
  }

  // WidgetStateProperty<double> get _thickness {
  //   return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
  //     if (states.contains(WidgetState.hovered) &&
  //         _trackVisibility.resolve(states)) {
  //       return widget.thickness ??
  //           _scrollbarTheme.thickness?.resolve(states) ??
  //           _kScrollbarThicknessWithTrack;
  //     }
  //     // The default scrollbar thickness is smaller on mobile.
  //     return widget.thickness ??
  //         _scrollbarTheme.thickness?.resolve(states) ??
  //         (_kScrollbarThickness / (_useAndroidScrollbar ? 2 : 1));
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _hoverAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _hoverAnimationController.addListener(() {
      updateScrollbarPainter();
    });
  }

  @override
  void didChangeDependencies() {
    _scrollbarTheme = ScrollbarTheme.of(context);
    _useAndroidScrollbar = true;
    super.didChangeDependencies();
    _colorTheme = ColorTheme.of(context);
  }

  @override
  void updateScrollbarPainter() {
    scrollbarPainter
      ..color = _thumbColor.resolve(_states)
      ..trackColor = _trackColor.resolve(_states)
      ..trackBorderColor = _trackBorderColor.resolve(_states)
      ..textDirection = Directionality.of(context)
      ..thickness = 8.0
      ..radius = const Radius.circular(4.0)
      ..crossAxisMargin = 0.0
      ..mainAxisMargin = 0.0
      ..minLength = 48.0
      ..padding = MediaQuery.paddingOf(context)
      ..scrollbarOrientation = widget.scrollbarOrientation
      ..ignorePointer = !enableGestures;
  }

  @override
  void handleThumbPressStart(Offset localPosition) {
    super.handleThumbPressStart(localPosition);
    setState(() {
      _dragIsActive = true;
    });
  }

  @override
  void handleThumbPressEnd(Offset localPosition, Velocity velocity) {
    super.handleThumbPressEnd(localPosition, velocity);
    setState(() {
      _dragIsActive = false;
    });
  }

  @override
  void handleHover(PointerHoverEvent event) {
    super.handleHover(event);
    // Check if the position of the pointer falls over the painted scrollbar
    if (isPointerOverScrollbar(event.position, event.kind, forHover: true)) {
      // Pointer is hovering over the scrollbar
      setState(() {
        _hoverIsActive = true;
      });
      _hoverAnimationController.forward();
    } else if (_hoverIsActive) {
      // Pointer was, but is no longer over painted scrollbar.
      setState(() {
        _hoverIsActive = false;
      });
      _hoverAnimationController.reverse();
    }
  }

  @override
  void handleHoverExit(PointerExitEvent event) {
    super.handleHoverExit(event);
    setState(() {
      _hoverIsActive = false;
    });
    _hoverAnimationController.reverse();
  }

  @override
  void dispose() {
    _hoverAnimationController.dispose();
    super.dispose();
  }
}
