import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DealsNotFound extends StatelessWidget {

  const DealsNotFound();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              Icon(CupertinoIcons.clear, color: MyColorsProvider.LIGHT_GRAY, size: 60),
              Text(
                'Nie znaleziono żadnych okazji',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    height: 2,
                    fontWeight: FontWeight.w600,
                    color: MyColorsProvider.LIGHT_GRAY),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
