import 'package:BSApp/widgets/profile_option_item.dart';
import 'package:flutter/material.dart';

class ProfileOptionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> widgets = List.generate(10, (index) => 'Option number $index');
    return Flexible(
      child: ListView.builder(
        itemBuilder: (context, index) =>
            ProfileOptionItem(widgets[index], widgets[index]),
        itemCount: 10,
      ),
    );
  }
}
