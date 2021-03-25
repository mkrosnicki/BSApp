import 'package:BSApp/widgets/common/my_border_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DealDetailsActions extends StatelessWidget {
  DealDetailsActions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButtonWithPaddings(
                  label: 'Nieprzydatna',
                  iconData: CupertinoIcons.hand_thumbsdown_fill,
                  function: () {},
                  trailing: '2'),
              _buildButtonWithPaddings(
                  label: 'Przydatna',
                  iconData: CupertinoIcons.hand_thumbsup_fill,
                  function: () {},
                  trailing: '2'),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  _buildButtonWithPaddings(
      {String label,
      IconData iconData,
      Function function,
      String trailing,
      bool isActive = false}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
        child: MyBorderIconButton(
            label: label,
            iconData: iconData,
            function: function,
            trailing: trailing,
            isActive: isActive),
      ),
    );
  }
}
