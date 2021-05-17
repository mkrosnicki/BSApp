import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/social_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleButton extends StatelessWidget {

  const GoogleButton();

  @override
  Widget build(BuildContext context) {
    return SocialButton('Zaloguj przez Google', FontAwesomeIcons.google, const Color.fromRGBO(219, 68, 55, 1.0), () => null);
  }
}
