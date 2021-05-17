import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/social_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FacebookButton extends StatelessWidget {

  const FacebookButton();

  @override
  Widget build(BuildContext context) {
    return SocialButton('Zaloguj przez Facebooka', FontAwesomeIcons.facebook, const Color.fromRGBO(66, 103, 178, 1.0), () => null);
  }
}
