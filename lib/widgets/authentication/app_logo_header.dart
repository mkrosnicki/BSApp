import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class AppLogoHeader extends StatelessWidget {
  const AppLogoHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColorsProvider.PASTEL_BLUE,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0, top: 20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Image.asset(
                        'assets/images/logo5.png',
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
