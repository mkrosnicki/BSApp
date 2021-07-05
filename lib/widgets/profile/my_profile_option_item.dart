import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProfileOptionItem extends StatelessWidget {
  final String title;
  final int number;
  final String route;
  final Function() function;
  final dynamic arguments;

  const MyProfileOptionItem({this.title, this.number, this.route, this.function, this.arguments});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0.0),
      child: FlatButton(
        padding: EdgeInsets.zero,
        shape: const Border(
            bottom: BorderSide(
                color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5)),
        onPressed: () {
          _preformAction(context);
        },
        child: ListTile(
          tileColor: Colors.white,
          title: Wrap(
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 12),
              ),
              if (number != null)
                Container(
                  decoration: BoxDecoration(
                    color: MyColorsProvider.SUPER_LIGHT_GREY,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin: const EdgeInsets.only(left: 6.0),
                  padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 4.0),
                  child: Text(
                    number.toString(),
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400),
                  ),
                ),
            ],
          ),
          trailing: const Icon(Icons.chevron_right),
          focusColor: Colors.grey,
        ),
      ),
    );
  }

  Future<void> _preformAction(BuildContext context) async {
    var shouldNavigate = true;
    if (function != null) {
      shouldNavigate = await function();
    }
    if (shouldNavigate) {
      _navigateTo(context);
    }
  }

  void _navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(route, arguments: arguments);
  }
}
