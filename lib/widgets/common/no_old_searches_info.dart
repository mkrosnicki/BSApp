import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/oblique_line_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoOldSearchesInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: Stack(
            children: [
              const Center(
                child: Icon(
                  CupertinoIcons.search,
                  size: 82,
                  color: MyColorsProvider.LIGHT_GRAY,
                ),
              ),
              CustomPaint(
                size: const Size(80, 70),
                painter: ObliqueLinePainter(),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Brak ostatnich\nwyszukiwań',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: MyColorsProvider.LIGHT_GRAY, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}
