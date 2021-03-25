import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_border_icon_button.dart';

class GreenVotingButton extends StatelessWidget {
  final String label;
  final Function function;
  final String trailing;
  final bool isActive;

  GreenVotingButton({this.label, this.function, this.trailing, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return MyBorderIconButton(
        label: label,
        iconData: CupertinoIcons.hand_thumbsup_fill,
        function: function,
        trailing: trailing,
        color: Colors.green,
        isActive: isActive);
  }
}
