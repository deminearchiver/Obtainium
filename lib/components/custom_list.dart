import 'package:obtainium/flutter.dart';

enum ListItemControlAffinity { leading, trailing }

class ListItemInteraction extends StatelessWidget {
  const ListItemInteraction({
    super.key,
    // State
    this.statesController,
    this.stateLayerColor,
    this.stateLayerOpacity,
    // Focus
    this.focusNode,
    this.canRequestFocus = true,
    this.onFocusChange,
    this.autofocus = false,
    // Gesture handlers
    this.onTap,
    this.onLongPress,
    // Child
    required this.child,
  });

  final WidgetStatesController? statesController;
  final WidgetStateProperty<Color>? stateLayerColor;
  final WidgetStateProperty<double>? stateLayerOpacity;

  final FocusNode? focusNode;
  final bool canRequestFocus;
  final ValueChanged<bool>? onFocusChange;
  final bool autofocus;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorTheme = ColorTheme.of(context);
    final stateTheme = StateTheme.of(context);
    return InkWell(
      statesController: statesController,
      focusNode: focusNode,
      canRequestFocus: canRequestFocus,
      onFocusChange: onFocusChange,
      autofocus: autofocus,
      onTap: onTap,
      onLongPress: onLongPress,
      overlayColor: WidgetStateLayerColor(
        color: stateLayerColor ?? WidgetStatePropertyAll(colorTheme.onSurface),
        opacity: stateLayerOpacity ?? stateTheme.stateLayerOpacity,
      ),
      child: child,
    );
  }
}

class ListItemLayout extends StatefulWidget {
  const ListItemLayout({
    super.key,
    this.isMultiline,
    this.minHeight,
    this.maxHeight,
    this.padding,
    this.leadingSpace,
    this.trailingSpace,
    this.leading,
    this.headline,
    this.supportingText,
    this.trailing,
  }) : assert(headline != null || supportingText != null);

  final bool? isMultiline;
  final double? minHeight;
  final double? maxHeight;
  final EdgeInsetsGeometry? padding;
  final double? leadingSpace;
  final double? trailingSpace;

  final Widget? leading;
  final Widget? headline;
  final Widget? supportingText;
  final Widget? trailing;

  @override
  State<ListItemLayout> createState() => _ListItemLayoutState();
}

class _ListItemLayoutState extends State<ListItemLayout> {
  @override
  Widget build(BuildContext context) {
    final colorTheme = ColorTheme.of(context);
    final typescaleTheme = TypescaleTheme.of(context);

    final isMultiline =
        widget.isMultiline ??
        (widget.headline != null && widget.supportingText != null);

    final minHeight = widget.minHeight ?? (isMultiline ? 72.0 : 56.0);

    final maxHeight = widget.maxHeight ?? double.infinity;

    final constraints = BoxConstraints(
      minHeight: minHeight,
      maxHeight: maxHeight,
    );

    final EdgeInsetsGeometry containerPadding =
        widget.padding?.clamp(
          EdgeInsets.zero,
          const EdgeInsets.symmetric(
            horizontal: double.infinity,
            vertical: 0.0,
          ),
        ) ??
        const EdgeInsets.symmetric(horizontal: 16.0);

    final EdgeInsetsGeometry verticalContentPadding =
        widget.padding?.clamp(
          EdgeInsets.zero,
          const EdgeInsets.symmetric(
            horizontal: 0.0,
            vertical: double.infinity,
          ),
        ) ??
        (isMultiline
            ? const EdgeInsets.symmetric(vertical: 12.0)
            : const EdgeInsets.symmetric(vertical: 8.0));

    final EdgeInsetsGeometry horizontalContentPadding =
        EdgeInsetsDirectional.only(
          start: widget.leading != null ? widget.leadingSpace ?? 12.0 : 0.0,
          end: widget.trailing != null ? widget.trailingSpace ?? 12.0 : 0.0,
        );

    final EdgeInsetsGeometry contentPadding = verticalContentPadding.add(
      horizontalContentPadding,
    );

    return ConstrainedBox(
      constraints: constraints,
      child: Padding(
        padding: containerPadding,
        child: Flex.horizontal(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.leading case final leading?)
              IconTheme.merge(
                data: IconThemeDataPartial.from(
                  color: colorTheme.onSurfaceVariant,
                  size: 24.0,
                  opticalSize: 24.0,
                ),
                child: leading,
              ),

            Flexible.tight(
              child: Padding(
                padding: contentPadding,
                child: Flex.vertical(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.headline case final headline?)
                      DefaultTextStyle(
                        style: typescaleTheme.titleMediumEmphasized.toTextStyle(
                          color: colorTheme.onSurface,
                        ),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        child: headline,
                      ),
                    if (widget.supportingText case final supportingText?)
                      DefaultTextStyle(
                        style: typescaleTheme.bodyMedium.toTextStyle(
                          color: colorTheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        child: supportingText,
                      ),
                  ],
                ),
              ),
            ),
            if (widget.trailing case final trailing?)
              DefaultTextStyle(
                style: typescaleTheme.labelSmall.toTextStyle(
                  color: colorTheme.onSurfaceVariant,
                ),
                overflow: TextOverflow.ellipsis,
                child: IconTheme.merge(
                  data: IconThemeDataPartial.from(
                    color: colorTheme.onSurfaceVariant,
                    size: 24.0,
                    opticalSize: 24.0,
                  ),
                  child: trailing,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
