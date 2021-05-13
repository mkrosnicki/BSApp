import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';

class LoginToContinueSplash extends StatelessWidget {
  final String text;

  const LoginToContinueSplash(this.text);

  @override
  Widget build(BuildContext context) {
    final double buttonSize = MediaQuery.of(context).size.width * 0.7;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.white,
      // color: MyColorsProvider.SUPER_LIGHT_GREY,
      child: Center(
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18, height: 1.5, fontWeight: FontWeight.w600, color: MyColorsProvider.LIGHT_GRAY),
              ),
            ),
            Container(
              width: buttonSize,
              child: PrimaryButton('Zaloguj się', () => AuthScreenProvider.showLoginScreen(context)),
            ),
          ],
        ),
      ),
    );
  }
}
