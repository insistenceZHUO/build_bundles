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
      // appBar: AppBar(
      //   title: const Text('绘制开篇'),
      // ),
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
    /// 线帽;
    drawStrokeCap(canvas);
  }

  void drawCircle (Canvas canvas){
    var paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(50, 50), 50, paint);

  }

  void drawStrokeCap(Canvas canvas) {
    Paint paint =  Paint();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;
    canvas.drawLine(
        const Offset(10, 0), const Offset(10, 150), paint..strokeCap = StrokeCap.butt);
    canvas.drawLine(const Offset(50 + 50.0, 50), const Offset(50 + 50.0, 150),
        paint..strokeCap = StrokeCap.round);
    canvas.drawLine(const Offset(50 + 50.0 * 2, 50), const Offset(50 + 50.0 * 2, 150),
        paint..strokeCap = StrokeCap.square);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
