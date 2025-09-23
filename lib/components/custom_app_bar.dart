import 'dart:ui';

import 'package:obtainium/flutter.dart';

const double _kCollapsedHeight = 64.0;
const double _kExpandedBottomPadding = 12.0;

enum _AppBarType { small, mediumFlexible, largeFlexible }

class CustomAppBar extends StatefulWidget {
  const CustomAppBar.small({
    super.key,
    this.collapsedPadding,
    this.expandedPadding,
    this.collapsedContainerColor,
    this.expandedContainerColor,
    this.collapsedHeadlineTextStyle,
    this.expandedHeadlineTextStyle,
    this.collapsedSubtitleTextStyle,
    this.expandedSubtitleTextStyle,
    this.leading,
    required this.headline,
    this.subtitle,
    this.trailing,
  }) : _type = _AppBarType.small;

  const CustomAppBar.mediumFlexible({
    super.key,
    this.collapsedPadding,
    this.expandedPadding,
    this.collapsedContainerColor,
    this.expandedContainerColor,
    this.collapsedHeadlineTextStyle,
    this.expandedHeadlineTextStyle,
    this.collapsedSubtitleTextStyle,
    this.expandedSubtitleTextStyle,
    this.leading,
    required this.headline,
    this.subtitle,
    this.trailing,
  }) : _type = _AppBarType.mediumFlexible;

  const CustomAppBar.largeFlexible({
    super.key,
    this.collapsedPadding,
    this.expandedPadding,
    this.collapsedContainerColor,
    this.expandedContainerColor,
    this.collapsedHeadlineTextStyle,
    this.expandedHeadlineTextStyle,
    this.collapsedSubtitleTextStyle,
    this.expandedSubtitleTextStyle,
    this.leading,
    required this.headline,
    this.subtitle,
    this.trailing,
  }) : _type = _AppBarType.largeFlexible;

  final _AppBarType _type;

  final EdgeInsetsGeometry? collapsedPadding;
  final EdgeInsetsGeometry? expandedPadding;

  final Color? collapsedContainerColor;
  final Color? expandedContainerColor;

  final TextStyle? collapsedHeadlineTextStyle;
  final TextStyle? expandedHeadlineTextStyle;

  final TextStyle? collapsedSubtitleTextStyle;
  final TextStyle? expandedSubtitleTextStyle;

  final Widget? leading;
  final Widget headline;
  final Widget? subtitle;
  final Widget? trailing;

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
  TextStyle get _collapsedHeadlineTextStyle =>
      _collapsedHeadlineTypeStyle.toTextStyle(color: _colorTheme.onSurface);
  TypeStyle get _collapsedSubtitleTypeStyle => _typescaleTheme.labelMedium;
  TextStyle get _collapsedSubtitleTextStyle => _collapsedSubtitleTypeStyle
      .toTextStyle(color: _colorTheme.onSurfaceVariant);
  double get _collapsedHeadlineSubtitleSpace => 0.0;

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
      _collapsedHeadlineTypeStyle.lineHeight +
      (widget.subtitle != null
          ? _collapsedHeadlineSubtitleSpace +
                _collapsedSubtitleTypeStyle.lineHeight
          : 0.0);
  double get _collapsedHeight => _kCollapsedHeight;
  Color get _collapsedColor =>
      widget.collapsedContainerColor ?? _colorTheme.surfaceContainer;

  // Expanded
  TypeStyle get _expandedHeadlineTypeStyle => switch (widget._type) {
    _AppBarType.small => _collapsedHeadlineTypeStyle,
    _AppBarType.mediumFlexible => _typescaleTheme.headlineMediumEmphasized,
    _AppBarType.largeFlexible => _typescaleTheme.displaySmallEmphasized,
  };
  TextStyle get _expandedHeadlineTextStyle =>
      _expandedHeadlineTypeStyle.toTextStyle(color: _colorTheme.onSurface);

  TypeStyle get _expandedSubtitleTypeStyle => switch (widget._type) {
    _AppBarType.small => _collapsedSubtitleTypeStyle,
    _AppBarType.mediumFlexible => _typescaleTheme.labelLarge,
    _AppBarType.largeFlexible => _typescaleTheme.titleMedium,
  };
  TextStyle get _expandedSubtitleTextStyle => _expandedSubtitleTypeStyle
      .toTextStyle(color: _colorTheme.onSurfaceVariant);
  double get _expandedHeadlineSubtitleSpace => switch (widget._type) {
    _AppBarType.small => _collapsedHeadlineSubtitleSpace,
    _AppBarType.mediumFlexible => 4.0,
    _AppBarType.largeFlexible => 8.0,
  };
  EdgeInsetsGeometry get _expandedPadding => widget._type == _AppBarType.small
      ? _collapsedPadding
      : widget.expandedPadding ??
            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, _kExpandedBottomPadding);
  double get _expandedContentHeight => widget._type == _AppBarType.small
      ? _collapsedContentHeight
      : _expandedHeadlineTypeStyle.lineHeight +
            (widget.subtitle != null
                ? _expandedHeadlineSubtitleSpace +
                      _expandedSubtitleTypeStyle.lineHeight
                : 0.0);
  double get _expandedHeight => widget._type == _AppBarType.small
      ? _collapsedHeight
      : _collapsedHeight + _expandedContentHeight + _expandedPadding.vertical;
  Color get _expandedColor =>
      widget.expandedContainerColor ?? _colorTheme.surface;

  late AnimationController _controller;

  void _scrollPositionListener() {
    assert(_position != null);
    final position = _position!;
    if (!position.hasPixels) return;
    final pixels = position.pixels;
    final heightChange = _expandedHeight - _collapsedHeight;
    final oldValue = _controller.value;
    final newValue = clampDouble(
      pixels / (heightChange > 0 ? heightChange : _collapsedHeight),
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
    assert(debugCheckHasMediaQuery(context));
    final topPadding = MediaQuery.paddingOf(context).top;
    final flexibleSpace = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsetsGeometry.lerp(
              _expandedPadding,
              _collapsedPadding,
              _controller.value,
            )!,
            child: Flex.vertical(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DefaultTextStyle(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
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
    );
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => SliverAppBar(
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
        flexibleSpace: Stack(
          children: [
            flexibleSpace,
            Positioned(
              left: 0.0,
              top: topPadding,
              right: 0.0,
              height: _collapsedHeight,
              child: Flex.horizontal(
                children: [?widget.leading, const Spacer(), ?widget.trailing],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
