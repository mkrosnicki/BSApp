import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class MyProfileStatisticsInfo extends StatefulWidget {
  @override
  _MyProfileStatisticsInfoState createState() =>
      _MyProfileStatisticsInfoState();
}

class _MyProfileStatisticsInfoState extends State<MyProfileStatisticsInfo> {
  static const statNameStyle = TextStyle(fontSize: 11, color: Colors.grey);
  static const activeMenuItemStyle =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w600);

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      color: Colors.white,
      width: double.infinity,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatisticTile('Okazje', 1, false, true),
          _buildStatisticTile('Komentarze', 2, false, true),
          _buildStatisticTile('Posty', 3, false, false),
        ],
      ),
    );
  }

  _buildStatisticTile(String label, int index, bool borderLeft, bool borderRight) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: () => _setIndex(index),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                '99',
                style: activeMenuItemStyle,
              ),
              Text(
                label,
                style: statNameStyle,
              ),
            ],
          ),
          decoration: BoxDecoration(
            border: Border(
              left: borderLeft ? BorderSide(
                  color: MyColorsProvider.GREY_BORDER_COLOR, width: 1) : BorderSide(style: BorderStyle.none),
              right: borderRight ? BorderSide(
                  color: MyColorsProvider.GREY_BORDER_COLOR, width: 1) : BorderSide(style: BorderStyle.none)
            ),
          ),
        ),
      ),
    );
  }

  _setIndex(int i) {
    setState(() {
      this.selectedIndex = i;
    });
  }
}
