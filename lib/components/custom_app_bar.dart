import 'dart:ui';

import 'package:obtainium/flutter.dart';

const double _kCollapsedHeight = 64.0;
const double _kExpandedBottomPadding = 12.0;

// TODO: this is used in container color animation in Compose Material 3
const Curve _kFastOutLinearIn = Cubic(0.4, 0.0, 1.0, 1.0);

enum CustomAppBarType { small, mediumFlexible, largeFlexible }

enum CustomAppBarBehavior { duplicate, stretch }

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    super.key,
    // TODO: reorder CustomAppBar properties
    required this.type,
    this.behavior,
    this.collapsedPadding,
    this.expandedPadding,
    this.collapsedContainerColor,
    this.expandedContainerColor,
    this.collapsedTitleTextStyle,
    this.expandedTitleTextStyle,
    this.collapsedSubtitleTextStyle,
    this.expandedSubtitleTextStyle,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.bottom,
  });

  final CustomAppBarType type;
  final CustomAppBarBehavior? behavior;

  final EdgeInsetsGeometry? collapsedPadding;
  final EdgeInsetsGeometry? expandedPadding;

  final Color? collapsedContainerColor;
  final Color? expandedContainerColor;

  final TextStyle? collapsedTitleTextStyle;
  final TextStyle? expandedTitleTextStyle;

  final TextStyle? collapsedSubtitleTextStyle;
  final TextStyle? expandedSubtitleTextStyle;

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final PreferredSizeWidget? bottom;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late ColorThemeData _colorTheme;
  late TypescaleThemeData _typescaleTheme;
  ScrollPosition? _position;

  CustomAppBarBehavior get _behavior {
    if (widget.behavior case final behavior?) {
      return behavior;
    }
    // TODO: improve logic for resolving the default value of CustomAppBar.behavior
    if (_expandedColor == _collapsedColor) {
      return CustomAppBarBehavior.stretch;
    }
    return CustomAppBarBehavior.duplicate;
  }

  TypeStyle get _collapsedTitleTypeStyle =>
      _typescaleTheme.titleLargeEmphasized;

  TextStyle get _collapsedTitleTextStyle =>
      _collapsedTitleTypeStyle.toTextStyle(color: _colorTheme.onSurface);

  TypeStyle get _collapsedSubtitleTypeStyle => _typescaleTheme.labelMedium;

  TextStyle get _collapsedSubtitleTextStyle => _collapsedSubtitleTypeStyle
      .toTextStyle(color: _colorTheme.onSurfaceVariant);

  double get _collapsedTitleSubtitleSpace => 0.0;

  EdgeInsetsGeometry get _collapsedPadding =>
      widget.collapsedPadding?.clamp(
        EdgeInsets.zero,
        const EdgeInsets.symmetric(horizontal: double.infinity, vertical: 0.0),
      ) ??
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0);

  double get _collapsedContentHeight =>
      _collapsedTitleTypeStyle.lineHeight +
      (widget.subtitle != null
          ? _collapsedTitleSubtitleSpace +
                _collapsedSubtitleTypeStyle.lineHeight
          : 0.0);

  double get _collapsedHeight => _kCollapsedHeight;

  Color get _collapsedColor =>
      widget.collapsedContainerColor ?? _colorTheme.surfaceContainer;

  TypeStyle get _expandedTitleTypeStyle => switch (widget.type) {
    CustomAppBarType.small => _collapsedTitleTypeStyle,
    CustomAppBarType.mediumFlexible => _typescaleTheme.titleMediumEmphasized,
    CustomAppBarType.largeFlexible => _typescaleTheme.displaySmallEmphasized,
  };

  TextStyle get _expandedTitleTextStyle =>
      _expandedTitleTypeStyle.toTextStyle(color: _colorTheme.onSurface);

  TypeStyle get _expandedSubtitleTypeStyle => switch (widget.type) {
    CustomAppBarType.small => _collapsedSubtitleTypeStyle,
    CustomAppBarType.mediumFlexible => _typescaleTheme.labelLarge,
    CustomAppBarType.largeFlexible => _typescaleTheme.titleMedium,
  };

  TextStyle get _expandedSubtitleTextStyle => _expandedSubtitleTypeStyle
      .toTextStyle(color: _colorTheme.onSurfaceVariant);

  double get _expandedTitleSubtitleSpace => switch (widget.type) {
    CustomAppBarType.small => _collapsedTitleSubtitleSpace,
    CustomAppBarType.mediumFlexible => 4.0,
    CustomAppBarType.largeFlexible => 8.0,
  };

  EdgeInsetsGeometry get _expandedPadding =>
      widget.type == CustomAppBarType.small
      ? _collapsedPadding
      : widget.expandedPadding ??
            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, _kExpandedBottomPadding);

  double get _expandedContentHeight => widget.type == CustomAppBarType.small
      ? _collapsedContentHeight
      : _expandedTitleTypeStyle.lineHeight +
            (widget.subtitle != null
                ? _expandedTitleSubtitleSpace +
                      _expandedSubtitleTypeStyle.lineHeight
                : 0.0);

  double get _expandedHeight => widget.type == CustomAppBarType.small
      ? _collapsedHeight
      : _collapsedHeight + _expandedContentHeight + _expandedPadding.vertical;

  Color get _expandedColor =>
      widget.expandedContainerColor ?? _colorTheme.surface;

  final _ValueNotifier<double> _controller = _ValueNotifier(0.0);

  final Tween<Color?> _containerColorTween = ColorTween();

  // TODO: decide if such initialization should be inside initState or not
  late final Animatable<Color?> _containerColorAnimatable = _containerColorTween
      .chain(CurveTween(curve: _kFastOutLinearIn));

  void _scrollPositionListener() {
    final oldValue = _controller.value;
    final newValue = _calculateValue();
    if (oldValue != newValue) {
      // _controller.value = newValue;
      _controller.setValueWith(newValue, notify: true);
    }
  }

  double _calculateValue() {
    assert(_position != null);
    final position = _position!;
    assert(position.hasPixels);
    final pixels = position.pixels;
    final heightDifference = _expandedHeight - _collapsedHeight;
    return clampDouble(
      pixels / (heightDifference > 0.0 ? heightDifference : _collapsedHeight),
      0.0,
      1.0,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _colorTheme = ColorTheme.of(context);
    _typescaleTheme = TypescaleTheme.of(context);

    // Update scroll listener
    final scrollable = Scrollable.of(context, axis: Axis.vertical);
    final oldPosition = _position;
    final newPosition = scrollable.position;
    if (oldPosition != newPosition) {
      oldPosition?.removeListener(_scrollPositionListener);
      newPosition.addListener(_scrollPositionListener);
    }
    _position = newPosition;
    // _controller.value = _calculateValue();
    _controller.setValueWith(_calculateValue(), notify: false);
  }

  @override
  void dispose() {
    _position?.removeListener(_scrollPositionListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final topPadding = MediaQuery.paddingOf(context).top;
    final title = widget.title;
    final subtitle = widget.subtitle;
    _containerColorTween.begin = _expandedColor;
    _containerColorTween.end = _collapsedColor;

    Widget wrapWithScope({required Widget child}) {
      return _CustomAppBarScope(state: this, child: child);
    }

    final Widget stack = Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (title != null || subtitle != null)
            wrapWithScope(
              child: _expandedHeight > _collapsedHeight
                  ? switch (_behavior) {
                      CustomAppBarBehavior.duplicate =>
                        _CustomAppBarDuplicatingFlexibleSpace(
                          expandedTitle: title,
                          expandedSubtitle: subtitle,
                          collapsedTitle: title,
                          collapsedSubtitle: subtitle,
                        ),
                      CustomAppBarBehavior.stretch =>
                        _CustomAppBarStretchingFlexibleSpace(
                          title: title,
                          subtitle: subtitle,
                        ),
                    }
                  : _CustomAppBarAlwaysCollapsedFlexibleSpace(
                      title: title,
                      subtitle: subtitle,
                    ),
            ),
          // if (title != null || subtitle != null)
          //   wrapWithScope(
          //     child: _CustomAppBarDuplicatingFlexibleSpace(
          //       collapsedTitle: title,
          //       collapsedSubtitle: subtitle,

          //       expandedTitle: title,
          //       expandedSubtitle: subtitle,
          //     ),
          //   ),
          Positioned(
            left: 0.0,
            top: 0.0,
            right: 0.0,
            height: _collapsedHeight,
            child: Flex.horizontal(
              children: [
                ?widget.leading,
                const Flexible.space(),
                ?widget.trailing,
              ],
            ),
          ),
        ],
      ),
    );
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => SliverAppBar(
        pinned: true,
        automaticallyImplyLeading: false,
        collapsedHeight: _collapsedHeight,
        expandedHeight: _expandedHeight,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        leadingWidth: 0.0,
        leading: null,
        title: null,
        actions: const [],
        actionsPadding: EdgeInsets.zero,
        backgroundColor: _expandedColor == _collapsedColor
            ? _expandedColor
            : _containerColorAnimatable.transform(_controller.value)!,
        flexibleSpace: stack,
        bottom: widget.bottom,
      ),
    );
  }
}

class _CustomAppBarScope extends InheritedWidget {
  const _CustomAppBarScope({
    // ignore: unused_element_parameter
    super.key,
    required this.state,
    required super.child,
  });

  final _CustomAppBarState state;

  @override
  bool updateShouldNotify(_CustomAppBarScope oldWidget) {
    return state != oldWidget.state;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<_CustomAppBarState>("state", state));
  }

  static _CustomAppBarScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_CustomAppBarScope>();
  }

  static _CustomAppBarScope of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null);
    return result!;
  }
}

class _CustomAppBarAlwaysCollapsedFlexibleSpace extends StatefulWidget {
  const _CustomAppBarAlwaysCollapsedFlexibleSpace({
    super.key,
    this.title,
    this.subtitle,
  }) : assert(title != null || subtitle != null);

  final Widget? title;
  final Widget? subtitle;

  @override
  State<_CustomAppBarAlwaysCollapsedFlexibleSpace> createState() =>
      _CustomAppBarAlwaysCollapsedFlexibleSpaceState();
}

class _CustomAppBarAlwaysCollapsedFlexibleSpaceState
    extends State<_CustomAppBarAlwaysCollapsedFlexibleSpace> {
  late _CustomAppBarState _state;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _state = _CustomAppBarScope.of(context).state;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _state._collapsedHeight,
      child: Padding(
        padding: _state._collapsedPadding,
        child: Flex.vertical(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.title case final title?)
              DefaultTextStyle(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: _state._collapsedTitleTextStyle,
                child: title,
              ),
            if (widget.subtitle case final subtitle?) ...[
              SizedBox(
                width: double.infinity,
                height: _state._collapsedTitleSubtitleSpace,
              ),
              DefaultTextStyle(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: _state._collapsedSubtitleTextStyle,
                child: subtitle,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CustomAppBarDuplicatingFlexibleSpace extends StatefulWidget {
  const _CustomAppBarDuplicatingFlexibleSpace({
    super.key,
    // TODO: reorder _CustomAppBarDuplicatingHeader properties
    this.collapsedTitle,
    this.collapsedSubtitle,
    this.expandedTitle,
    this.expandedSubtitle,
  }) : assert(
         (expandedTitle != null || expandedSubtitle != null) ||
             (collapsedTitle != null || collapsedSubtitle != null),
       );

  final Widget? collapsedTitle;
  final Widget? collapsedSubtitle;

  final Widget? expandedTitle;
  final Widget? expandedSubtitle;

  @override
  State<_CustomAppBarDuplicatingFlexibleSpace> createState() =>
      _CustomAppBarDuplicatingFlexibleSpaceState();
}

class _CustomAppBarDuplicatingFlexibleSpaceState
    extends State<_CustomAppBarDuplicatingFlexibleSpace> {
  late _CustomAppBarState _state;

  final Animatable<double> _collapsedOpacityTween = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).chain(CurveTween(curve: const Cubic(0.8, 0.0, 0.8, 0.15)));

  final Animatable<double> _expandedOpacityTween = Tween<double>(
    begin: 1.0,
    end: 0.0,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _state = _CustomAppBarScope.of(context).state;
  }

  @override
  Widget build(BuildContext context) {
    final animation = _state._controller;

    final hangingHeight = _state._expandedHeight - _state._collapsedHeight;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final hideCollapsedSemantics = animation.value < 0.5;
        final hideExpandedSemantics = !hideCollapsedSemantics;
        return Flex.vertical(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ExcludeSemantics(
              excluding: hideCollapsedSemantics,
              child: SizedBox(
                height: _state._collapsedHeight,
                child: Padding(
                  padding: _state._collapsedPadding,
                  child: Opacity(
                    opacity: _collapsedOpacityTween.transform(animation.value),
                    child: Flex.vertical(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (widget.collapsedTitle case final collapsedTitle?)
                          DefaultTextStyle(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: _state._collapsedTitleTextStyle,
                            child: collapsedTitle,
                          ),
                        if (widget.collapsedSubtitle
                            case final collapsedSubtitle?) ...[
                          SizedBox(
                            width: double.infinity,
                            height: _state._collapsedTitleSubtitleSpace,
                          ),
                          DefaultTextStyle(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: _state._collapsedSubtitleTextStyle,
                            child: collapsedSubtitle,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ExcludeSemantics(
              excluding: hideExpandedSemantics,
              child: ClipRect(
                child: SizedBox(
                  height: lerpDouble(hangingHeight, 0.0, animation.value),
                  child: OverflowBox(
                    minHeight: 0.0,
                    maxHeight: hangingHeight,
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: _state._expandedPadding,
                      child: Opacity(
                        opacity: _expandedOpacityTween.transform(
                          animation.value,
                        ),
                        child: Flex.vertical(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (widget.expandedTitle case final expandedTitle?)
                              DefaultTextStyle(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: _state._expandedTitleTextStyle,
                                child: expandedTitle,
                              ),
                            if (widget.expandedSubtitle
                                case final expandedSubtitle?) ...[
                              SizedBox(
                                width: double.infinity,
                                height: _state._expandedTitleSubtitleSpace,
                              ),
                              DefaultTextStyle(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: _state._expandedSubtitleTextStyle,
                                child: expandedSubtitle,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CustomAppBarStretchingFlexibleSpace extends StatefulWidget {
  const _CustomAppBarStretchingFlexibleSpace({
    super.key,
    this.title,
    this.subtitle,
  }) : assert(title != null || subtitle != null);

  final Widget? title;
  final Widget? subtitle;

  @override
  State<_CustomAppBarStretchingFlexibleSpace> createState() =>
      _CustomAppBarStretchingFlexibleSpaceState();
}

class _CustomAppBarStretchingFlexibleSpaceState
    extends State<_CustomAppBarStretchingFlexibleSpace> {
  late _CustomAppBarState _state;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _state = _CustomAppBarScope.of(context).state;
  }

  @override
  Widget build(BuildContext context) {
    final animation = _state._controller;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => Align(
        alignment: Alignment.lerp(
          _state._collapsedHeight == _state._expandedHeight
              ? Alignment.center
              : Alignment.bottomCenter,
          Alignment.center,
          animation.value,
        )!,
        child: Padding(
          padding: EdgeInsetsGeometry.lerp(
            _state._expandedPadding,
            _state._collapsedPadding.clamp(
              EdgeInsets.zero,
              const EdgeInsets.symmetric(
                horizontal: double.infinity,
                vertical: 0.0,
              ),
            ),
            animation.value,
          )!,
          child: Flex.vertical(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.title case final title?)
                DefaultTextStyle(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle.lerp(
                    _state._expandedTitleTextStyle,
                    _state._collapsedTitleTextStyle,
                    animation.value,
                  )!,
                  child: title,
                ),
              if (widget.subtitle case final subtitle?) ...[
                SizedBox(
                  width: double.infinity,
                  height: lerpDouble(
                    _state._expandedTitleSubtitleSpace,
                    _state._collapsedTitleSubtitleSpace,
                    animation.value,
                  )!,
                ),
                DefaultTextStyle(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle.lerp(
                    _state._expandedSubtitleTextStyle,
                    _state._collapsedSubtitleTextStyle,
                    animation.value,
                  )!,
                  child: subtitle,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// TODO: remove this unless OWN setState() gets called in listener
class _ValueNotifier<T extends Object?> extends ChangeNotifier
    implements ValueListenable<T> {
  _ValueNotifier(T value) : _value = value {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  T _value;

  @override
  T get value => _value;

  set value(T value) => setValueWith(value, notify: true);

  void setValueWith(T value, {required bool notify}) {
    if (_value == value) return;
    _value = value;
    if (notify) notifyListeners();
  }

  @override
  String toString() => "${describeIdentity(this)}($value)";
}
