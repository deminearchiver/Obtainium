import 'package:easy_localization/easy_localization.dart';
import 'package:obtainium/flutter.dart';
import 'package:obtainium/components/generated_form.dart';

class GeneratedFormModal extends StatefulWidget {
  const GeneratedFormModal({
    super.key,
    required this.title,
    required this.items,
    this.initValid = false,
    this.message = '',
    this.additionalWidgets = const [],
    this.singleNullReturnButton,
    this.primaryActionColour,
  });

  final String title;
  final String message;
  final List<List<GeneratedFormItem>> items;
  final bool initValid;
  final List<Widget> additionalWidgets;
  final String? singleNullReturnButton;
  final Color? primaryActionColour;

  @override
  State<GeneratedFormModal> createState() => _GeneratedFormModalState();
}

class _GeneratedFormModalState extends State<GeneratedFormModal> {
  Map<String, dynamic> values = {};
  bool valid = false;

  @override
  void initState() {
    super.initState();
    valid = widget.initValid || widget.items.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(
        widget.title,
        style: TypescaleTheme.of(context).headlineSmallEmphasized.toTextStyle(
          color: ColorTheme.of(context).onSurface,
        ),
      ),
      content: Flex.vertical(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.message.isNotEmpty) Text(widget.message),
          if (widget.message.isNotEmpty) const SizedBox(height: 16),
          GeneratedForm(
            items: widget.items,
            onValueChanges: (values, valid, isBuilding) {
              if (isBuilding) {
                this.values = values;
                this.valid = valid;
              } else {
                setState(() {
                  this.values = values;
                  this.valid = valid;
                });
              }
            },
          ),
          if (widget.additionalWidgets.isNotEmpty) ...widget.additionalWidgets,
        ],
      ),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 24.0 - 4.0,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          style: ButtonStyle(
            animationDuration: Duration.zero,
            elevation: const WidgetStatePropertyAll(0.0),
            shadowColor: WidgetStateColor.transparent,
            minimumSize: const WidgetStatePropertyAll(Size(48.0, 40.0)),
            fixedSize: const WidgetStatePropertyAll(null),
            maximumSize: const WidgetStatePropertyAll(Size.infinite),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            ),
            iconSize: const WidgetStatePropertyAll(20.0),
            shape: WidgetStatePropertyAll(
              CornersBorder.rounded(
                corners: Corners.all(ShapeTheme.of(context).corner.full),
              ),
            ),
            overlayColor: WidgetStateLayerColor(
              color: WidgetStatePropertyAll(ColorTheme.of(context).primary),
              opacity: StateTheme.of(context).stateLayerOpacity,
            ),
            backgroundColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.disabled)
                  ? ColorTheme.of(context).onSurface.withValues(alpha: 0.1)
                  : Colors.transparent,
            ),
            foregroundColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.disabled)
                  ? ColorTheme.of(context).onSurface.withValues(alpha: 0.38)
                  : ColorTheme.of(context).primary,
            ),
            textStyle: WidgetStateProperty.resolveWith(
              (states) => TypescaleTheme.of(context).labelLarge.toTextStyle(),
            ),
          ),
          child: Text(
            widget.singleNullReturnButton == null
                ? tr('cancel')
                : widget.singleNullReturnButton!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (widget.singleNullReturnButton == null)
          TextButton(
            onPressed: !valid
                ? null
                : () {
                    if (valid) {
                      HapticFeedback.selectionClick();
                      Navigator.of(context).pop(values);
                    }
                  },
            // TODO: find usages of primaryActionColour
            // style: widget.primaryActionColour == null
            //     ? null
            //     : TextButton.styleFrom(
            //         foregroundColor: widget.primaryActionColour,
            //       ),
            style: ButtonStyle(
              animationDuration: Duration.zero,
              elevation: const WidgetStatePropertyAll(0.0),
              shadowColor: WidgetStateColor.transparent,
              minimumSize: const WidgetStatePropertyAll(Size(48.0, 40.0)),
              fixedSize: const WidgetStatePropertyAll(null),
              maximumSize: const WidgetStatePropertyAll(Size.infinite),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              ),
              iconSize: const WidgetStatePropertyAll(20.0),
              shape: WidgetStatePropertyAll(
                CornersBorder.rounded(
                  corners: Corners.all(ShapeTheme.of(context).corner.full),
                ),
              ),
              overlayColor: WidgetStateLayerColor(
                color: WidgetStatePropertyAll(ColorTheme.of(context).primary),
                opacity: StateTheme.of(context).stateLayerOpacity,
              ),
              backgroundColor: WidgetStateProperty.resolveWith(
                (states) => states.contains(WidgetState.disabled)
                    ? ColorTheme.of(context).onSurface.withValues(alpha: 0.1)
                    : Colors.transparent,
              ),
              foregroundColor: WidgetStateProperty.resolveWith(
                (states) => states.contains(WidgetState.disabled)
                    ? ColorTheme.of(context).onSurface.withValues(alpha: 0.38)
                    : ColorTheme.of(context).primary,
              ),
              textStyle: WidgetStateProperty.resolveWith(
                (states) => TypescaleTheme.of(context).labelLarge.toTextStyle(),
              ),
            ),
            child: Text(
              tr('continue'),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }
}
