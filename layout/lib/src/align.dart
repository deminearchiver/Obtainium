import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart' as flutter_widgets;

/// A widget that aligns its child within itself and optionally sizes itself
/// based on the child's size.
///
/// For example, to align a box at the bottom right, you would pass this box a
/// tight constraint that is bigger than the child's natural size,
/// with an alignment of [Alignment.bottomRight].
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=g2E7yl3MwMk}
///
/// This widget will be as big as possible if its dimensions are constrained and
/// [widthFactor] and [heightFactor] are null. If a dimension is unconstrained
/// and the corresponding size factor is null then the widget will match its
/// child's size in that dimension. If a size factor is non-null then the
/// corresponding dimension of this widget will be the product of the child's
/// dimension and the size factor. For example if widthFactor is 2.0 then
/// the width of this widget will always be twice its child's width.
///
/// {@tool snippet}
///
/// The [Align] widget in this example uses one of the defined constants from
/// [Alignment], [Alignment.topRight]. This places the [FlutterLogo] in the top
/// right corner of the parent blue [Container].
///
/// ![A blue square container with the Flutter logo in the top right corner.](https://flutter.github.io/assets-for-api-docs/assets/widgets/align_constant.png)
///
/// ```dart
/// Align.center(
///   child: Container(
///     height: 120.0,
///     width: 120.0,
///     color: Colors.blue[50],
///     child: const Align(
///       alignment: Alignment.topRight,
///       child: FlutterLogo(
///         size: 60,
///       ),
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// ## How it works
///
/// The [alignment] property describes a point in the `child`'s coordinate system
/// and a different point in the coordinate system of this widget. The [Align]
/// widget positions the `child` such that both points are lined up on top of
/// each other.
///
/// {@tool snippet}
///
/// The [Alignment] used in the following example defines two points:
///
///   * (0.2 * width of [FlutterLogo]/2 + width of [FlutterLogo]/2, 0.6 * height
///     of [FlutterLogo]/2 + height of [FlutterLogo]/2) = (36.0, 48.0) in the
///     coordinate system of the [FlutterLogo].
///   * (0.2 * width of [Align]/2 + width of [Align]/2, 0.6 * height
///     of [Align]/2 + height of [Align]/2) = (72.0, 96.0) in the
///     coordinate system of the [Align] widget (blue area).
///
/// The [Align] widget positions the [FlutterLogo] such that the two points are on
/// top of each other. In this example, the top left of the [FlutterLogo] will
/// be placed at (72.0, 96.0) - (36.0, 48.0) = (36.0, 48.0) from the top left of
/// the [Align] widget.
///
/// ![A blue square container with the Flutter logo positioned according to the
/// Alignment specified above. A point is marked at the center of the container
/// for the origin of the Alignment coordinate system.](https://flutter.github.io/assets-for-api-docs/assets/widgets/align_alignment.png)
///
/// ```dart
/// Align.center(
///   child: Container(
///     height: 120.0,
///     width: 120.0,
///     color: Colors.blue[50],
///     child: const Align(
///       alignment: Alignment(0.2, 0.6),
///       child: FlutterLogo(
///         size: 60,
///       ),
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// {@tool snippet}
///
/// The [FractionalOffset] used in the following example defines two points:
///
///   * (0.2 * width of [FlutterLogo], 0.6 * height of [FlutterLogo]) = (12.0, 36.0)
///     in the coordinate system of the [FlutterLogo].
///   * (0.2 * width of [Align], 0.6 * height of [Align]) = (24.0, 72.0) in the
///     coordinate system of the [Align] widget (blue area).
///
/// The [Align] widget positions the [FlutterLogo] such that the two points are on
/// top of each other. In this example, the top left of the [FlutterLogo] will
/// be placed at (24.0, 72.0) - (12.0, 36.0) = (12.0, 36.0) from the top left of
/// the [Align] widget.
///
/// The [FractionalOffset] class uses a coordinate system with an origin in the top-left
/// corner of the [Container] in difference to the center-oriented system used in
/// the example above with [Alignment].
///
/// ![A blue square container with the Flutter logo positioned according to the
/// FractionalOffset specified above. A point is marked at the top left corner
/// of the container for the origin of the FractionalOffset coordinate system.](https://flutter.github.io/assets-for-api-docs/assets/widgets/align_fractional_offset.png)
///
/// ```dart
/// Align.center(
///   child: Container(
///     height: 120.0,
///     width: 120.0,
///     color: Colors.blue[50],
///     child: const Align(
///       alignment: FractionalOffset(0.2, 0.6),
///       child: FlutterLogo(
///         size: 60,
///       ),
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [AnimatedAlign], which animates changes in [alignment] smoothly over a
///    given duration.
///  * [CustomSingleChildLayout], which uses a delegate to control the layout of
///    a single child.
///  * [FractionallySizedBox], which sizes its child based on a fraction of its
///    own size and positions the child according to an [Alignment] value.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
class Align extends flutter_widgets.Align {
  /// Creates an alignment widget.
  const Align({
    super.key,
    required super.alignment,
    super.widthFactor,
    super.heightFactor,
    super.child,
  });

  /// Creates an alignment widget
  /// with alignment set to [Alignment.topCenter].
  const Align.topCenter({
    super.key,
    super.widthFactor,
    super.heightFactor,
    super.child,
  }) : super(alignment: Alignment.topCenter);

  /// Creates an alignment widget
  /// with alignment set to [Alignment.center].
  const Align.center({
    super.key,
    super.widthFactor,
    super.heightFactor,
    super.child,
  }) : super(alignment: Alignment.center);

  /// Creates an alignment widget
  /// with alignment set to [Alignment.bottomCenter].
  const Align.bottomCenter({
    super.key,
    super.widthFactor,
    super.heightFactor,
    super.child,
  }) : super(alignment: Alignment.bottomCenter);

  /// Creates an alignment widget
  /// with alignment set to [Alignment.topLeft].
  const Align.topLeft({
    super.key,
    super.widthFactor,
    super.heightFactor,
    super.child,
  }) : super(alignment: Alignment.topLeft);

  /// Creates an alignment widget
  /// with alignment set to [Alignment.centerLeft].
  const Align.centerLeft({
    super.key,
    super.widthFactor,
    super.heightFactor,
    super.child,
  }) : super(alignment: Alignment.centerLeft);

  /// Creates an alignment widget
  /// with alignment set to [Alignment.bottomLeft].
  const Align.bottomLeft({
    super.key,
    super.widthFactor,
    super.heightFactor,
    super.child,
  }) : super(alignment: Alignment.bottomLeft);

  /// Creates an alignment widget
  /// with alignment set to [Alignment.topRight].
  const Align.topRight({
    super.key,
    super.widthFactor,
    super.heightFactor,
    super.child,
  }) : super(alignment: Alignment.topRight);

  /// Creates an alignment widget
  /// with alignment set to [Alignment.centerRight].
  const Align.centerRight({
    super.key,
    super.widthFactor,
    super.heightFactor,
    super.child,
  }) : super(alignment: Alignment.centerRight);

  /// Creates an alignment widget
  /// with alignment set to [Alignment.bottomRight].
  const Align.bottomRight({
    super.key,
    super.widthFactor,
    super.heightFactor,
    super.child,
  }) : super(alignment: Alignment.bottomRight);

  /// Creates an alignment widget
  /// with alignment set to [AlignmentDirectional.topStart].
  const Align.topStart({
    super.key,
    super.widthFactor,
    super.heightFactor,
    super.child,
  }) : super(alignment: AlignmentDirectional.topStart);

  /// Creates an alignment widget
  /// with alignment set to [AlignmentDirectional.centerStart].
  const Align.centerStart({
    super.key,
    super.widthFactor,
    super.heightFactor,
    super.child,
  }) : super(alignment: AlignmentDirectional.centerStart);

  /// Creates an alignment widget
  /// with alignment set to [AlignmentDirectional.bottomStart].
  const Align.bottomStart({
    super.key,
    super.widthFactor,
    super.heightFactor,
    super.child,
  }) : super(alignment: AlignmentDirectional.bottomStart);

  /// Creates an alignment widget
  /// with alignment set to [AlignmentDirectional.topEnd].
  const Align.topEnd({
    super.key,
    super.widthFactor,
    super.heightFactor,
    super.child,
  }) : super(alignment: AlignmentDirectional.topEnd);

  /// Creates an alignment widget
  /// with alignment set to [AlignmentDirectional.centerEnd].
  const Align.centerEnd({
    super.key,
    super.widthFactor,
    super.heightFactor,
    super.child,
  }) : super(alignment: AlignmentDirectional.centerEnd);

  /// Creates an alignment widget
  /// with alignment set to [AlignmentDirectional.bottomEnd].
  const Align.bottomEnd({
    super.key,
    super.widthFactor,
    super.heightFactor,
    super.child,
  }) : super(alignment: AlignmentDirectional.bottomEnd);
}

/// A widget that centers its child within itself.
///
/// This widget will be as big as possible if its dimensions are constrained and
/// [widthFactor] and [heightFactor] are null. If a dimension is unconstrained
/// and the corresponding size factor is null then the widget will match its
/// child's size in that dimension. If a size factor is non-null then the
/// corresponding dimension of this widget will be the product of the child's
/// dimension and the size factor. For example if widthFactor is 2.0 then
/// the width of this widget will always be twice its child's width.
///
/// See also:
///
///  * [Align], which lets you arbitrarily position a child within itself,
///    rather than just centering it.
///  * [Container], a convenience widget that combines common painting,
///    positioning, and sizing widgets.
///  * The [catalog of layout widgets](https://flutter.dev/widgets/layout/).
@Deprecated("Use Align.center instead")
class Center extends Align {
  /// Creates a widget that centers its child.
  @Deprecated("Use Align.center instead")
  const Center({super.key, super.widthFactor, super.heightFactor, super.child})
    : super.center();
}
