import 'dart:ui';

import 'package:obtainium/flutter.dart';

const double _kCollapsedHeight = 64.0;
const double _kExpandedBottomPadding = 12.0;

enum CustomAppBarType { small, mediumFlexible, largeFlexible }

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    super.key,
    required this.type,
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

class _CustomAppBarState extends State<CustomAppBar>
    with SingleTickerProviderStateMixin {
  late ColorThemeData _colorTheme;
  late TypescaleThemeData _typescaleTheme;
  ScrollPosition? _position;

  // Collapsed
  TypeStyle get _collapsedTitleTypeStyle =>
      _typescaleTheme.titleLargeEmphasized;
  TextStyle get _collapsedTitleTextStyle =>
      _collapsedTitleTypeStyle.toTextStyle(color: _colorTheme.onSurface);
  TypeStyle get _collapsedSubtitleTypeStyle => _typescaleTheme.labelMedium;
  TextStyle get _collapsedSubtitleTextStyle => _collapsedSubtitleTypeStyle
      .toTextStyle(color: _colorTheme.onSurfaceVariant);
  double get _collapsedTitleSubtitleSpace => 0.0;

  EdgeInsetsGeometry get _collapsedPadding {
    final collapsedPadding = widget.collapsedPadding;
    final topBottomPadding = (_collapsedHeight - _collapsedContentHeight) / 2.0;
    if (collapsedPadding != null) {
      return collapsedPadding
          .clamp(
            EdgeInsets.zero,
            const EdgeInsets.symmetric(
              horizontal: double.infinity,
              vertical: 0.0,
            ),
          )
          .add(
            EdgeInsets.symmetric(horizontal: 0.0, vertical: topBottomPadding),
          );
    } else {
      return EdgeInsets.symmetric(horizontal: 16.0, vertical: topBottomPadding);
    }
  }

  double get _collapsedContentHeight =>
      _collapsedTitleTypeStyle.lineHeight +
      (widget.subtitle != null
          ? _collapsedTitleSubtitleSpace +
                _collapsedSubtitleTypeStyle.lineHeight
          : 0.0);
  double get _collapsedHeight => _kCollapsedHeight;
  Color get _collapsedColor =>
      widget.collapsedContainerColor ?? _colorTheme.surfaceContainer;

  // Expanded
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
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
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

    Widget _buildScope(Widget child) {
      return _CustomAppBarScope(state: this, child: child);
    }

    final Widget stack = Stack(
      fit: StackFit.expand,
      children: [
        if (title != null || subtitle != null)
          Padding(
            padding: EdgeInsets.only(top: topPadding),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => Align(
                alignment: Alignment.lerp(
                  Alignment.bottomCenter,
                  Alignment.center,
                  _controller.value,
                )!,
                child: Padding(
                  padding: EdgeInsetsGeometry.lerp(
                    _expandedPadding,
                    _collapsedPadding.clamp(
                      EdgeInsets.zero,
                      const EdgeInsets.symmetric(
                        horizontal: double.infinity,
                        vertical: 0.0,
                      ),
                    ),
                    _controller.value,
                  )!,
                  child: Flex.vertical(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (title != null)
                        DefaultTextStyle(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle.lerp(
                            _expandedTitleTextStyle,
                            _collapsedTitleTextStyle,
                            _controller.value,
                          )!,
                          child: title,
                        ),
                      if (subtitle != null) ...[
                        SizedBox(
                          width: double.infinity,
                          height: lerpDouble(
                            _expandedTitleSubtitleSpace,
                            _collapsedTitleSubtitleSpace,
                            _controller.value,
                          )!,
                        ),
                        DefaultTextStyle(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle.lerp(
                            _expandedSubtitleTextStyle,
                            _collapsedSubtitleTextStyle,
                            _controller.value,
                          )!,
                          child: subtitle,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          left: 0.0,
          top: topPadding,
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
        backgroundColor: Color.lerp(
          _expandedColor,
          _collapsedColor,
          _controller.value,
        )!,
        flexibleSpace: stack,
        bottom: widget.bottom,
      ),
    );
  }
}

class _CustomAppBarScope extends InheritedWidget {
  const _CustomAppBarScope({
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
