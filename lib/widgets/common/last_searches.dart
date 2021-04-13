import 'package:flutter/material.dart';

import 'last_search_item.dart';

class LastSearches extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) => LastSearchItem(index),
      itemCount: 5,
    );
  }

// Center(
// child: Text('Brak ostatnich wyszukiwań'),
// )
}
