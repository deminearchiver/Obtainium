library;

export 'src/color/color_theme.dart';
export 'src/color/palette_theme.dart';

export 'src/icon/icon.dart';
export 'src/icon/icon_theme.dart';

export 'src/motion/duration_theme.dart';
export 'src/motion/easing_theme.dart';
export 'src/motion/spring_theme.dart';

export 'src/shape/corners_border.dart';
export 'src/shape/corners.dart';
export 'src/shape/shape_theme.dart';

export 'src/state/state.dart';
export 'src/state/state_theme.dart';

export 'src/typography/type_style.dart';
export 'src/typography/typeface_theme.dart';
export 'src/typography/typescale_theme.dart';

export 'src/elevation_theme.dart';

export 'src/focus_ring.dart';

export 'src/progress_indicator.dart';

export 'src/checkbox.dart';

export 'src/radio_button.dart';

export 'src/switch.dart';

export 'src/window_size_class.dart';

export 'src/animation_extensions.dart';

// TODO: review after LoadingIndicator gets a custom implementation
export 'src/loading_indicator/loading_indicator.dart';
export 'src/loading_indicator/loading_indicator_theme.dart';

import 'src/flutter.dart';

// TODO: maybe this should be moved to the layout package?
typedef ChildPositioner = void Function(RenderBox child, Offset position);

extension PaintingContextExtension on PaintingContext {
  void withCanvasTransform(void Function(PaintingContext context) paint) {
    late int debugPreviousCanvasSaveCount;
    canvas.save();
    assert(() {
      debugPreviousCanvasSaveCount = canvas.getSaveCount();
      return true;
    }());

    paint(this);

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
  void withTransform(void Function(Canvas canvas) paint) {
    late int debugPreviousCanvasSaveCount;
    save();
    assert(() {
      debugPreviousCanvasSaveCount = getSaveCount();
      return true;
    }());

    paint(this);

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
