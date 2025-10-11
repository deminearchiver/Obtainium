import 'package:obtainium/flutter.dart';

class CustomLinearProgressIndicator extends StatefulWidget {
  const CustomLinearProgressIndicator({super.key, required this.progress});

  final double? progress;

  @override
  State<CustomLinearProgressIndicator> createState() =>
      _CustomLinearProgressIndicatorState();
}

class _CustomLinearProgressIndicatorState
    extends State<CustomLinearProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, 16.0),
      painter: _LinearProgressIndicatorPainter(progressFractions: []),
    );
  }
}

class _LinearProgressIndicatorPainter extends CustomPainter {
  const _LinearProgressIndicatorPainter({required this.progressFractions});

  final List<double> progressFractions;

  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(_LinearProgressIndicatorPainter oldDelegate) {
    return !listEquals(progressFractions, oldDelegate.progressFractions);
  }
}

class CustomCircularProgressIndicator extends StatefulWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  State<CustomCircularProgressIndicator> createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
