import 'dart:collection';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/scheduler.dart';
import 'package:material/src/flutter.dart';
import 'package:flutter/material.dart' as flutter;

import 'deprecated_animation.dart';
import 'focus_ring.dart';

typedef SwitchLegacy = flutter.Switch;
typedef SwitchThemeLegacy = flutter.SwitchTheme;
typedef SwitchThemeDataLegacy = flutter.SwitchThemeData;

class Switch extends StatefulWidget {
  const Switch({super.key, required this.onChanged, required this.value});

  final ValueChanged<bool>? onChanged;
  final bool value;

  @override
  State<Switch> createState() => _SwitchState();
}

class _SwitchState extends State<Switch> with TickerProviderStateMixin {
  late final WidgetStatesController _statesController;

  late final SpringImplicitAnimation<double> _handlePosition;
  late final CurveImplicitAnimation<Color?> _trackColorAnimation;
  late final CurveImplicitAnimation<Color?> _outlineColorAnimation;
  late final SpringImplicitAnimation<Size?> _handleSizeAnimation;
  late final CurveImplicitAnimation<Color?> _handleColorAnimation;

  late ColorThemeData _colorTheme;
  late ShapeThemeData _shapeTheme;
  late StateThemeData _stateTheme;

  WidgetStateProperty<Color> get _trackColor =>
      WidgetStateProperty.resolveWith((states) {
        final isSelected = states.contains(WidgetState.selected);
        if (states.contains(WidgetState.disabled)) {
          return isSelected
              ? _colorTheme.onSurface.withValues(alpha: 0.1)
              : _colorTheme.surfaceContainerHighest.withValues(alpha: 0.1);
        }
        return isSelected
            ? _colorTheme.primary
            : _colorTheme.surfaceContainerHighest;
      });
  WidgetStateProperty<Color> get _handleColor =>
      WidgetStateProperty.resolveWith((states) {
        final isSelected = states.contains(WidgetState.selected);
        if (states.contains(WidgetState.disabled)) {
          return isSelected
              ? _colorTheme.surface
              : _colorTheme.onSurface.withValues(alpha: 0.38);
        }
        return isSelected ? _colorTheme.onPrimary : _colorTheme.outline;
      });

  WidgetStateProperty<double> get _outlineWidth =>
      const WidgetStatePropertyAll(2.0);

  WidgetStateProperty<Color> get _outlineColor =>
      WidgetStateProperty.resolveWith((states) {
        final isSelected = states.contains(WidgetState.selected);
        if (states.contains(WidgetState.disabled)) {
          return isSelected
              ? _colorTheme.primary.withValues(alpha: 0.0)
              : _colorTheme.onSurface.withValues(alpha: 0.1);
        }
        return isSelected ? _colorTheme.primary : _colorTheme.outline;
      });

  WidgetStateProperty<CornersGeometry> get _trackShape =>
      WidgetStatePropertyAll(Corners.all(_shapeTheme.corner.full));

  WidgetStateProperty<Size> get _stateLayerSize =>
      const WidgetStatePropertyAll(Size.square(40.0));

  WidgetStateProperty<CornersGeometry> get _stateLayerShape =>
      WidgetStatePropertyAll(Corners.all(_shapeTheme.corner.full));

  WidgetStateProperty<Color> get _stateLayerColor =>
      WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? _colorTheme.primary
            : _colorTheme.onSurface,
      );

  WidgetStateProperty<double> get _stateLayerOpacity =>
      WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return 0.0;
        }
        if (states.contains(WidgetState.pressed)) {
          return _stateTheme.pressedStateLayerOpacity;
        }
        if (states.contains(WidgetState.hovered)) {
          return _stateTheme.hoverStateLayerOpacity;
        }
        if (states.contains(WidgetState.focused)) {
          return 0.0;
        }
        return 0.0;
      });

  WidgetStateProperty<Size> get _handleSize =>
      WidgetStateProperty.resolveWith((states) {
        final isDisabled = states.contains(WidgetState.disabled);
        if (!isDisabled && states.contains(WidgetState.pressed)) {
          return const Size.square(28.0);
        }
        // final isSelected = states.contains(WidgetState.selected);
        return const Size.square(24.0);
      });

  WidgetStateProperty<CornersGeometry> get _handleShape =>
      WidgetStatePropertyAll(Corners.all(_shapeTheme.corner.full));

  WidgetStateProperty<IconThemeDataPartial> get _iconTheme =>
      WidgetStateProperty.resolveWith((states) {
        final isSelected = states.contains(WidgetState.selected);
        final isDisabled = states.contains(WidgetState.disabled);
        final Color color = isDisabled
            ? isSelected
                  ? _colorTheme.onSurface.withValues(alpha: 0.38)
                  : _colorTheme.surfaceContainerHighest.withValues(alpha: 0.38)
            : isSelected
            ? _colorTheme.primary
            : _colorTheme.surfaceContainerHighest;
        return IconThemeDataPartial.from(
          color: color,
          fill: 0.0,
          grade: 0.0,
          size: 16.0,
          opticalSize: 24.0,
          weight: 400.0,
        );
      });

  @override
  void initState() {
    super.initState();
    _statesController =
        WidgetStatesController({
          if (widget.onChanged == null) WidgetState.disabled,
        })..addListener(() {
          setState(() {});
        });
    final durationTheme = const DurationThemeData.fallback();
    final easingTheme = const EasingThemeData.fallback();
    final springTheme = const SpringThemeData.expressive();
    _handlePosition = SpringImplicitAnimation<double>(
      vsync: this,
      spring: springTheme.fastSpatial.toSpringDescription(),
      initialValue: widget.value ? 1.0 : 0.0,
      builder: (value) => Tween<double>(begin: value),
    );
    _trackColorAnimation = CurveImplicitAnimation<Color?>(
      vsync: this,
      duration: const Duration(milliseconds: 67),
      curve: easingTheme.linear,
      initialValue: null,
      builder: (value) => ColorTween(begin: value),
    );
    _outlineColorAnimation = CurveImplicitAnimation<Color?>(
      vsync: this,
      duration: const Duration(milliseconds: 67),
      curve: easingTheme.linear,
      initialValue: null,
      builder: (value) => ColorTween(begin: value),
    );
    _handleSizeAnimation = SpringImplicitAnimation<Size?>(
      vsync: this,
      spring: springTheme.fastEffects.toSpringDescription(),
      initialValue: null,
      builder: (value) => SizeTween(begin: value),
    );
    _handleColorAnimation = CurveImplicitAnimation(
      vsync: this,
      duration: const Duration(milliseconds: 67),
      initialValue: null,
      builder: (value) => ColorTween(begin: value),
    );
  }

  @override
  void didUpdateWidget(covariant Switch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.onChanged != oldWidget.onChanged) {
      if (widget.onChanged == null) {
        _statesController.value.add(WidgetState.disabled);
      } else {
        _statesController.value.remove(WidgetState.disabled);
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _colorTheme = ColorTheme.of(context);
    _shapeTheme = ShapeTheme.of(context);
    _stateTheme = StateTheme.of(context);
  }

  @override
  void dispose() {
    _handleColorAnimation.dispose();
    _handleSizeAnimation.dispose();
    _outlineColorAnimation.dispose();
    _trackColorAnimation.dispose();
    _handlePosition.dispose();
    _statesController.dispose();
    super.dispose();
  }

  bool _pressed = false;
  bool _focused = false;

  Set<WidgetState> _resolveStates() {
    final isSelected = widget.value;
    final states = _statesController.value;
    if (isSelected) {
      states.add(WidgetState.selected);
    } else {
      states.remove(WidgetState.selected);
    }

    if (_pressed) {
      states.add(WidgetState.pressed);
    } else {
      states.remove(WidgetState.pressed);
    }
    if (_focused && !_pressed) {
      states.add(WidgetState.focused);
    } else {
      states.remove(WidgetState.focused);
    }
    return UnmodifiableSetView(states);
  }

  @override
  Widget build(BuildContext context) {
    final states = _resolveStates();
    final isSelected = states.contains(WidgetState.selected);
    final outlineWidth = _outlineWidth.resolve(states);
    final outlineColor = _outlineColor.resolve(states);
    final trackColor = _trackColor.resolve(states);
    final trackCorners = _trackShape.resolve(states);
    final stateLayerSize = _stateLayerSize.resolve(states);
    final stateLayerCorners = _stateLayerShape.resolve(states);
    final handleSize = _handleSize.resolve(states);
    final handleColor = _handleColor.resolve(states);
    final handleCorners = _handleShape.resolve(states);
    final iconTheme = _iconTheme.resolve(states);

    const minTapTargetSize = Size(48.0, 48.0);
    const trackSize = Size(52.0, 32.0);

    final stateLayerShape = CornersBorder.rounded(corners: stateLayerCorners);
    final handleShape = CornersBorder.rounded(corners: handleCorners);

    _handlePosition.targetValue = widget.value ? 1.0 : 0.0;
    _trackColorAnimation.targetValue = trackColor;
    _outlineColorAnimation.targetValue = outlineColor;
    _handleSizeAnimation.targetValue = handleSize;
    _handleColorAnimation.value = handleColor;

    final trackChild = SizedBox.fromSize(
      size: stateLayerSize,
      child: Listener(
        behavior: HitTestBehavior.deferToChild,
        onPointerDown: (_) {
          setState(() {
            _focused = false;
            _pressed = true;
          });
        },
        onPointerUp: (_) {
          setState(() {
            _focused = false;
            _pressed = false;
          });
        },
        onPointerCancel: (_) {
          setState(() {
            _focused = false;
            _pressed = false;
          });
        },
        child: Material(
          animationDuration: Duration.zero,
          type: MaterialType.card,
          clipBehavior: Clip.none,
          color: Colors.transparent,
          child: InkWell(
            customBorder: stateLayerShape,
            statesController: _statesController,
            onTap: widget.onChanged != null
                ? () {
                    widget.onChanged!(!widget.value);
                  }
                : null,
            onTapDown: (_) {
              setState(() {
                _focused = false;
                _pressed = true;
              });
            },
            onTapUp: (_) {
              setState(() {
                _focused = false;
                _pressed = false;
              });
            },
            onTapCancel: () {
              setState(() {
                _focused = false;
                _pressed = false;
              });
            },
            onFocusChange: (value) {
              setState(() => _focused = value);
            },
            overlayColor: WidgetStateLayerColor(
              color: _stateLayerColor,
              opacity: _stateLayerOpacity,
            ),
          ),
        ),
      ),
    );

    final handleChild = Align.center(
      child: IconTheme.merge(
        data: iconTheme,
        child: isSelected
            ? const Icon(Symbols.check_rounded)
            : const Icon(Symbols.close_rounded),
      ),
    );
    return RepaintBoundary(
      child: Align.center(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: Material(
          animationDuration: Duration.zero,
          type: MaterialType.card,
          clipBehavior: Clip.none,
          color: Colors.transparent,
          child: TapRegion(
            behavior: HitTestBehavior.deferToChild,
            consumeOutsideTaps: false,
            onTapOutside: (_) {
              setState(() => _focused = false);
            },
            onTapUpOutside: (_) {
              setState(() => _focused = false);
            },
            child: FocusRing(
              visible: states.contains(WidgetState.focused),
              layoutBuilder: (context, info, child) => Align.center(
                child: SizedBox.fromSize(size: trackSize, child: child),
              ),
              // hasFocus: states.contains(WidgetState.focused),
              // trackSize: trackSize,
              child: _AnimatedSwitch(
                handlePosition: _handlePosition,
                trackShape: _outlineColorAnimation.nonNull.mapValue(
                  (value) => CornersBorder.rounded(
                    corners: trackCorners,
                    side: BorderSide(
                      width: outlineWidth,
                      color: _outlineColorAnimation.value!,
                      strokeAlign: BorderSide.strokeAlignInside,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                trackColor: _trackColorAnimation.nonNull,
                minTapTargetSize: minTapTargetSize,
                trackSize: trackSize,
                handleSize: _handleSizeAnimation.nonNull,
                handleShape: handleShape,
                handleColor: _handleColorAnimation.nonNull,
                childrenPaintOrder: SwitchChildrenPaintOrder.handleChildIsTop,
                trackChildPosition: SwitchChildPosition.middle,
                trackChild: trackChild,
                handleChildPosition: SwitchChildPosition.top,
                handleChild: handleChild,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SwitchFocusIndicator extends StatefulWidget {
  const _SwitchFocusIndicator({
    super.key,
    required this.hasFocus,
    required this.trackSize,
    required this.child,
  });

  final bool hasFocus;
  final Size trackSize;
  final Widget child;

  @override
  State<_SwitchFocusIndicator> createState() => _SwitchFocusIndicatorState();
}

class _SwitchFocusIndicatorState extends State<_SwitchFocusIndicator>
    with SingleTickerProviderStateMixin {
  final OverlayPortalController _overlayPortalController =
      OverlayPortalController();

  late AnimationController _animationController;
  late Animation<double> _strokeWidthAnimation;

  final Tween<double> _growValueTween = Tween<double>(begin: 0.0, end: 8.0);
  final Tween<double> _shrinkValueTween = Tween<double>(begin: 8.0, end: 3.0);
  final CurveTween _growCurveTween = CurveTween(curve: Curves.linear);
  final CurveTween _shrinkCurveTween = CurveTween(curve: Curves.linear);

  late ColorThemeData _colorTheme;
  late ShapeThemeData _shapeTheme;
  late DurationThemeData _durationTheme;
  late EasingThemeData _easingTheme;

  bool _showOverlay() {
    if (_overlayPortalController.isShowing) return false;
    _overlayPortalController.show();
    return true;
  }

  bool _hideOverlay() {
    if (!_overlayPortalController.isShowing) return false;
    _overlayPortalController.hide();
    return true;
  }

  void _toggleOverlay([bool? show]) {
    final VoidCallback callback = show != null
        ? show
              ? _showOverlay
              : _hideOverlay
        : _overlayPortalController.toggle;
    _callDeferred(callback);
  }

  void _animationStatusListener(AnimationStatus status) {
    _toggleOverlay(status != AnimationStatus.dismissed);
  }

  @override
  void initState() {
    super.initState();
    if (widget.hasFocus) {
      _toggleOverlay(true);
    }

    _animationController = AnimationController(
      vsync: this,
      value: widget.hasFocus ? 1.0 : 0.0,
    )..addStatusListener(_animationStatusListener);
    _strokeWidthAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: _growValueTween.chain(_growCurveTween),
        weight: 0.25,
      ),
      TweenSequenceItem(
        tween: _shrinkValueTween.chain(_shrinkCurveTween),
        weight: 0.75,
      ),
    ]).animate(_animationController);
  }

  @override
  void didUpdateWidget(covariant _SwitchFocusIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.hasFocus != oldWidget.hasFocus) {
      if (widget.hasFocus) {
        _animationController.animateTo(1.0, duration: _durationTheme.long4);
      } else {
        _animationController.animateBack(0.0, duration: Duration.zero);
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _colorTheme = ColorTheme.of(context);
    _shapeTheme = ShapeTheme.of(context);
    _durationTheme = DurationTheme.of(context);
    _easingTheme = EasingTheme.of(context);

    _growCurveTween.curve = _easingTheme.standard;
    _shrinkCurveTween.curve = _easingTheme.standard;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _callDeferred(VoidCallback callback) {
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        callback();
      });
    } else {
      callback();
    }
  }

  // void _setStateDeferred(VoidCallback callback) {
  //   _callDeferred(() => setState(callback));
  // }

  // Builds overlay in in global coordinates, meaning overlay child scale
  // will not affect overlay scale
  Widget _buildGlobalOverlay(
    BuildContext context,
    OverlayChildLayoutInfo info,
    Widget child,
  ) {
    final transform = info.childPaintTransform;
    final translateX = transform.storage[12];
    final translateY = transform.storage[13];
    final scaleX = transform.storage[0];
    final scaleY = transform.storage[5];
    final trackSize = widget.trackSize;
    final scaledTrackSize = Size(
      trackSize.width * scaleX,
      trackSize.height * scaleY,
    );
    final childSize = info.childSize;
    final scaledChildSize = Size(
      childSize.width * scaleX,
      childSize.height * scaleY,
    );
    final focusIndicatorOffset = 2.0;
    final scaledFocusIndicatorSize = Size(
      scaledTrackSize.width + focusIndicatorOffset * 2.0,
      scaledTrackSize.height + focusIndicatorOffset * 2.0,
    );
    final translationOffset = Offset(translateX, translateY);
    return IgnorePointer(
      child: Align.topLeft(
        child: Transform.translate(
          offset: translationOffset,
          child: SizedBox.fromSize(
            size: scaledChildSize,
            child: Align.center(
              child: SizedBox.fromSize(
                size: scaledFocusIndicatorSize,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Builds overlay in in local coordinates, meaning overlay child transform
  // is applied to the overlay
  Widget _buildLocalOverlay(
    BuildContext context,
    OverlayChildLayoutInfo info,
    Widget child,
  ) {
    final focusIndicatorOffset = 2.0;
    final trackSize = widget.trackSize;
    final focusIndicatorSize = Size(
      trackSize.width + focusIndicatorOffset * 2.0,
      trackSize.height + focusIndicatorOffset * 2.0,
    );
    return IgnorePointer(
      child: Align.topLeft(
        child: Transform(
          transform: info.childPaintTransform,
          child: SizedBox.fromSize(
            size: info.childSize,
            child: Align.center(
              child: SizedBox.fromSize(size: focusIndicatorSize, child: child),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final focusIndicator = AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) => DecoratedBox(
        decoration: ShapeDecoration(
          shape: CornersBorder.rounded(
            corners: Corners.all(_shapeTheme.corner.full),
            side: _strokeWidthAnimation.value > 0.0
                ? BorderSide(
                    style: BorderStyle.solid,
                    color: _colorTheme.secondary,
                    width: _strokeWidthAnimation.value,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  )
                : BorderSide.none,
          ),
        ),
      ),
    );
    return OverlayPortal.overlayChildLayoutBuilder(
      controller: _overlayPortalController,
      overlayChildBuilder: (context, info) =>
          _buildLocalOverlay(context, info, focusIndicator),
      child: widget.child,
    );
  }
}

enum _SwitchSlot { trackChild, handleChild }

enum SwitchChildPosition { bottom, middle, top }

enum SwitchChildrenPaintOrder { trackChildIsTop, handleChildIsTop }

class _AnimatedSwitch
    extends SlottedMultiChildRenderObjectWidget<_SwitchSlot, RenderBox> {
  const _AnimatedSwitch({
    super.key,
    required this.handlePosition,
    required this.minTapTargetSize,
    required this.trackSize,
    required this.trackShape,
    required this.trackColor,
    required this.handleSize,
    required this.handleShape,
    required this.handleColor,
    required this.childrenPaintOrder,
    required this.trackChildPosition,
    this.trackChild,
    required this.handleChildPosition,
    this.handleChild,
  });

  final ValueListenable<double> handlePosition;
  final Size minTapTargetSize;

  // Track
  final Size trackSize;
  final ValueListenable<ShapeBorder> trackShape;
  final ValueListenable<Color> trackColor;

  // Handle
  final ValueListenable<Size> handleSize;
  final ShapeBorder handleShape;
  final ValueListenable<Color> handleColor;

  final SwitchChildrenPaintOrder childrenPaintOrder;
  final SwitchChildPosition trackChildPosition;
  final Widget? trackChild;
  final SwitchChildPosition handleChildPosition;
  final Widget? handleChild;

  @override
  Iterable<_SwitchSlot> get slots => _SwitchSlot.values;

  @override
  Widget? childForSlot(_SwitchSlot slot) => switch (slot) {
    _SwitchSlot.trackChild => trackChild,
    _SwitchSlot.handleChild => handleChild,
  };

  @override
  _RenderAnimatedSwitch createRenderObject(BuildContext context) {
    return _RenderAnimatedSwitch(
      handlePosition: handlePosition,
      minTapTargetSize: minTapTargetSize,
      trackSize: trackSize,
      trackShape: trackShape,
      trackColor: trackColor,
      handleSize: handleSize,
      handleShape: handleShape,
      handleColor: handleColor,
      childrenPaintOrder: childrenPaintOrder,
      trackChildPosition: trackChildPosition,
      handleChildPosition: handleChildPosition,
      textDirection: Directionality.maybeOf(context),
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderAnimatedSwitch renderObject,
  ) {
    renderObject
      ..handlePosition = handlePosition
      ..minTapTargetSize = minTapTargetSize
      ..trackSize = trackSize
      ..trackShape = trackShape
      ..trackColor = trackColor
      ..handleSize = handleSize
      ..handleShape = handleShape
      ..handleColor = handleColor
      ..childrenPaintOrder = childrenPaintOrder
      ..trackChildPosition = trackChildPosition
      ..handleChildPosition = handleChildPosition
      ..textDirection = Directionality.maybeOf(context);
  }
}

class _RenderAnimatedSwitch extends RenderBox
    with
        SlottedContainerRenderObjectMixin<_SwitchSlot, RenderBox>,
        DebugOverflowIndicatorMixin {
  _RenderAnimatedSwitch({
    required ValueListenable<double> handlePosition,
    required Size minTapTargetSize,
    // Track
    required Size trackSize,
    required ValueListenable<ShapeBorder> trackShape,
    required ValueListenable<Color> trackColor,
    // Handle
    required ValueListenable<Size> handleSize,
    required ShapeBorder handleShape,
    required ValueListenable<Color> handleColor,
    // Children
    required SwitchChildrenPaintOrder childrenPaintOrder,
    required SwitchChildPosition trackChildPosition,
    required SwitchChildPosition handleChildPosition,
    // Context
    TextDirection? textDirection,
  }) : _handlePosition = handlePosition,
       _minTapTargetSize = minTapTargetSize,
       _trackSize = trackSize,
       _trackShape = trackShape,
       _trackColor = trackColor,
       _handleSize = handleSize,
       _handleShape = handleShape,
       _handleColor = handleColor,
       _textDirection = textDirection,
       _childrenPaintOrder = childrenPaintOrder,
       _trackChildPosition = trackChildPosition,
       _handleChildPosition = handleChildPosition;

  ValueListenable<double> _handlePosition;
  ValueListenable<double> get handlePosition => _handlePosition;
  set handlePosition(ValueListenable<double> value) {
    if (_handlePosition == value) return;
    _handlePosition.removeListener(markNeedsLayout);
    _handlePosition = value;
    _handlePosition.addListener(markNeedsLayout);
    markNeedsLayout();
  }

  Size _minTapTargetSize;
  Size get minTapTargetSize => _minTapTargetSize;
  set minTapTargetSize(Size value) {
    if (_minTapTargetSize == value) return;
    _minTapTargetSize = value;
    markNeedsLayout();
  }

  Size _trackSize;
  Size get trackSize => _trackSize;
  set trackSize(Size value) {
    if (_trackSize == value) return;
    _trackSize = value;
    markNeedsLayout();
  }

  ValueListenable<ShapeBorder> _trackShape;
  ValueListenable<ShapeBorder> get trackShape => _trackShape;
  set trackShape(ValueListenable<ShapeBorder> value) {
    if (_trackShape == value) return;
    _trackShape.removeListener(markNeedsPaint);
    _trackShape = value;
    _trackShape.addListener(markNeedsPaint);
    markNeedsPaint();
  }

  ValueListenable<Color> _trackColor;
  ValueListenable<Color> get trackColor => _trackColor;
  set trackColor(ValueListenable<Color> value) {
    if (_trackColor == value) return;
    _trackColor.removeListener(markNeedsPaint);
    _trackColor = value;
    _trackColor.addListener(markNeedsPaint);
    markNeedsPaint();
  }

  ValueListenable<Size> _handleSize;
  ValueListenable<Size> get handleSize => _handleSize;
  set handleSize(ValueListenable<Size> value) {
    if (_handleSize == value) return;
    _handleSize.removeListener(markNeedsLayout);
    _handleSize = value;
    _handleSize.addListener(markNeedsLayout);
    markNeedsLayout();
  }

  ShapeBorder _handleShape;
  ShapeBorder get handleShape => _handleShape;
  set handleShape(ShapeBorder value) {
    if (_handleShape == value) return;
    _handleShape = value;
    markNeedsPaint();
  }

  ValueListenable<Color> _handleColor;
  ValueListenable<Color> get handleColor => _handleColor;
  set handleColor(ValueListenable<Color> value) {
    if (_handleColor == value) return;
    _handleColor.removeListener(markNeedsPaint);
    _handleColor = value;
    _handleColor.addListener(markNeedsPaint);
    markNeedsPaint();
  }

  SwitchChildrenPaintOrder _childrenPaintOrder;
  SwitchChildrenPaintOrder get childrenPaintOrder => _childrenPaintOrder;
  set childrenPaintOrder(SwitchChildrenPaintOrder value) {
    if (_childrenPaintOrder == value) return;
    _childrenPaintOrder = value;
    markNeedsPaint();
  }

  SwitchChildPosition _trackChildPosition;
  SwitchChildPosition get trackChildPosition => _trackChildPosition;
  set trackChildPosition(SwitchChildPosition value) {
    if (_trackChildPosition == value) return;
    _trackChildPosition = value;
    markNeedsPaint();
  }

  SwitchChildPosition _handleChildPosition;
  SwitchChildPosition get handleChildPosition => _handleChildPosition;
  set handleChildPosition(SwitchChildPosition value) {
    if (_handleChildPosition == value) return;
    _handleChildPosition = value;
    markNeedsPaint();
  }

  TextDirection? _textDirection;
  TextDirection? get textDirection => _textDirection;
  set textDirection(TextDirection? value) {
    if (_textDirection == value) return;
    _textDirection = value;
  }

  RenderBox? get _trackChild => childForSlot(_SwitchSlot.trackChild);

  RenderBox? get _handleChild => childForSlot(_SwitchSlot.handleChild);

  Size _computeOuterSize() {
    return Size(
      math.max(
        trackSize.width,
        // This calculation was derived from handle center equations
        trackSize.width - trackSize.shortestSide + minTapTargetSize.width,
      ),
      math.max(trackSize.height, minTapTargetSize.height),
    );
  }

  Rect _computeInnerRect(Size outerSize) {
    assert(
      outerSize.width >= trackSize.width &&
          outerSize.height >= trackSize.height,
    );
    return Rect.fromLTWH(
      (outerSize.width - trackSize.width) / 2.0,
      (outerSize.height - trackSize.height) / 2.0,
      trackSize.width,
      trackSize.height,
    );
  }

  // Offset _computeHandleInnerCenter() {}
  Offset _computeHandleOuterCenter(Rect innerRect) {
    final innerCenterStart = trackSize.shortestSide / 2.0;
    final outerCenterStart = innerRect.left + innerCenterStart;
    final innerCenterEnd = trackSize.width - innerCenterStart;
    final outerCenterEnd = innerRect.left + innerCenterEnd;
    return Offset(
      lerpDouble(outerCenterStart, outerCenterEnd, _handlePosition.value)!,
      innerRect.top + innerRect.height / 2.0,
    );
  }

  Rect _computeHandleRect(Offset center) {
    final handleSize = this.handleSize.value;
    return Rect.fromLTWH(
      center.dx - handleSize.width / 2.0,
      center.dy - handleSize.height / 2.0,
      handleSize.width,
      handleSize.height,
    );
  }

  void _positionChild(RenderBox child, Offset position) {
    final parentData = child.parentData! as BoxParentData;
    parentData.offset = position;
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _handlePosition.addListener(markNeedsLayout);
    _trackShape.addListener(markNeedsPaint);
    _trackColor.addListener(markNeedsPaint);
    _handleSize.addListener(markNeedsLayout);
    _handleColor.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    _handleColor.removeListener(markNeedsPaint);
    _handleSize.removeListener(markNeedsLayout);
    _trackColor.removeListener(markNeedsPaint);
    _trackShape.removeListener(markNeedsPaint);
    _handlePosition.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return _computeOuterSize().width;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return _computeOuterSize().height;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return _computeOuterSize().width;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return _computeOuterSize().height;
  }

  @override
  void performLayout() {
    final outerSize = _computeOuterSize();
    final innerRect = _computeInnerRect(outerSize);

    final outerCenter = _computeHandleOuterCenter(innerRect);
    final trackChild = _trackChild;
    if (trackChild != null) {
      trackChild.layout(
        BoxConstraints(
          minWidth: 0.0,
          minHeight: 0.0,
          maxWidth: minTapTargetSize.width,
          maxHeight: minTapTargetSize.height,
        ),
        parentUsesSize: true,
      );
      final trackChildSize = trackChild.size;
      _positionChild(
        trackChild,
        Offset(
          outerCenter.dx - trackChildSize.width / 2.0,
          outerCenter.dy - trackChildSize.height / 2.0,
        ),
      );
    }
    final handleChild = _handleChild;
    if (handleChild != null) {
      final handleSize = this.handleSize.value;
      handleChild.layout(
        BoxConstraints(
          minWidth: 0.0,
          minHeight: 0.0,
          maxWidth: handleSize.width,
          maxHeight: handleSize.height,
        ),
        parentUsesSize: true,
      );
      final handleChildSize = handleChild.size;
      _positionChild(
        handleChild,
        Offset(
          outerCenter.dx - handleChildSize.width / 2.0,
          outerCenter.dy - handleChildSize.height / 2.0,
        ),
      );
    }
    size = outerSize;
  }

  void _paintTrack(PaintingContext context, Rect shiftedRect) {
    final trackPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = trackColor.value;
    trackShape.value
      ..paintInterior(context.canvas, shiftedRect, trackPaint)
      ..paint(context.canvas, shiftedRect);
  }

  void _paintTrackChild(PaintingContext context) {
    if (_trackChild case final trackChild?) {
      context.paintChild(
        trackChild,
        (trackChild.parentData! as BoxParentData).offset,
      );
    }
  }

  void _paintHandle(PaintingContext context, Rect shiftedRect) {
    final handlePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = handleColor.value;
    handleShape
      ..paintInterior(context.canvas, shiftedRect, handlePaint)
      ..paint(context.canvas, shiftedRect);
  }

  void _paintHandleChild(PaintingContext context) {
    if (_handleChild case final handleChild?) {
      context.paintChild(
        handleChild,
        (handleChild.parentData! as BoxParentData).offset,
      );
    }
  }

  void _paintChildFor(PaintingContext context, SwitchChildPosition position) {
    if (trackChildPosition == position && handleChildPosition == position) {
      switch (childrenPaintOrder) {
        case SwitchChildrenPaintOrder.trackChildIsTop:
          _paintHandleChild(context);
          _paintTrackChild(context);
        case SwitchChildrenPaintOrder.handleChildIsTop:
          _paintTrackChild(context);
          _paintHandleChild(context);
      }
    } else if (trackChildPosition == position) {
      _paintTrackChild(context);
    } else if (handleChildPosition == position) {
      _paintHandleChild(context);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // context.canvas.drawRect(offset & size, Paint()..color = Colors.red);
    final innerRect = _computeInnerRect(size);
    final outerCenter = _computeHandleOuterCenter(innerRect);
    final handleRect = _computeHandleRect(outerCenter);

    late int debugPreviousCanvasSaveCount;
    context.canvas.save();
    assert(() {
      debugPreviousCanvasSaveCount = context.canvas.getSaveCount();
      return true;
    }());

    if (offset != Offset.zero) {
      context.canvas.translate(offset.dx, offset.dy);
    }

    _paintChildFor(context, SwitchChildPosition.bottom);

    _paintTrack(context, innerRect);

    _paintChildFor(context, SwitchChildPosition.middle);

    _paintHandle(context, handleRect);

    _paintChildFor(context, SwitchChildPosition.top);

    assert(() {
      final int debugNewCanvasSaveCount = context.canvas.getSaveCount();
      return debugNewCanvasSaveCount == debugPreviousCanvasSaveCount;
    }());
    context.canvas.restore();

    assert(() {
      paintOverflowIndicator(context, offset, Offset.zero & size, innerRect);
      return true;
    }());
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (super.hitTest(result, position: position)) {
      return true;
    }
    final trackChild = _trackChild;
    if (trackChild == null) {
      return false;
    }
    final Offset center = trackChild.size.center(Offset.zero);
    return result.addWithRawTransform(
      transform: MatrixUtils.forceToPoint(center),
      position: center,
      hitTest: (result, position) {
        assert(position == center);
        return trackChild.hitTest(result, position: center);
      },
    );
  }
}
