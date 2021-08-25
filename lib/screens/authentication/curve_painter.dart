import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = MyColorsProvider.PASTEL_BLUE;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, -1);
    path.quadraticBezierTo(
        size.width * 0.85, size.height * 2, size.width, size.height * 0.2);
    path.lineTo(size.width, -1);
    path.lineTo(-1, -1);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}