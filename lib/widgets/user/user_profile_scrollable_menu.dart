import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class UserProfileScrollableMenu extends StatefulWidget {
  final PublishSubject<int> contentIdSubject;

  UserProfileScrollableMenu(this.contentIdSubject);

  @override
  _UserProfileScrollableMenuState createState() =>
      _UserProfileScrollableMenuState();
}

class _UserProfileScrollableMenuState extends State<UserProfileScrollableMenu> {
  static const menuItemStyle = TextStyle(color: Colors.black, fontSize: 13);
  static const activeMenuItemStyle =
      TextStyle(color: Colors.black, fontSize: 13);
  static const Border activeItemDecoration = Border(
    bottom: BorderSide(
        color: MyColorsProvider.DEEP_BLUE, width: 1.0, style: BorderStyle.solid),
  );

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      color: Colors.white,
      width: double.infinity,
      alignment: Alignment.bottomCenter,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildMenuItem('Aktywność', 0),
          _buildMenuItem('Okazje', 1),
          _buildMenuItem('Forum', 2),
        ],
      ),
    );
  }

  _buildMenuItem(String label, int index) {
    return Expanded(
      flex: 1,
      child: FlatButton(
        onPressed: () => _setIndex(index),
        child: Text(
          label,
          style: selectedIndex == index ? activeMenuItemStyle : menuItemStyle,
        ),
        shape: selectedIndex == index ? activeItemDecoration : Border(),
      ),
    );
  }

  _setIndex(int i) {
    setState(() {
      this.selectedIndex = i;
    });
    widget.contentIdSubject.add(i);
  }
}
