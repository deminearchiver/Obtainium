import 'dart:ui';

import 'package:obtainium/flutter.dart';

const double _kCollapsedHeight = 64.0;
const double _kExpandedBottomPadding = 12.0;

enum _AppBarType { small, mediumFlexible, largeFlexible }

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    super.key,
    this.collapsedContainerColor,
    this.expandedContainerColor,
    required this.headline,
    this.subtitle = const Text("Subtitle"),
  }) : _type = _AppBarType.largeFlexible;

  final _AppBarType _type;

  final Color? collapsedContainerColor;
  final Color? expandedContainerColor;

  final Widget headline;
  final Widget? subtitle;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>
    with SingleTickerProviderStateMixin {
  late ColorThemeData _colorTheme;
  late TypescaleThemeData _typescaleTheme;
  ScrollPosition? _position;

  // Collapsed
  TypeStyle get _collapsedHeadlineTypeStyle =>
      _typescaleTheme.titleLargeEmphasized;
  late TextStyle _collapsedHeadlineTextStyle;
  TypeStyle get _collapsedSubtitleTypeStyle => _typescaleTheme.labelMedium;
  late TextStyle _collapsedSubtitleTextStyle;
  double get _collapsedHeadlineSubtitleSpace => 0.0;
  late EdgeInsetsGeometry _collapsedPadding;
  late double _collapsedContentHeight;
  late Color _collapsedColor;

  // Expanded
  TypeStyle get _expandedHeadlineTypeStyle => switch (widget._type) {
    _AppBarType.small => _collapsedHeadlineTypeStyle,
    _AppBarType.mediumFlexible => _typescaleTheme.headlineMediumEmphasized,
    _AppBarType.largeFlexible => _typescaleTheme.displaySmallEmphasized,
  };
  late TextStyle _expandedHeadlineTextStyle;

  TypeStyle get _expandedSubtitleTypeStyle => switch (widget._type) {
    _AppBarType.small => _collapsedSubtitleTypeStyle,
    _AppBarType.mediumFlexible => _typescaleTheme.labelLarge,
    _AppBarType.largeFlexible => _typescaleTheme.titleMedium,
  };
  late TextStyle _expandedSubtitleTextStyle;
  double get _expandedHeadlineSubtitleSpace => switch (widget._type) {
    _AppBarType.small => _collapsedHeadlineSubtitleSpace,
    _AppBarType.mediumFlexible => 4.0,
    _AppBarType.largeFlexible => 8.0,
  };
  late EdgeInsetsGeometry _expandedPadding;
  late double _expandedContentHeight;
  late double _expandedHeight;
  late Color _expandedColor;

  late AnimationController _controller;

  void _scrollPositionListener() {
    assert(_position != null);
    final position = _position!;
    if (!position.hasPixels) return;
    final pixels = position.pixels;
    final heightChange = _expandedHeight - _kCollapsedHeight;
    final oldValue = _controller.value;
    final newValue = clampDouble(
      pixels / (heightChange > 0 ? heightChange : _kCollapsedHeight),
      0.0,
      1.0,
    );
    if (oldValue != newValue) {
      _controller.value = newValue;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, value: 0.0);
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

    final headlineColor = _colorTheme.onSurface;
    final subtitleColor = _colorTheme.onSurfaceVariant;

    _collapsedHeadlineTextStyle = _collapsedHeadlineTypeStyle.toTextStyle(
      color: headlineColor,
    );
    _expandedHeadlineTextStyle = _expandedHeadlineTypeStyle.toTextStyle(
      color: headlineColor,
    );

    _collapsedSubtitleTextStyle = _collapsedSubtitleTypeStyle.toTextStyle(
      color: subtitleColor,
    );
    _expandedSubtitleTextStyle = _expandedSubtitleTypeStyle.toTextStyle(
      color: subtitleColor,
    );

    _collapsedColor =
        widget.collapsedContainerColor ?? _colorTheme.surfaceContainer;
    _expandedColor = widget.expandedContainerColor ?? _colorTheme.surface;

    _collapsedContentHeight =
        _collapsedHeadlineTypeStyle.lineHeight +
        (widget.subtitle != null
            ? _collapsedHeadlineSubtitleSpace +
                  _collapsedSubtitleTypeStyle.lineHeight
            : 0.0);
    _expandedContentHeight = widget._type == _AppBarType.small
        ? _collapsedContentHeight
        : _expandedHeadlineTypeStyle.lineHeight +
              (widget.subtitle != null
                  ? _expandedHeadlineSubtitleSpace +
                        _expandedSubtitleTypeStyle.lineHeight
                  : 0.0);

    _collapsedPadding = EdgeInsets.fromLTRB(
      16.0,
      (_kCollapsedHeight - _collapsedContentHeight) / 2.0,
      16.0,
      (_kCollapsedHeight - _collapsedContentHeight) / 2.0,
    );
    _expandedPadding = widget._type == _AppBarType.small
        ? _collapsedPadding
        : EdgeInsets.fromLTRB(16.0, 0.0, 16.0, _kExpandedBottomPadding);
    _expandedHeight = widget._type == _AppBarType.small
        ? _kCollapsedHeight
        : _kCollapsedHeight + _expandedContentHeight + _kExpandedBottomPadding;

    assert(_expandedHeight >= _kCollapsedHeight);
    debugPrint("$_kCollapsedHeight $_expandedHeight");

    // Update scroll listener
    final scrollable = Scrollable.of(context, axis: Axis.vertical);
    final oldPosition = _position;
    final newPosition = scrollable.position;
    if (oldPosition != newPosition) {
      oldPosition?.removeListener(_scrollPositionListener);
      newPosition.addListener(_scrollPositionListener);
    }
    _position = newPosition;
  }

  @override
  void dispose() {
    _position?.removeListener(_scrollPositionListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => SliverAppBar(
        pinned: true,
        automaticallyImplyLeading: false,
        collapsedHeight: _kCollapsedHeight,
        expandedHeight: _expandedHeight,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: Color.lerp(
          _expandedColor,
          _collapsedColor,
          _controller.value,
        )!,
        flexibleSpace: FlexibleSpaceBar(
          expandedTitleScale: 1.0,
          titlePadding: EdgeInsetsGeometry.lerp(
            _expandedPadding,
            _collapsedPadding,
            _controller.value,
          )!,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DefaultTextStyle(
                style: TextStyle.lerp(
                  _expandedHeadlineTextStyle,
                  _collapsedHeadlineTextStyle,
                  _controller.value,
                )!,
                child: widget.headline,
              ),
              if (widget.subtitle case final subtitle?) ...[
                SizedBox(
                  width: double.infinity,
                  height: lerpDouble(
                    _expandedHeadlineSubtitleSpace,
                    _collapsedHeadlineSubtitleSpace,
                    _controller.value,
                  )!,
                ),
                DefaultTextStyle(
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
    );
  }
}
