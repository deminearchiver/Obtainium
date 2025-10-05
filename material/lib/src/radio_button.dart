import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart' as flutter;

import 'package:material/src/deprecated_animation.dart';
import 'package:material/src/flutter.dart';

class RadioButton extends StatefulWidget {
  const RadioButton({super.key, required this.onTap, required this.selected});

  final VoidCallback? onTap;
  final bool selected;

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton>
    with TickerProviderStateMixin {
  bool get _isSelected => widget.selected;

  late final WidgetStatesController _statesController;

  late AnimationController _animationController;
  late AnimationController _colorController;
  final Tween<Color?> _iconColorTween = ColorTween();
  late Animation<Color?> _iconColorAnimation;

  late ColorThemeData _colorTheme;
  late ShapeThemeData _shapeTheme;
  late StateThemeData _stateTheme;
  late SpringThemeData _springTheme;

  WidgetStateProperty<double> get _stateLayerSize =>
      const WidgetStatePropertyAll(40.0);

  WidgetStateProperty<ShapeBorder> get _stateLayerShape =>
      WidgetStatePropertyAll(
        CornersBorder.rounded(corners: Corners.all(_shapeTheme.corner.full)),
      );

  WidgetStateProperty<Color> get _stateLayerColor =>
      WidgetStateProperty.resolveWith(
        (_) => _isSelected ? _colorTheme.primary : _colorTheme.onSurface,
      );

  WidgetStateProperty<double> get _stateLayerOpacity =>
      _stateTheme.stateLayerOpacity;

  WidgetStateProperty<double> get _iconSize =>
      const WidgetStatePropertyAll(20.0);

  WidgetStateProperty<Color> get _iconColor =>
      WidgetStateProperty.resolveWith((states) {
        final isSelected = _isSelected;
        if (states.contains(WidgetState.disabled)) {
          return isSelected
              ? _colorTheme.onSurface.withValues(alpha: 0.38)
              : _colorTheme.onSurface.withValues(alpha: 0.38);
        }
        if (states.contains(WidgetState.pressed)) {
          return isSelected ? _colorTheme.primary : _colorTheme.onSurface;
        }
        if (states.contains(WidgetState.focused)) {
          return isSelected ? _colorTheme.primary : _colorTheme.onSurface;
        }
        if (states.contains(WidgetState.hovered)) {
          return isSelected ? _colorTheme.primary : _colorTheme.onSurface;
        }
        return isSelected ? _colorTheme.primary : _colorTheme.onSurfaceVariant;
      });

  void _updateColorAnimations({required Color iconColor}) {
    // The animation is already in progress.
    // We have no point of triggering it again
    // because it would animate to the same value.
    if (iconColor == _iconColorTween.end) {
      return;
    }

    _iconColorTween.begin = _iconColorAnimation.value ?? iconColor;
    _iconColorTween.end = iconColor;

    // We don't have to animate between states
    // if the initial state is the same as the target state.
    if (_iconColorTween.begin == _iconColorTween.end) {
      return;
    }

    final spring = _springTheme.defaultEffects;
    final simulation = SpringSimulation(
      spring.toSpringDescription(),
      0.0,
      1.0,
      0.0,
    );
    _colorController.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();

    final isDisabled = widget.onTap == null;
    _statesController =
        WidgetStatesController({if (isDisabled) WidgetState.disabled})
          ..addListener(() {
            setState(() {});
          });

    _animationController = AnimationController.unbounded(
      vsync: this,
      value: widget.selected ? 1.0 : 0.0,
    );
    _colorController = AnimationController(vsync: this, value: 0.0);
    _iconColorAnimation = _iconColorTween.animate(_colorController);
  }

  @override
  void didUpdateWidget(covariant RadioButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected != oldWidget.selected) {
      const springTheme = SpringThemeData.expressive();
      final spring = springTheme.fastSpatial;
      final oldValue = _animationController.value;
      final newValue = widget.selected ? 1.0 : 0.0;
      final simulation = SpringSimulation(
        spring.toSpringDescription(),
        oldValue,
        newValue,
        0.0,
      );
      if (newValue >= oldValue) {
        _animationController.animateWith(simulation);
      } else {
        _animationController.animateBackWith(simulation);
      }
    }
    if (widget.onTap != oldWidget.onTap) {
      final isDisabled = widget.onTap == null;
      if (isDisabled) {
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
    _springTheme = SpringTheme.of(context);
  }

  @override
  void dispose() {
    _colorController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Set<WidgetState> states = Set.of(_statesController.value);

    const minTapTargetSize = Size.square(48.0);
    final stateLayerSize = _stateLayerSize.resolve(states);
    final stateLayerShape = _stateLayerShape.resolve(states);
    final iconSize = _iconSize.resolve(states);
    final iconColor = _iconColor.resolve(states);

    _updateColorAnimations(iconColor: iconColor);

    final child = SizedBox.square(
      dimension: stateLayerSize,
      child: InkWell(
        statesController: _statesController,
        customBorder: stateLayerShape,
        overlayColor: WidgetStateLayerColor(
          color: _stateLayerColor,
          opacity: _stateLayerOpacity,
        ),
        onTap: widget.onTap,
      ),
    );

    // TODO: add FocusRing
    return RepaintBoundary(
      child: Semantics(
        enabled: !states.contains(WidgetState.disabled),
        label: null,
        checked: widget.selected,
        child: Align.center(
          child: Material(
            animationDuration: Duration.zero,
            type: MaterialType.transparency,
            clipBehavior: Clip.none,
            color: Colors.transparent,
            child: _AnimatedRadioButton(
              minTapTargetSize: const _ValueListenable(minTapTargetSize),
              iconSize: _ValueListenable(iconSize),
              iconColor: _iconColorAnimation.mapValue(
                (value) => value ?? iconColor,
              ),
              animation: _animationController,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedRadioButton extends SingleChildRenderObjectWidget {
  const _AnimatedRadioButton({
    super.key,
    required this.minTapTargetSize,
    required this.iconSize,
    required this.iconColor,
    required this.animation,
    super.child,
  });

  final ValueListenable<Size> minTapTargetSize;
  final ValueListenable<double> iconSize;
  final ValueListenable<Color> iconColor;
  final ValueListenable<double> animation;

  @override
  _RenderAnimatedRadioButton createRenderObject(BuildContext context) {
    return _RenderAnimatedRadioButton(
      minTapTargetSize: minTapTargetSize,
      iconSize: iconSize,
      iconColor: iconColor,
      animation: animation,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderAnimatedRadioButton renderObject,
  ) {
    renderObject
      ..minTapTargetSize = minTapTargetSize
      ..iconSize = iconSize
      ..iconColor = iconColor
      ..animation = animation;
  }
}

class _RenderAnimatedRadioButton extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  _RenderAnimatedRadioButton({
    required ValueListenable<Size> minTapTargetSize,
    required ValueListenable<double> iconSize,
    required ValueListenable<Color> iconColor,
    required ValueListenable<double> animation,
    RenderBox? child,
  }) : _minTapTargetSize = minTapTargetSize,
       _iconSize = iconSize,
       _iconColor = iconColor,
       _animation = animation {
    this.child = child;
  }

  ValueListenable<Size> _minTapTargetSize;
  ValueListenable<Size> get minTapTargetSize => _minTapTargetSize;
  set minTapTargetSize(ValueListenable<Size> value) {
    if (_minTapTargetSize == value) return;
    _minTapTargetSize.removeListener(markNeedsLayout);
    _minTapTargetSize = value;
    _minTapTargetSize.addListener(markNeedsLayout);
  }

  ValueListenable<double> _iconSize;
  ValueListenable<double> get iconSize => _iconSize;
  set iconSize(ValueListenable<double> value) {
    if (_iconSize == value) return;
    _iconSize.removeListener(markNeedsLayout);
    _iconSize = value;
    _iconSize.addListener(markNeedsLayout);
  }

  ValueListenable<Color> _iconColor;
  ValueListenable<Color> get iconColor => _iconColor;
  set iconColor(ValueListenable<Color> value) {
    if (_iconColor == value) return;
    _iconColor.removeListener(markNeedsLayout);
    _iconColor = value;
    _iconColor.addListener(markNeedsLayout);
  }

  ValueListenable<double> _animation;
  ValueListenable<double> get animation => _animation;
  set animation(ValueListenable<double> value) {
    if (_animation == value) return;
    _animation.removeListener(markNeedsPaint);
    _animation = value;
    _animation.addListener(markNeedsPaint);
  }

  Size _computeOuterSize() {
    final minTapTargetSize = this.minTapTargetSize.value;
    final iconSize = this.iconSize.value;
    return Size(
      math.max(minTapTargetSize.width, iconSize),
      math.max(minTapTargetSize.height, iconSize),
    );
  }

  // Offset _computeOuterCenter(Size outerSize) => outerSize.center(Offset.zero);
  Rect _computeIconRect(Offset center) {
    final iconSize = this.iconSize.value;
    return Rect.fromCenter(center: center, width: iconSize, height: iconSize);
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    minTapTargetSize.addListener(markNeedsLayout);
    iconSize.addListener(markNeedsLayout);
    iconColor.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    _animation.removeListener(markNeedsPaint);
    iconColor.removeListener(markNeedsPaint);
    iconSize.removeListener(markNeedsLayout);
    minTapTargetSize.removeListener(markNeedsLayout);
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

  void _positionChild(RenderBox child, Offset position) {
    final parentData = child.parentData! as BoxParentData;
    parentData.offset = position;
  }

  @override
  void performLayout() {
    final outerSize = _computeOuterSize();
    final center = outerSize.center(Offset.zero);
    if (child case final child?) {
      child.layout(
        BoxConstraints(
          minWidth: 0.0,
          minHeight: 0.0,
          maxWidth: outerSize.width,
          maxHeight: outerSize.height,
        ),
        parentUsesSize: true,
      );
      final childSize = child.size;
      _positionChild(
        child,
        Offset(
          center.dx - childSize.width / 2.0,
          center.dy - childSize.height / 2.0,
        ),
      );
    } else {
      size = outerSize;
    }
    size = _computeOuterSize();
  }

  void _paintIcon(PaintingContext context) {
    const double relativeIconSize = 20.0;
    const double relativeCircleRadius = relativeIconSize / 2.0;
    const double relativeStrokeWidth = 2.0;
    const double relativeDotSize = 12.0;
    const double relativeDotRadius = relativeDotSize / 2.0;

    final center = size.center(Offset.zero);
    final scale = iconSize.value / relativeIconSize;

    // TODO: remove scaling once the magic numbers are extracted into theme.
    context.withCanvasTransform(() {
      context.canvas.translate(center.dx, center.dy);
      context.canvas.scale(scale);
      context.canvas.translate(-center.dx, -center.dy);
      final paint = Paint()..color = iconColor.value;
      paint
        ..style = PaintingStyle.stroke
        ..strokeWidth = relativeStrokeWidth;

      context.canvas.drawCircle(
        center,
        relativeCircleRadius - relativeStrokeWidth / 2.0,
        paint,
      );

      paint
        ..style = PaintingStyle.fill
        ..strokeWidth = 0.0;
      final dotRadius = lerpDouble(0.0, relativeDotRadius, animation.value)!;
      if (dotRadius > 0.0) {
        context.canvas.drawCircle(
          center,
          // TODO: dot radius shouldn't depend on stroke width.
          //  It's counter-intuitive.
          dotRadius - relativeStrokeWidth / 2.0,
          paint,
        );
      }
    });
  }

  void _paintChild(PaintingContext context) {
    if (child case final child?) {
      context.paintChild(child, (child.parentData! as BoxParentData).offset);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.withCanvasTransform(() {
      if (offset != Offset.zero) {
        context.canvas.translate(offset.dx, offset.dy);
      }
      _paintChild(context);
      _paintIcon(context);
    });
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (super.hitTest(result, position: position)) {
      return true;
    }
    final child = this.child;
    if (child == null) return false;
    final Offset center = child.size.center(Offset.zero);
    return result.addWithRawTransform(
      transform: MatrixUtils.forceToPoint(center),
      position: center,
      hitTest: (result, position) {
        assert(position == center);
        return child.hitTest(result, position: center);
      },
    );
  }
}

class _ValueListenable<T extends Object?> extends ValueListenable<T> {
  const _ValueListenable(this.value);

  @override
  final T value;

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}
}
