import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class DealItemMiddleSection extends StatelessWidget {
  static const statNameStyle = TextStyle(fontSize: 11, color: Colors.grey);
  static const activeMenuItemStyle =
      TextStyle(fontSize: 11, color: Colors.black);

  final DealModel deal;

  DealItemMiddleSection(this.deal);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatisticTile('Lokalizacja', 'Intetnet', false, true),
          _buildStatisticTile('Dodana',
              '${DateUtil.timeAgoString(deal.addedAt)}', false, false),
        ],
      ),
    );
  }

  _buildStatisticTile(
      String title, String text, bool borderLeft, bool borderRight) {
    return Container(
      // width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(right: 8.0),
      margin: const EdgeInsets.only(right: 8.0),
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 0.5,
        children: [
          Text(
            title,
            style: statNameStyle,
          ),
          Text(
            text,
            style: activeMenuItemStyle,
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border(
            left: borderLeft
                ? const BorderSide(
                    color: MyColorsProvider.GREY_BORDER_COLOR, width: 1)
                : const BorderSide(style: BorderStyle.none),
            right: borderRight
                ? const BorderSide(
                    color: MyColorsProvider.GREY_BORDER_COLOR, width: 1)
                : const BorderSide(style: BorderStyle.none)),
      ),
    );
  }
}
