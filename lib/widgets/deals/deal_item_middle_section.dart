import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class DealItemMiddleSection extends StatelessWidget {
  static const statNameStyle = TextStyle(fontSize: 11, color: Colors.grey);
  static const activeMenuItemStyle = TextStyle(fontSize: 11, color: Colors.black);

  final DealModel deal;

  const DealItemMiddleSection(this.deal);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoTile('Lokalizacja', deal.locationString, false, true),
        _infoTile('Dodana', DateUtil.timeAgoString(deal.addedAt), false, false),
      ],
    );
  }

  Widget _infoTile(String title, String text, bool borderLeft, bool borderRight) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(right: 8.0),
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        border: Border(
            left: borderLeft
                ? const BorderSide(
                    color: MyColorsProvider.GREY_BORDER_COLOR)
                : const BorderSide(style: BorderStyle.none),
            right: borderRight
                ? const BorderSide(
                    color: MyColorsProvider.GREY_BORDER_COLOR)
                : const BorderSide(style: BorderStyle.none)),
      ),
      child: Wrap(
        direction: Axis.vertical,
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
    );
  }
}
