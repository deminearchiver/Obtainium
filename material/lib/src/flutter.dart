library;

// SDK packages

export 'package:flutter/foundation.dart';

export 'package:flutter/services.dart';

export 'package:flutter/physics.dart';

export 'package:flutter/rendering.dart'
    hide
        FlexParentData,
        RenderFlex,
        FloatingHeaderSnapConfiguration,
        PersistentHeaderShowOnScreenConfiguration,
        OverScrollHeaderStretchConfiguration;

export 'package:flutter/material.dart'
    hide
        // package:layout
        // ---
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
        Switch,
        SwitchTheme,
        SwitchThemeData;

// Third-party packages

export 'package:meta/meta.dart';
export 'package:material_symbols_icons/material_symbols_icons.dart';

// Internal packages

export 'package:layout/layout.dart';
export 'package:material/material.dart';
