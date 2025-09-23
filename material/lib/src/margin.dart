import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Margin extends SingleChildRenderObjectWidget {
  /// Creates a widget that insets its child.
  const Margin({super.key, required this.padding, super.child});

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry padding;

  @override
  RenderMargin createRenderObject(BuildContext context) {
    return RenderMargin(
      padding: padding,
      textDirection: Directionality.maybeOf(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderMargin renderObject) {
    renderObject
      ..padding = padding
      ..textDirection = Directionality.maybeOf(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>("padding", padding));
  }
}

class RenderMargin extends RenderShiftedBox {
  /// Creates a render object that insets its child.
  ///
  /// The [padding] argument must have non-negative insets.
  RenderMargin({
    required EdgeInsetsGeometry padding,
    TextDirection? textDirection,
    RenderBox? child,
  }) : /*assert(padding.isNonNegative),*/
       _textDirection = textDirection,
       _padding = padding,
       super(child);

  EdgeInsets? _resolvedPaddingCache;
  EdgeInsets get _resolvedPadding {
    final returnValue = _resolvedPaddingCache ??= padding.resolve(
      textDirection,
    );
    // assert(returnValue.isNonNegative);
    return returnValue;
  }

  void _markNeedResolution() {
    _resolvedPaddingCache = null;
    markNeedsLayout();
  }

  /// The amount to pad the child in each dimension.
  ///
  /// If this is set to an [EdgeInsetsDirectional] object, then [textDirection]
  /// must not be null.
  EdgeInsetsGeometry get padding => _padding;
  EdgeInsetsGeometry _padding;
  set padding(EdgeInsetsGeometry value) {
    // assert(value.isNonNegative);
    if (_padding == value) {
      return;
    }
    _padding = value;
    _markNeedResolution();
  }

  /// The text direction with which to resolve [padding].
  ///
  /// This may be changed to null, but only after the [padding] has been changed
  /// to a value that does not depend on the direction.
  TextDirection? get textDirection => _textDirection;
  TextDirection? _textDirection;
  set textDirection(TextDirection? value) {
    if (_textDirection == value) {
      return;
    }
    _textDirection = value;
    _markNeedResolution();
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final padding = _resolvedPadding;
    if (child case final child?) {
      // Relies on double.infinity absorption.
      return math.max(
        0.0,
        child.getMinIntrinsicWidth(math.max(0.0, height - padding.vertical)) +
            padding.horizontal,
      );
    }
    return math.max(0.0, padding.horizontal);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final padding = _resolvedPadding;
    if (child case final child?) {
      // Relies on double.infinity absorption.
      return math.max(
        0.0,
        child.getMaxIntrinsicWidth(math.max(0.0, height - padding.vertical)) +
            padding.horizontal,
      );
    }
    return math.max(0.0, padding.horizontal);
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final padding = _resolvedPadding;
    if (child case final child?) {
      // Relies on double.infinity absorption.
      return math.max(
        0.0,
        child.getMinIntrinsicHeight(math.max(0.0, width - padding.horizontal)) +
            padding.vertical,
      );
    }
    return math.max(0.0, padding.vertical);
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final padding = _resolvedPadding;
    if (child case final child?) {
      // Relies on double.infinity absorption.
      return math.max(
        0.0,
        child.getMaxIntrinsicHeight(math.max(0.0, width - padding.horizontal)) +
            padding.vertical,
      );
    }
    return math.max(0.0, padding.vertical);
  }

  @override
  @protected
  Size computeDryLayout(covariant BoxConstraints constraints) {
    final padding = _resolvedPadding;
    if (child case final child?) {
      final innerConstraints = constraints.deflate(padding);
      final childSize = child.getDryLayout(innerConstraints);
      return constraints.constrain(
        Size(
          math.max(0.0, padding.horizontal + childSize.width),
          math.max(0.0, padding.vertical + childSize.height),
        ),
      );
    }
    return constraints.constrain(
      Size(math.max(0.0, padding.horizontal), math.max(0.0, padding.vertical)),
    );
  }

  @override
  double? computeDryBaseline(
    covariant BoxConstraints constraints,
    TextBaseline baseline,
  ) {
    final child = this.child;
    if (child == null) {
      return null;
    }
    final EdgeInsets padding = _resolvedPadding;
    final BoxConstraints innerConstraints = constraints.deflate(padding);
    final BaselineOffset result =
        BaselineOffset(child.getDryBaseline(innerConstraints, baseline)) +
        padding.top;
    return result.offset;
  }

  @override
  void performLayout() {
    final constraints = this.constraints;
    final padding = _resolvedPadding;
    if (child case final child?) {
      final innerConstraints = constraints.deflate(padding);
      child.layout(innerConstraints, parentUsesSize: true);

      final childParentData = child.parentData! as BoxParentData;
      childParentData.offset = Offset(padding.left, padding.top);

      size = constraints.constrain(
        Size(
          math.max(0.0, padding.horizontal + child.size.width),
          math.max(0.0, padding.vertical + child.size.height),
        ),
      );
    } else {
      size = constraints.constrain(Size(padding.horizontal, padding.vertical));
    }
  }

  @override
  void debugPaintSize(PaintingContext context, Offset offset) {
    super.debugPaintSize(context, offset);
    assert(() {
      final outerRect = offset & size;
      debugPaintPadding(
        context.canvas,
        outerRect,
        child != null ? _resolvedPaddingCache!.deflateRect(outerRect) : null,
      );
      return true;
    }());
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>("padding", padding));
    properties.add(
      EnumProperty<TextDirection>(
        "textDirection",
        textDirection,
        defaultValue: null,
      ),
    );
  }
}
