import 'package:material/src/flutter.dart';
import 'package:flutter/scheduler.dart';

enum FocusRingPlacement { inward, outward }

extension OverlayChildLayoutInfoExtension on OverlayChildLayoutInfo {
  double get translateX => childPaintTransform.storage[12];
  double get translateY => childPaintTransform.storage[13];
  double get scaleX => childPaintTransform[0];
  double get scaleY => childPaintTransform[5];
}

typedef FocusRingLayoutBuilder =
    Widget Function(
      BuildContext context,
      OverlayChildLayoutInfo info,
      Widget child,
    );

class FocusRing extends StatefulWidget {
  const FocusRing({
    super.key,
    required this.visible,
    required this.placement,
    this.layoutBuilder = defaultLayoutBuilder,
    required this.child,
  });

  final bool visible;

  final FocusRingPlacement placement;

  final FocusRingLayoutBuilder layoutBuilder;

  final Widget child;

  @override
  State<FocusRing> createState() => _FocusRingState();

  static Widget defaultLayoutBuilder(
    BuildContext _,
    OverlayChildLayoutInfo _,
    Widget child,
  ) => child;
}

class _FocusRingState extends State<FocusRing>
    with SingleTickerProviderStateMixin {
  final OverlayPortalController _overlayPortalController =
      OverlayPortalController();

  late AnimationController _widthController;

  final Tween<double> _growValueTween = Tween<double>(begin: 0.0);
  final Tween<double> _shrinkValueTween = Tween<double>();
  final CurveTween _growCurveTween = CurveTween(curve: Curves.linear);
  final CurveTween _shrinkCurveTween = CurveTween(curve: Curves.linear);

  late Animation<double> _widthAnimation;

  late EasingThemeData _easingTheme;
  late FocusRingThemeData _focusRingTheme;

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

  @override
  void initState() {
    super.initState();
    if (widget.visible) {
      _toggleOverlay(true);
    }
    _widthController = AnimationController(
      vsync: this,
      value: widget.visible ? 1.0 : 0.0,
    )..addStatusListener(_animationStatusListener);
    _widthAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: _growValueTween.chain(_growCurveTween),
        weight: 0.25,
      ),
      TweenSequenceItem(
        tween: _shrinkValueTween.chain(_shrinkCurveTween),
        weight: 0.75,
      ),
    ]).animate(_widthController);
  }

  @override
  void didUpdateWidget(covariant FocusRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible != oldWidget.visible) {
      if (widget.visible) {
        _widthController.animateTo(1.0, duration: _focusRingTheme.duration);
      } else {
        _widthController.animateBack(0.0, duration: Duration.zero);
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _easingTheme = EasingTheme.of(context);
    _focusRingTheme = FocusRingTheme.of(context);

    _growValueTween.end = _focusRingTheme.activeWidth;
    _shrinkValueTween.begin = _focusRingTheme.activeWidth;
    _shrinkValueTween.end = _focusRingTheme.width;

    _growCurveTween.curve = _easingTheme.standard;
    _shrinkCurveTween.curve = _easingTheme.standard;
  }

  @override
  void dispose() {
    _widthController.dispose();
    super.dispose();
  }

  // Widget _buildGlobalOverlay(
  //   BuildContext context,
  //   OverlayChildLayoutInfo info,
  //   Widget child,
  // ) {
  //   final transform = info.childPaintTransform;
  //   final translateX = transform.storage[12];
  //   final translateY = transform.storage[13];
  //   final translationOffset = Offset(translateX, translateY);
  //   final scaleX = transform.storage[0];
  //   final scaleY = transform.storage[5];
  //   final childSize = info.childSize;
  //   final scaledChildSize = Size(
  //     childSize.width * scaleX,
  //     childSize.height * scaleY,
  //   );
  //   final focusIndicatorOffset = 2.0;
  //   final scaledFocusIndicatorSize = Size(
  //     childSize.width + focusIndicatorOffset * 2.0,
  //     childSize.height + focusIndicatorOffset * 2.0,
  //   );
  //   return IgnorePointer(
  //     child: Align.topLeft(
  //       child: Transform.translate(
  //         offset: translationOffset,
  //         child: SizedBox.fromSize(
  //           size: scaledChildSize,
  //           child: Align.center(
  //             child: SizedBox.fromSize(
  //               size: scaledFocusIndicatorSize,
  //               child: child,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildLocalOverlay(
    BuildContext context,
    OverlayChildLayoutInfo info,
    Widget child,
  ) {
    // final focusIndicatorOffset = switch(widget.placement) {
    //   FocusRingPlacement.inward => _focusRingTheme.inwardOffset,
    //   FocusRingPlacement.outward => _focusRingTheme.outwardOffset,
    // };
    // final focusIndicatorSize = Size(
    //   info.childSize.width + focusIndicatorOffset * 2.0,
    //   info.childSize.height + focusIndicatorOffset * 2.0,
    // );
    final wrappedChild = widget.layoutBuilder(context, info, child);
    return IgnorePointer(
      child: Align.topLeft(
        child: Transform(
          transform: info.childPaintTransform,
          child: SizedBox.fromSize(size: info.childSize, child: wrappedChild),
        ),
      ),
    );
  }

  Widget _buildIndicator(BuildContext context) {
    final padding = switch (widget.placement) {
      FocusRingPlacement.inward => _focusRingTheme.inwardOffset,
      FocusRingPlacement.outward => -_focusRingTheme.outwardOffset,
    };
    final strokeAlign = switch (widget.placement) {
      FocusRingPlacement.inward => BorderSide.strokeAlignInside,
      FocusRingPlacement.outward => BorderSide.strokeAlignOutside,
    };
    return AnimatedBuilder(
      animation: _widthController,
      builder: (context, _) => Padding(
        padding: EdgeInsetsGeometry.all(padding),
        child: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: ShapeDecoration(
            shape: CornersBorder.rounded(
              corners: _focusRingTheme.shape,
              side: _widthAnimation.value > 0.0
                  ? BorderSide(
                      style: BorderStyle.solid,
                      color: _focusRingTheme.color,
                      width: _widthAnimation.value,
                      strokeAlign: strokeAlign,
                    )
                  : BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final indicator = _buildIndicator(context);
    return OverlayPortal.overlayChildLayoutBuilder(
      controller: _overlayPortalController,
      overlayChildBuilder: (context, info) =>
          _buildLocalOverlay(context, info, indicator),
      child: widget.child,
    );
  }
}

abstract class FocusRingThemeDataPartial {
  const FocusRingThemeDataPartial();

  const factory FocusRingThemeDataPartial.from({
    double? activeWidth,
    Color? color,
    Duration? duration,
    double? inwardOffset,
    double? outwardOffset,
    CornersGeometry? shape,
    double? width,
  }) = _FocusRingThemeDataPartial;

  double? get activeWidth;
  Color? get color;
  Duration? get duration;
  double? get inwardOffset;
  double? get outwardOffset;
  CornersGeometry? get shape;
  double? get width;

  FocusRingThemeDataPartial copyWith({
    double? activeWidth,
    Color? color,
    Duration? duration,
    double? inwardOffset,
    double? outwardOffset,
    CornersGeometry? shape,
    double? width,
  }) {
    if (activeWidth == null &&
        color == null &&
        duration == null &&
        inwardOffset == null &&
        outwardOffset == null &&
        shape == null &&
        width == null) {
      return this;
    }
    return FocusRingThemeDataPartial.from(
      activeWidth: activeWidth ?? this.activeWidth,
      color: color ?? this.color,
      duration: duration ?? this.duration,
      inwardOffset: inwardOffset ?? this.inwardOffset,
      outwardOffset: outwardOffset ?? this.outwardOffset,
      shape: shape ?? this.shape,
      width: width ?? this.width,
    );
  }

  FocusRingThemeDataPartial merge(FocusRingThemeDataPartial? other) {
    if (other == null) return this;
    return copyWith(
      activeWidth: other.activeWidth,
      color: other.color,
      duration: other.duration,
      inwardOffset: other.inwardOffset,
      outwardOffset: other.outwardOffset,
      shape: other.shape,
      width: other.width,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is FocusRingThemeDataPartial &&
            activeWidth == other.activeWidth &&
            color == other.color &&
            duration == other.duration &&
            inwardOffset == other.inwardOffset &&
            outwardOffset == other.outwardOffset &&
            shape == other.shape &&
            width == other.width;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    activeWidth,
    color,
    duration,
    inwardOffset,
    outwardOffset,
    shape,
    width,
  );
}

class _FocusRingThemeDataPartial extends FocusRingThemeDataPartial {
  const _FocusRingThemeDataPartial({
    this.activeWidth,
    this.color,
    this.duration,
    this.inwardOffset,
    this.outwardOffset,
    this.shape,
    this.width,
  });

  @override
  final double? activeWidth;

  @override
  final Color? color;

  @override
  final Duration? duration;

  @override
  final double? inwardOffset;

  @override
  final double? outwardOffset;

  @override
  final CornersGeometry? shape;

  @override
  final double? width;
}

abstract class FocusRingThemeData extends FocusRingThemeDataPartial {
  const FocusRingThemeData();

  const factory FocusRingThemeData.from({
    required double activeWidth,
    required Color color,
    required Duration duration,
    required double inwardOffset,
    required double outwardOffset,
    required CornersGeometry shape,
    required double width,
  }) = _FocusRingThemeData;

  @override
  double get activeWidth;

  @override
  Color get color;

  @override
  Duration get duration;

  @override
  double get inwardOffset;

  @override
  double get outwardOffset;

  @override
  CornersGeometry get shape;

  @override
  double get width;

  @override
  FocusRingThemeData copyWith({
    double? activeWidth,
    Color? color,
    Duration? duration,
    double? inwardOffset,
    double? outwardOffset,
    CornersGeometry? shape,
    double? width,
  }) {
    if (activeWidth == null &&
        color == null &&
        duration == null &&
        inwardOffset == null &&
        outwardOffset == null &&
        shape == null &&
        width == null) {
      return this;
    }
    return FocusRingThemeData.from(
      activeWidth: activeWidth ?? this.activeWidth,
      color: color ?? this.color,
      duration: duration ?? this.duration,
      inwardOffset: inwardOffset ?? this.inwardOffset,
      outwardOffset: outwardOffset ?? this.outwardOffset,
      shape: shape ?? this.shape,
      width: width ?? this.width,
    );
  }

  @override
  FocusRingThemeData merge(FocusRingThemeDataPartial? other) {
    if (other == null) return this;
    return copyWith(
      activeWidth: other.activeWidth,
      color: other.color,
      duration: other.duration,
      inwardOffset: other.inwardOffset,
      outwardOffset: other.outwardOffset,
      shape: other.shape,
      width: other.width,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is FocusRingThemeData &&
            activeWidth == other.activeWidth &&
            color == other.color &&
            duration == other.duration &&
            inwardOffset == other.inwardOffset &&
            outwardOffset == other.outwardOffset &&
            shape == other.shape &&
            width == other.width;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    activeWidth,
    color,
    duration,
    inwardOffset,
    outwardOffset,
    shape,
    width,
  );
}

class _FocusRingThemeData extends FocusRingThemeData {
  const _FocusRingThemeData({
    required this.activeWidth,
    required this.color,
    required this.duration,
    required this.inwardOffset,
    required this.outwardOffset,
    required this.shape,
    required this.width,
  });

  @override
  final double activeWidth;

  @override
  final Color color;

  @override
  final Duration duration;

  @override
  final double inwardOffset;

  @override
  final double outwardOffset;

  @override
  final CornersGeometry shape;

  @override
  final double width;
}

class _FocusRingThemeDataFallback extends FocusRingThemeData {
  const _FocusRingThemeDataFallback({
    required ColorThemeData colorTheme,
    required ShapeThemeData shapeTheme,
    required DurationThemeData durationTheme,
  }) : _colorTheme = colorTheme,
       _shapeTheme = shapeTheme,
       _durationTheme = durationTheme;

  final ColorThemeData _colorTheme;
  final ShapeThemeData _shapeTheme;
  final DurationThemeData _durationTheme;

  @override
  double get activeWidth => 8.0;

  @override
  Color get color => _colorTheme.secondary;

  @override
  Duration get duration => _durationTheme.long4;

  @override
  double get inwardOffset => 0.0;

  @override
  double get outwardOffset => 2.0;

  @override
  CornersGeometry get shape => Corners.all(_shapeTheme.corner.full);

  @override
  double get width => 3.0;
}

class FocusRingTheme extends InheritedTheme {
  const FocusRingTheme({super.key, required this.data, required super.child});

  final FocusRingThemeData data;

  @override
  bool updateShouldNotify(covariant FocusRingTheme oldWidget) {
    return data != oldWidget.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FocusRingTheme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<FocusRingThemeData>("data", data));
  }

  static Widget merge({
    Key? key,
    required FocusRingThemeDataPartial data,
    required Widget child,
  }) => Builder(
    builder: (context) =>
        FocusRingTheme(key: key, data: of(context).merge(data), child: child),
  );

  static FocusRingThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FocusRingTheme>()?.data;
  }

  static FocusRingThemeData of(BuildContext context) {
    final result = maybeOf(context);
    if (result != null) return result;
    return _FocusRingThemeDataFallback(
      colorTheme: ColorTheme.of(context),
      shapeTheme: ShapeTheme.of(context),
      durationTheme: DurationTheme.of(context),
    );
  }
}
