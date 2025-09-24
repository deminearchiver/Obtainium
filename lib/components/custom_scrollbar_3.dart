import 'package:obtainium/flutter.dart';

class CustomScrollbar3 extends StatefulWidget {
  const CustomScrollbar3({super.key, required this.sliver});

  final Widget sliver;

  @override
  State<CustomScrollbar3> createState() => _CustomScrollbar3State();
}

class _CustomScrollbar3State extends State<CustomScrollbar3> {
  @override
  Widget build(BuildContext context) {
    return _CustomScrollbar(sliver: widget.sliver);
    return NotificationListener<ScrollMetricsNotification>(
      child: NotificationListener<ScrollNotification>(
        child: RepaintBoundary(
          child: Listener(
            child: RawGestureDetector(
              child: MouseRegion(
                child: _CustomScrollbar(sliver: widget.sliver),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomScrollbar extends SingleChildRenderObjectWidget {
  const _CustomScrollbar({super.key, Widget? sliver}) : super(child: sliver);

  @override
  _RenderCustomScrollbar createRenderObject(BuildContext context) {
    return _RenderCustomScrollbar();
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderCustomScrollbar renderObject,
  ) {}
}

class _RenderCustomScrollbar extends RenderProxySliver {
  _RenderCustomScrollbar({RenderSliver? child}) : super(child);

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

    // final value = geometry!.paintExtent;
    // final nextSliverExtent =
    // constraints.remainingPaintExtent - geometry!.paintExtent;
    final nextSliverExtent1 = constraints.scrollOffset;
    final nextSliverExtent2 =
        constraints.remainingPaintExtent - geometry!.paintExtent;
    final previousSliverExtent = constraints.precedingScrollExtent;
    final value = (
      constraints.scrollOffset,
      constraints.remainingPaintExtent - constraints.scrollOffset,
    );
    // final value =
    //     (constraints.scrollOffset - constraints.overlap - nextSliverExtent) /
    //     (geometry!.scrollExtent - constraints.overlap - nextSliverExtent);

    debugPrint("$value");

    final trackRect = Rect.fromLTRB(
      0.0,
      // TODO: uncomment
      // trackStart + trackLength * clampDouble(value, 0.0, 1.0),
      trackStart,
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
