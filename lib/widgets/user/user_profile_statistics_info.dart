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
  static const activeMenuItemStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: MyColorsProvider.GREEN);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: const EdgeInsets.only(left: 90.0, top: 4.0, bottom: 4.0),
      child: Flex(
        direction: Axis.horizontal,
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
      child: Container(
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
    );
  }
}
