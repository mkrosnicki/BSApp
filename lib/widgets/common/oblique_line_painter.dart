import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ObliqueLinePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(0, size.height);
    final p2 = Offset(size.width - 10, 10);
    final paint = Paint()
      ..color = MyColorsProvider.LIGHT_GRAY
      ..strokeWidth = 4;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {

  }
}