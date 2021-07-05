import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class UserProfileScrollableMenu extends StatefulWidget {
  final PublishSubject<int> contentIdSubject;

  const UserProfileScrollableMenu(this.contentIdSubject);

  @override
  _UserProfileScrollableMenuState createState() => _UserProfileScrollableMenuState();
}

class _UserProfileScrollableMenuState extends State<UserProfileScrollableMenu> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: const BoxDecoration(
        color: Colors.white,
        // border: Border(
        //   bottom: BorderSide(color: MyColorsProvider.LIGHT_GRAY),
        // ),
      ),
      width: double.infinity,
      alignment: Alignment.bottomCenter,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildMenuItem('Aktywność', 0),
          _buildMenuItem('Okazje', 1),
          _buildMenuItem('Tematy', 2),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String label, int index) {
    return Expanded(
      child: FlatButton(
        onPressed: () => _setIndex(index),
        shape: selectedIndex == index
            ? const Border(
                bottom: BorderSide(color: MyColorsProvider.DEEP_BLUE, width: 1.2),
              )
            : const Border(),
        child: Text(
          label,
          style: selectedIndex == index
              ? MyStylingProvider.SELECTED_TAB_TEXT_STYLE
              : MyStylingProvider.UNSELECTED_TAB_TEXT_STYLE,
        ),
      ),
    );
  }

  void _setIndex(int i) {
    setState(() {
      selectedIndex = i;
    });
    widget.contentIdSubject.add(i);
  }
}
