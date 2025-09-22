import 'dynamic_color.dart';
import 'tone_polarity.dart';

enum DeltaConstraint { exact, nearer, farther }

final class ToneDeltaPair {
  const ToneDeltaPair.withStayTogether(
    this.roleA,
    this.roleB,
    this.delta,
    this.polarity,
    this.stayTogether,
  ) : constraint = DeltaConstraint.exact;

  const ToneDeltaPair.withConstraint(
    this.roleA,
    this.roleB,
    this.delta,
    this.polarity,
    this.constraint,
  ) : stayTogether = true;

  final DynamicColor roleA;
  final DynamicColor roleB;
  final double delta;
  final TonePolarity polarity;
  final bool stayTogether;
  final DeltaConstraint constraint;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        runtimeType == other.runtimeType &&
            other is ToneDeltaPair &&
            roleA == other.roleA &&
            roleB == other.roleB &&
            delta == other.delta &&
            polarity == other.polarity &&
            stayTogether == other.stayTogether &&
            constraint == other.constraint;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    roleA,
    roleA,
    delta,
    polarity,
    stayTogether,
    constraint,
  );
}
