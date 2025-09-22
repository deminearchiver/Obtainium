import 'dart:ui';

import 'package:obtainium/flutter.dart';

const double _kCollapsedHeight = 64.0;
const double _kExpandedBottomPadding = 12.0;

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    super.key,
    this.collapsedContainerColor,
    this.expandedContainerColor,
    required this.title,
  });

  final Color? collapsedContainerColor;
  final Color? expandedContainerColor;

  final Widget title;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>
    with SingleTickerProviderStateMixin {
  late ColorThemeData _colorTheme;
  late TypescaleThemeData _typescaleTheme;
  ScrollPosition? _position;

  // Collapsed
  late TypeStyle _collapsedTypeStyle;
  late TextStyle _collapsedTextStyle;
  late EdgeInsetsGeometry _collapsedPadding;
  late Color _collapsedColor;

  // Expanded
  late TypeStyle _expandedTypeStyle;
  late TextStyle _expandedTextStyle;
  late EdgeInsetsGeometry _expandedPadding;
  late double _expandedHeight;
  late Color _expandedColor;

  late AnimationController _controller;

  void _scrollPositionListener() {
    assert(_position != null);
    final position = _position!;
    if (!position.hasPixels) return;
    final pixels = position.pixels;
    // Pixels: 0.0 -> 56.0
    // Height: 120.0 -> 64.0
    // Value: 0.0 -> 1.0
    // Height: (expanded) -> (expanded - pixels)
    final heightChange = _expandedHeight - _kCollapsedHeight;
    final oldValue = _controller.value;
    final newValue = clampDouble(pixels / heightChange, 0.0, 1.0);
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

    _collapsedTypeStyle = _typescaleTheme.titleLargeEmphasized;
    _collapsedTextStyle = _collapsedTypeStyle.toTextStyle(
      color: _colorTheme.onSurface,
    );
    _expandedTypeStyle = _typescaleTheme.displaySmallEmphasized;
    _expandedTextStyle = _expandedTypeStyle.toTextStyle(
      color: _colorTheme.onSurface,
    );

    _collapsedColor =
        widget.collapsedContainerColor ?? _colorTheme.surfaceContainer;
    _expandedColor = widget.expandedContainerColor ?? _colorTheme.surface;

    final collapsedVerticalPadding =
        (_kCollapsedHeight - _expandedTypeStyle.lineHeight) / 2.0;
    _collapsedPadding = EdgeInsets.fromLTRB(
      16.0,
      collapsedVerticalPadding,
      16.0,
      collapsedVerticalPadding,
    );
    _expandedPadding = EdgeInsets.fromLTRB(
      16.0,
      0.0,
      16.0,
      _kExpandedBottomPadding,
    );
    _expandedHeight =
        _kCollapsedHeight +
        _expandedTypeStyle.lineHeight +
        _kExpandedBottomPadding;

    assert(_expandedHeight > _kCollapsedHeight);

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
            _collapsedPadding,
            _expandedPadding,
            _controller.value,
          )!,
          title: DefaultTextStyle(
            style: TextStyle.lerp(
              _expandedTextStyle,
              _collapsedTextStyle,
              _controller.value,
            )!,
            child: widget.title,
          ),
        ),
      ),
    );
  }
}
