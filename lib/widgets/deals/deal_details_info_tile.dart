import 'package:flutter/material.dart';

class DealDetailsInfoTile extends StatelessWidget {

  final String title;
  final String subtitle;
  final String assetPath;

  const DealDetailsInfoTile(this.title, this.subtitle, this.assetPath);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 8.0),
            child: SizedBox(
              width: 28.0,
              child: Image.asset(
                assetPath,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 11, color: Colors.grey, height: 1.5),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
