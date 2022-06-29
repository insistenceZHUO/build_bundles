import 'package:flutter/material.dart';

class Chapter1Page extends StatefulWidget {
  const Chapter1Page({Key? key}) : super(key: key);

  @override
  _Chapter1PageState createState() => _Chapter1PageState();
}

class _Chapter1PageState extends State<Chapter1Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: CustomPaint(
          painter: PaperPainter(),
        ),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(100, 100), 20, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
