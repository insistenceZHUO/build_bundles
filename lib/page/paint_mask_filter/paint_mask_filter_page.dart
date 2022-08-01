import 'package:flutter/material.dart';

class PaintMaskFilterPage extends StatelessWidget {
  const PaintMaskFilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('mask filter'),
      ),
      body: CustomPaint(
        painter: MaskFilterPaint(animationValue: 1.0),
      ),
    );
  }
}

class MaskFilterPaint extends CustomPainter {
  final double animationValue;

  MaskFilterPaint({
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
