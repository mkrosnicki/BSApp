import 'package:BSApp/models/user_details_model.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class UserProfileStatisticsInfo extends StatefulWidget {
  final UserDetailsModel user;

  const UserProfileStatisticsInfo(this.user);

  @override
  _UserProfileStatisticsInfoState createState() => _UserProfileStatisticsInfoState();
}

class _UserProfileStatisticsInfoState extends State<UserProfileStatisticsInfo> {
  static const statNameStyle = TextStyle(fontSize: 11, color: Colors.grey);
  static const activeMenuItemStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.w600);

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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMenuItem('punkty \nza okazje', widget.user.pointsForDeals.toString(), 1, false, true),
          _buildMenuItem('polubione \nwypowiedzi', widget.user.likesCount.toString(), 2, false, true),
          _buildMenuItem('wypowiedzi \ndziennie', widget.user.activityPerDay.toStringAsFixed(2), 3, false, false),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String label, String count, int index, bool borderLeft, bool borderRight) {
    return Flexible(
      child: GestureDetector(
        onTap: () => _setIndex(index),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border(
                left: borderLeft
                    ? const BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR)
                    : const BorderSide(style: BorderStyle.none),
                right: borderRight
                    ? const BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR)
                    : const BorderSide(style: BorderStyle.none)),
          ),
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                count,
                textAlign: TextAlign.center,
                style: activeMenuItemStyle,
              ),
              Text(
                label,
                textAlign: TextAlign.center,
                style: statNameStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setIndex(int i) {
    setState(() {
      selectedIndex = i;
    });
  }
}
