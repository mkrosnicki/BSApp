import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class AppLogoHeader extends StatelessWidget {
  const AppLogoHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        color: MyColorsProvider.PASTEL_BLUE,
        border: Border.all(color: MyColorsProvider.PASTEL_BLUE, width: 3.0),
      ),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            // ignore: avoid_unnecessary_containers
            child: Container(
              decoration: BoxDecoration(
                color: MyColorsProvider.PASTEL_BLUE,
                border: Border.all(color: MyColorsProvider.PASTEL_BLUE, width: 2.0),
              ),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Image.asset(
                        'assets/images/logo2000.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
