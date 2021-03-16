import 'package:flutter/material.dart';

class ProfileOptionItem extends StatelessWidget {
  final String title;
  final String route;

  ProfileOptionItem(this.title, this.route);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlatButton(
          child: ListTile(
            title: Text(title),
            trailing: Icon(Icons.chevron_right),
            focusColor: Colors.grey,
          ),
          onPressed: () => _navigateTo(context),
        ),
      ],
    );
  }

  _navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(route);
  }
}
