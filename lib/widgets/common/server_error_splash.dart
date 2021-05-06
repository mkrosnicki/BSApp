import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServerErrorSplash extends StatelessWidget {

  const ServerErrorSplash();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(CupertinoIcons.wifi_slash, color: MyColorsProvider.LIGHT_GRAY, size: 60),
            const Text(
              'Błąd komunikacji z serwerem',
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
    );
  }
}
