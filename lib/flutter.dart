library;

// TODO: adjust pacakge

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

export 'package:material_symbols_icons/material_symbols_icons.dart';

// Internal packages

export 'package:material/material.dart';
