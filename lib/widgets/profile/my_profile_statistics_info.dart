import 'package:BSApp/models/user_details_model.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class MyProfileStatisticsInfo extends StatefulWidget {

  final UserDetailsModel user;

  const MyProfileStatisticsInfo(this.user);

  @override
  _MyProfileStatisticsInfoState createState() => _MyProfileStatisticsInfoState();
}

class _MyProfileStatisticsInfoState extends State<MyProfileStatisticsInfo> {
  static const statNameStyle = TextStyle(fontSize: 11, color: Colors.grey,);
  static const countStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w600, height: 1.2, color: MyColorsProvider.GREEN);

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 64.0, top: 4.0, bottom: 4.0),
      width: double.infinity,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatisticTile('punkty \nza okazje', widget.user.pointsForDeals.toString(), 1, false, true),
          _buildStatisticTile('polubione \nwypowiedzi', widget.user.likesCount.toString(), 2, false, true),
          _buildStatisticTile('wypowiedzi \ndziennie', widget.user.activityPerDay.toStringAsFixed(2), 3, false, false),
        ],
      ),
    );
  }

  Widget _buildStatisticTile(String label, String count, int index, bool borderLeft, bool borderRight) {
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
                style: countStyle,
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
