import 'package:flutter/material.dart';

class ProfileOptionItem extends StatelessWidget {
  final String title;
  final String route;
  final Function function;

  const ProfileOptionItem({this.title, this.route, this.function});

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
          onPressed: () {
            if (function != null) {
              function();
            }
            _navigateTo(context);
          },
        ),
      ],
    );
  }

  _navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(route);
  }
}
