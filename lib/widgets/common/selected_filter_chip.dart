import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectedFilterChip extends StatelessWidget {

  final String label;
  final Function onTapFunction;
  final Function onDeleteFunction;

  SelectedFilterChip({this.label, this.onTapFunction, this.onDeleteFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
      padding: EdgeInsets.all(4.0),
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 2.0, top: 1.0, bottom: 2.0),
              child: Text(
                label,
                style: const TextStyle(fontSize: 10),
              ),
            ),
            onTap: onTapFunction != null ? onTapFunction : () {},
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 2.0, bottom: 2.0),
              child: Icon(
                CupertinoIcons.clear,
                size: 12,
                color: Colors.grey,
              ),
            ),
            onTap: onDeleteFunction != null ? onDeleteFunction : () {},
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: MyColorsProvider.BACKGROUND_COLOR,
        borderRadius: BorderRadius.all(
          Radius.circular(
            12.0,
          ),
        ),
      ),
    );
  }
}
