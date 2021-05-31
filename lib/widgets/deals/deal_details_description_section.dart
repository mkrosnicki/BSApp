import 'package:flutter/material.dart';

class DealDetailsDescriptionSection extends StatelessWidget {

  final String description;

  const DealDetailsDescriptionSection(this.description);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              'Opis',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          Text(description),
        ],
      ),
    );
  }
}
