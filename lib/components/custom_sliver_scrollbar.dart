import 'dart:math' as math;

import 'package:obtainium/flutter.dart';

class SliverScrollbar extends StatefulWidget {
  const SliverScrollbar({super.key, required this.sliver});

  final Widget sliver;

  @override
  State<SliverScrollbar> createState() => _SliverScrollbarState();
}

class _SliverScrollbarState extends State<SliverScrollbar> {
  @override
  Widget build(BuildContext context) {
    return _SliverScrollbar(sliver: widget.sliver);
    return NotificationListener<ScrollMetricsNotification>(
      child: NotificationListener<ScrollNotification>(
        child: RepaintBoundary(
          child: Listener(
            child: RawGestureDetector(
              child: MouseRegion(
                child: _SliverScrollbar(sliver: widget.sliver),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverScrollbar extends SingleChildRenderObjectWidget {
  const _SliverScrollbar({super.key, required Widget sliver})
    : super(child: sliver);

  @override
  _RenderSliverScrollbar createRenderObject(BuildContext context) {
    return _RenderSliverScrollbar();
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderSliverScrollbar renderObject,
  ) {}
}

class _RenderSliverScrollbar extends RenderProxySliver {
  _RenderSliverScrollbar({RenderSliver? child}) : super(child);

  @override
  void performLayout() {
    assert(child != null);
    child!.layout(constraints, parentUsesSize: true);
    geometry = child!.geometry;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);

    late int debugPreviousCanvasSaveCount;
    context.canvas.save();
    assert(() {
      debugPreviousCanvasSaveCount = context.canvas.getSaveCount();
      return true;
    }());

    if (offset != Offset.zero) {
      context.canvas.translate(offset.dx, offset.dy);
    }

    // TODO: paint here

    // // The numerator is the current progress of the journey. This is always how much
    // // the sliver has been scrolled off the top.
    // final double currentScroll = constraints.scrollOffset;

    // // The denominator is the total distance of the scroll journey for this sliver.
    // // This value must be constant and is determined by the sliver's total size
    // // and the maximum space it can occupy in the viewport.

    // // First, determine the maximum paintable area available to this sliver when no
    // // subsequent slivers are visible. This is a fixed value for the journey.
    // final double maxPaintableExtent =
    //     constraints.viewportMainAxisExtent - constraints.overlap;

    // // Now, calculate the total distance of the scroll journey based on whether the
    // // sliver is taller or shorter than the available area.
    // final double totalScrollableDistance;

    // if (geometry!.scrollExtent <= maxPaintableExtent) {
    //   // CASE 1: The sliver is SHORTER than or fits perfectly in the paintable area.
    //   // Its journey is the process of scrolling its entire body off the screen.
    //   // The total distance for this journey is simply its own height. `value` will
    //   // reach 1.0 when it has been scrolled off completely.
    //   totalScrollableDistance = geometry!.scrollExtent;
    // } else {
    //   // CASE 2: The sliver is TALLER than the paintable area.
    //   // Its journey is the process of revealing all of its "hidden" content. The
    //   // total distance to scroll is the difference between its total height and the
    //   // height of the area it can be seen through. The journey ends (value = 1.0)
    //   // when its bottom edge aligns with the viewport's bottom edge.
    //   totalScrollableDistance = geometry!.scrollExtent - maxPaintableExtent;
    // }

    // // Finally, calculate the value.
    // // This is the ratio of current progress to the total journey distance.
    // // We clamp the result to ensure it stays within the 0.0 to 1.0 range
    // // and protect against division by zero if the sliver has no extent.
    // final double value = totalScrollableDistance > 0.0
    //     ? (currentScroll / totalScrollableDistance).clamp(0.0, 1.0)
    //     : 0.0;

    final trackStart = geometry!.paintOrigin + constraints.overlap;
    final trackEnd = geometry!.paintExtent;
    final trackLength = trackEnd - trackStart;

    final nextSliverExtent =
        constraints.remainingPaintExtent - geometry!.paintExtent;
    final previousSliverExtent = constraints.precedingScrollExtent;
    final scrolled =
        constraints.scrollOffset + constraints.overlap - nextSliverExtent;
    final fixedAfterOverlapStart =
        constraints.remainingPaintExtent - constraints.overlap;
    // final value =
    //     scrolled /
    //     (constraints.viewportMainAxisExtent -
    //         nextSliverExtent -
    //         previousSliverExtent);
    double value = scrolled;
    debugPrint("value: $value");
    // if (value > 0.0) {

    // 0 on no scroll, 56 after the app bar is collapsed (when overlap starts)
    final thing2 = math.max(
      0.0,
      -(constraints.viewportMainAxisExtent -
          geometry!.layoutExtent -
          constraints.precedingScrollExtent +
          constraints.overlap -
          nextSliverExtent),
    );

    debugPrint(
      // "other: "
      // "${(constraints.remainingPaintExtent - constraints.overlap).toStringAsFixed(2)}"
      // " ${(geometry!.paintExtent - constraints.scrollOffset).toStringAsFixed(2)}"
      // " ${(previousSliverExtent - constraints.overlap).toStringAsFixed(2)}"
      // " scrolled: ${scrolled.toStringAsFixed(2)}"
      // " scrollOffset: ${constraints.scrollOffset.toStringAsFixed(2)}"
      // " trackLength: ${trackLength.toStringAsFixed(2)}"
      // " nextSliverExtent: ${nextSliverExtent.toStringAsFixed(2)}"
      " A: ${(constraints.scrollOffset + constraints.overlap).toStringAsFixed(2)}"
      " B: ${(constraints.remainingPaintExtent - constraints.overlap).toStringAsFixed(2)}"
      " C: ${(constraints.remainingPaintExtent + constraints.precedingScrollExtent - constraints.overlap).toStringAsFixed(2)}"
      " D: ${(constraints.precedingScrollExtent - constraints.overlap).toStringAsFixed(2)}"
      " E: ${(constraints.remainingPaintExtent - constraints.overlap).toStringAsFixed(2)}"
      " F: ${(geometry!.layoutExtent - constraints.overlap - thing2 + nextSliverExtent).toStringAsFixed(2)}"
      " G: ${((constraints.scrollOffset + constraints.overlap - nextSliverExtent) * (geometry!.layoutExtent - constraints.overlap - thing2 + nextSliverExtent) / (constraints.viewportMainAxisExtent)).toStringAsFixed(2)}"
      " H: ${(geometry!.paintExtent - constraints.overlap - thing2 + nextSliverExtent).toStringAsFixed(2)}"
      " I: ${((constraints.scrollOffset + constraints.overlap - nextSliverExtent) / (geometry!.scrollExtent - thing2)).toStringAsFixed(2)}"
      " J: ${((geometry!.paintExtent + thing2 - constraints.overlap) / (constraints.viewportMainAxisExtent - thing2)).toStringAsFixed(2)}"
      " K: ${((constraints.scrollOffset + constraints.overlap - nextSliverExtent) / (constraints.viewportMainAxisExtent)).toStringAsFixed(2)}"
      " L: ${((geometry!.scrollExtent) / (constraints.viewportMainAxisExtent)).toStringAsFixed(2)}",
    );
    // }

    final trackRect = Rect.fromLTRB(
      0.0,
      // TODO: uncomment
      trackStart + trackLength * clampDouble(value, 0.0, 1.0),
      // trackStart,
      16.0,
      trackEnd,
    );
    context.canvas.drawRect(
      trackRect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.red, Colors.blue],
        ).createShader(trackRect),
    );

    assert(() {
      final int debugNewCanvasSaveCount = context.canvas.getSaveCount();
      return debugNewCanvasSaveCount == debugPreviousCanvasSaveCount;
    }());
    context.canvas.restore();
  }
}
