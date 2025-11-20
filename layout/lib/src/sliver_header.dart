import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/rendering.dart' as flutter;

@immutable
class FloatingHeaderSnapConfiguration
    implements flutter.FloatingHeaderSnapConfiguration {
  const FloatingHeaderSnapConfiguration({
    this.curve = Curves.ease,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  final Curve curve;

  @override
  final Duration duration;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          other is FloatingHeaderSnapConfiguration &&
          curve == other.curve &&
          duration == other.duration;

  @override
  int get hashCode => Object.hash(runtimeType, curve, duration);
}

@immutable
class PersistentHeaderShowOnScreenConfiguration
    implements flutter.PersistentHeaderShowOnScreenConfiguration {
  const PersistentHeaderShowOnScreenConfiguration({
    this.minShowOnScreenExtent = double.negativeInfinity,
    this.maxShowOnScreenExtent = double.infinity,
  }) : assert(minShowOnScreenExtent <= maxShowOnScreenExtent);

  @override
  final double minShowOnScreenExtent;

  @override
  final double maxShowOnScreenExtent;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          other is PersistentHeaderShowOnScreenConfiguration &&
          minShowOnScreenExtent == other.minShowOnScreenExtent &&
          maxShowOnScreenExtent == other.maxShowOnScreenExtent;

  @override
  int get hashCode =>
      Object.hash(runtimeType, minShowOnScreenExtent, maxShowOnScreenExtent);
}

@immutable
class OverScrollHeaderStretchConfiguration
    implements flutter.OverScrollHeaderStretchConfiguration {
  const OverScrollHeaderStretchConfiguration({
    this.stretchTriggerOffset = 100.0,
    this.onStretchTrigger,
  });

  @override
  final double stretchTriggerOffset;

  @override
  final AsyncCallback? onStretchTrigger;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          other is OverScrollHeaderStretchConfiguration &&
          stretchTriggerOffset == other.stretchTriggerOffset &&
          onStretchTrigger == other.onStretchTrigger;

  @override
  int get hashCode =>
      Object.hash(runtimeType, stretchTriggerOffset, onStretchTrigger);
}

typedef SliverHeaderBuilder =
    Widget Function(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
    );

class SliverHeader extends StatefulWidget {
  const SliverHeader({
    super.key,
    this.pinned = false,
    this.floating = false,
    this.snapConfiguration,
    this.showOnScreenConfiguration,
    this.stretchConfiguration,
    required this.minExtent,
    required this.maxExtent,
    required this.builder,
  });

  final bool pinned;
  final bool floating;

  final FloatingHeaderSnapConfiguration? snapConfiguration;
  final PersistentHeaderShowOnScreenConfiguration? showOnScreenConfiguration;
  final OverScrollHeaderStretchConfiguration? stretchConfiguration;
  final double minExtent;
  final double maxExtent;
  final SliverHeaderBuilder builder;

  @override
  State<SliverHeader> createState() => _SliverHeaderState();
}

// TODO: investigate sometimes creating multiple tickers
class _SliverHeaderState extends State<SliverHeader>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => SliverPersistentHeader(
    pinned: widget.pinned,
    floating: widget.floating,
    delegate: _SliverHeaderDelegate(
      vsync: this,
      snapConfiguration: widget.snapConfiguration,
      showOnScreenConfiguration: widget.showOnScreenConfiguration,
      stretchConfiguration: widget.stretchConfiguration,
      minExtent: widget.minExtent,
      maxExtent: widget.maxExtent,
      builder: widget.builder,
    ),
  );
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _SliverHeaderDelegate({
    this.vsync,
    this.snapConfiguration,
    this.showOnScreenConfiguration,
    this.stretchConfiguration,
    required this.minExtent,
    required this.maxExtent,
    required this.builder,
  });

  final SliverHeaderBuilder builder;

  @override
  final TickerProvider? vsync;

  @override
  final FloatingHeaderSnapConfiguration? snapConfiguration;

  @override
  final PersistentHeaderShowOnScreenConfiguration? showOnScreenConfiguration;

  @override
  final OverScrollHeaderStretchConfiguration? stretchConfiguration;

  @override
  final double minExtent;

  @override
  final double maxExtent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) => builder(context, shrinkOffset, overlapsContent);

  @override
  bool shouldRebuild(_SliverHeaderDelegate oldDelegate) =>
      vsync != oldDelegate.vsync ||
      snapConfiguration != oldDelegate.snapConfiguration ||
      showOnScreenConfiguration != oldDelegate.showOnScreenConfiguration ||
      stretchConfiguration != oldDelegate.stretchConfiguration ||
      minExtent != oldDelegate.minExtent ||
      maxExtent != oldDelegate.maxExtent ||
      builder != oldDelegate.builder;
}
