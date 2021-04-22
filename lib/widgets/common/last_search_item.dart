import 'package:BSApp/models/filter_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LastSearchItem extends StatelessWidget {
  final FilterSettings filterSettings;

  LastSearchItem(this.filterSettings);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Text(
                  'Wyszukiwanie numer ${filterSettings}'.substring(0, 20),
                  style:
                      const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                'Wyszukiwanie numer ${filterSettings}'.substring(0, 20),
                style: const TextStyle(fontSize: 12, color: Colors.black54,),
              ),
            ],
          ),
          Icon(
            CupertinoIcons.clear,
            size: 16,
          ),
        ],
      ),
    );
  }
}
