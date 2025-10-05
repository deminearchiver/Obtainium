library;

// SDK packages

export 'package:flutter/foundation.dart';

export 'package:flutter/services.dart';

export 'package:flutter/physics.dart';

export 'package:flutter/rendering.dart'
    hide
        RenderPadding,
        FlexParentData,
        RenderFlex,
        FloatingHeaderSnapConfiguration,
        PersistentHeaderShowOnScreenConfiguration,
        OverScrollHeaderStretchConfiguration;

export 'package:flutter/material.dart'
    hide
        // package:layout
        // ---
        Padding,
        Align,
        Center,
        Flex,
        Row,
        Column,
        Flexible,
        Expanded,
        Spacer,
        // ---
        // package:material
        // ---
        WidgetStateProperty,
        WidgetStatesConstraint,
        WidgetStateMap,
        WidgetStateMapper,
        WidgetStatePropertyAll,
        WidgetStatesController,
        // ---
        Icon,
        IconTheme,
        IconThemeData,
        // ---
        // Force migration to Material Symbols
        Icons,
        AnimatedIcons,
        // ---
        CircularProgressIndicator,
        LinearProgressIndicator,
        ProgressIndicator,
        // ---
        Checkbox,
        CheckboxTheme,
        CheckboxThemeData,
        // ---
        Switch,
        SwitchTheme,
        SwitchThemeData;

// Third-party packages

export 'package:meta/meta.dart';
export 'package:material_symbols_icons/material_symbols_icons.dart';

// Internal packages

export 'package:layout/layout.dart';
export 'package:material/material.dart';

import 'package:material/src/flutter.dart';

extension PaintingContextExtension on PaintingContext {
  void withCanvasTransform(void Function() paint) {
    late int debugPreviousCanvasSaveCount;
    canvas.save();
    assert(() {
      debugPreviousCanvasSaveCount = canvas.getSaveCount();
      return true;
    }());

    paint();

    assert(() {
      // This isn't perfect. For example, we can't catch the case of
      // someone first restoring, then setting a transform or whatnot,
      // then saving.
      // If this becomes a real problem, we could add logic to the
      // Canvas class to lock the canvas at a particular save count
      // such that restore() fails if it would take the lock count
      // below that number.
      final int debugNewCanvasSaveCount = canvas.getSaveCount();
      if (debugNewCanvasSaveCount > debugPreviousCanvasSaveCount) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
            "The caller invoked canvas.save() or canvas.saveLayer() at least "
            "${debugNewCanvasSaveCount - debugPreviousCanvasSaveCount} more "
            "time${debugNewCanvasSaveCount - debugPreviousCanvasSaveCount == 1 ? "" : "s"} "
            "than it called canvas.restore().",
          ),
          ErrorDescription(
            "This leaves the canvas in an inconsistent state and will probably result in a broken display.",
          ),
          ErrorHint(
            "You must pair each call to save()/saveLayer() with a later matching call to restore().",
          ),
        ]);
      }
      if (debugNewCanvasSaveCount < debugPreviousCanvasSaveCount) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
            "The caller invoked canvas.restore() "
            "${debugPreviousCanvasSaveCount - debugNewCanvasSaveCount} more "
            "time${debugPreviousCanvasSaveCount - debugNewCanvasSaveCount == 1 ? "" : "s"} "
            "than it called canvas.save() or canvas.saveLayer().",
          ),
          ErrorDescription(
            "This leaves the canvas in an inconsistent state and will result in a broken display.",
          ),
          ErrorHint(
            "You should only call restore() if you first called save() or saveLayer().",
          ),
        ]);
      }
      return debugNewCanvasSaveCount == debugPreviousCanvasSaveCount;
    }());

    canvas.restore();
  }
}

extension CanvasExtension on Canvas {
  void withTransform(void Function() paint) {
    late int debugPreviousCanvasSaveCount;
    save();
    assert(() {
      debugPreviousCanvasSaveCount = getSaveCount();
      return true;
    }());

    paint();

    assert(() {
      // This isn't perfect. For example, we can't catch the case of
      // someone first restoring, then setting a transform or whatnot,
      // then saving.
      // If this becomes a real problem, we could add logic to the
      // Canvas class to lock the canvas at a particular save count
      // such that restore() fails if it would take the lock count
      // below that number.
      final int debugNewCanvasSaveCount = getSaveCount();
      if (debugNewCanvasSaveCount > debugPreviousCanvasSaveCount) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
            "The caller invoked canvas.save() or canvas.saveLayer() at least "
            "${debugNewCanvasSaveCount - debugPreviousCanvasSaveCount} more "
            "time${debugNewCanvasSaveCount - debugPreviousCanvasSaveCount == 1 ? "" : "s"} "
            "than it called canvas.restore().",
          ),
          ErrorDescription(
            "This leaves the canvas in an inconsistent state and will probably result in a broken display.",
          ),
          ErrorHint(
            "You must pair each call to save()/saveLayer() with a later matching call to restore().",
          ),
        ]);
      }
      if (debugNewCanvasSaveCount < debugPreviousCanvasSaveCount) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
            "The caller invoked canvas.restore() "
            "${debugPreviousCanvasSaveCount - debugNewCanvasSaveCount} more "
            "time${debugPreviousCanvasSaveCount - debugNewCanvasSaveCount == 1 ? "" : "s"} "
            "than it called canvas.save() or canvas.saveLayer().",
          ),
          ErrorDescription(
            "This leaves the canvas in an inconsistent state and will result in a broken display.",
          ),
          ErrorHint(
            "You should only call restore() if you first called save() or saveLayer().",
          ),
        ]);
      }
      return debugNewCanvasSaveCount == debugPreviousCanvasSaveCount;
    }());

    restore();
  }
}
