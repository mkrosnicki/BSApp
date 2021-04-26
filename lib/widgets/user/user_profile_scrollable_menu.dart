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
  static const menuItemStyle = TextStyle(fontSize: 12);
  static const activeMenuItemStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
  static const BoxDecoration activeItemDecoration = BoxDecoration(
    border: Border(
      bottom: BorderSide(
          color: MyColorsProvider.BLUE, width: 1.0, style: BorderStyle.solid),
    ),
  );

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40,
      // padding: const EdgeInsets.all(9.0),
      color: Colors.white,
      width: double.infinity,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMenuItem('Aktywność', 0),
          _buildMenuItem('Okazje', 1),
          _buildMenuItem('Forum', 2),
        ],
      ),
    );
  }

  _buildMenuItem(String label, int index) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: () => _setIndex(index),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            label,
            style: selectedIndex == index ? activeMenuItemStyle : menuItemStyle,
          ),
          decoration: selectedIndex == index ? activeItemDecoration : null,
        ),
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
