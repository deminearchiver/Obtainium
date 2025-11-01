import 'dart:math' as math;

abstract final class MathUtils {
  static T signum<T extends num>(T num) {
    return num.sign as T;
  }

  // static T lerp<T extends num>(T start, T stop, double amount) {
  //   return (1.0 - amount) * start + amount * stop as T;
  // }
  static double lerp(double start, double stop, double amount) {
    return (1.0 - amount) * start + amount * stop;
  }

  // static T clamp<T extends num>(T min, T max, T input) {
  //   return input.clamp(min, max) as T;
  // }

  static int clampInt(int min, int max, int input) {
    if (input < min) {
      return min;
    } else if (input > max) {
      return max;
    }

    return input;
  }

  static double clampDouble(double min, double max, double input) {
    if (input < min) {
      return min;
    } else if (input > max) {
      return max;
    }

    return input;
  }

  // static T sanitizeDegrees<T extends num>(T degrees) {
  //   degrees = (degrees % 360.0) as T;
  //   if (degrees < 0.0) {
  //     degrees = degrees + 360.0 as T;
  //   }
  //   return degrees;
  // }

  static int sanitizeDegreesInt(int degrees) {
    degrees = degrees % 360;
    if (degrees < 0) {
      degrees = degrees + 360;
    }
    return degrees;
  }

  static double sanitizeDegreesDouble(double degrees) {
    degrees = degrees % 360.0;
    if (degrees < 0.0) {
      degrees = degrees + 360.0;
    }
    return degrees;
  }

  static double rotationDirection(double from, double to) {
    final increasingDifference = sanitizeDegreesDouble(to - from);
    return increasingDifference <= 180.0 ? 1.0 : -1.0;
  }
  // static T rotationDirection<T extends num>(T from, T to) {
  //   final increasingDifference = sanitizeDegrees<T>(to - from as T);
  //   final rotationDirection = increasingDifference <= 180.0 ? 1.0 : -1.0;
  //   return rotationDirection as T;
  // }

  static double differenceDegrees(double a, double b) {
    return 180.0 - ((a - b).abs() - 180.0).abs();
  }
  // static T differenceDegrees<T extends num>(T a, T b) {
  //   final differenceDegrees = 180.0 - ((a - b).abs() - 180.0).abs();
  //   return differenceDegrees as T;
  // }

  static List<T> matrixMultiply<T extends num>(
    List<T> row,
    List<List<T>> matrix,
  ) {
    final a =
        row[0] * matrix[0][0] + row[1] * matrix[0][1] + row[2] * matrix[0][2]
            as T;
    final b =
        row[0] * matrix[1][0] + row[1] * matrix[1][1] + row[2] * matrix[1][2]
            as T;
    final c =
        row[0] * matrix[2][0] + row[1] * matrix[2][1] + row[2] * matrix[2][2]
            as T;
    return [a, b, c];
  }

  static double toRadians(double degrees) {
    return degrees * math.pi / 180.0;
  }

  static double toDegrees(double radians) {
    return radians * 180.0 / math.pi;
  }

  static double hypot(double a, double b) {
    return math.sqrt(a * a + b * b);
  }
}
