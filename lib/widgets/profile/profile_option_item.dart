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
            _preformAction(context);
          },
        ),
      ],
    );
  }

  void _preformAction(BuildContext context) async{
    var shouldNavigate = true;
    if (function != null) {
      shouldNavigate = await function();
    }
    if (shouldNavigate) {
      _navigateTo(context);
    }
  }

  _navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(route);
  }
}
