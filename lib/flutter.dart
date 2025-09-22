library;

// SDK packages

export 'package:flutter/foundation.dart';

export 'package:flutter/services.dart';

export 'package:flutter/physics.dart';

export 'package:flutter/rendering.dart';

export 'package:flutter/material.dart'
    hide
        // Force migration to Material Symbols
        Icons,
        AnimatedIcons;

// Third-party packages

export 'package:meta/meta.dart';
export 'package:material_symbols_icons/material_symbols_icons.dart';

// Internal packages

export 'package:material/material.dart';

// Self-import

import 'package:obtainium/flutter.dart';

@immutable
class CombiningBuilder extends StatelessWidget {
  const CombiningBuilder({
    super.key,
    this.useOuterContext = false,
    required this.builders,
    required this.child,
  });

  final bool useOuterContext;

  final List<Widget Function(BuildContext context, Widget child)> builders;

  /// The child widget to pass to the last of [builders].
  ///
  /// {@macro flutter.widgets.transitions.ListenableBuilder.optimizations}
  final Widget child;

  @override
  Widget build(BuildContext outerContext) {
    return builders.reversed.fold(child, (child, buildOuter) {
      return useOuterContext
          ? buildOuter(outerContext, child)
          : Builder(builder: (innerContext) => buildOuter(innerContext, child));
    });
  }
}
