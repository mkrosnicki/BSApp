import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoResourceScreen extends StatelessWidget {
  static const routeName = '/no-resource';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        leading: AppBarBackButton(Colors.black),
        title: 'Błąd',
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(CupertinoIcons.exclamationmark_triangle, color: Colors.black54, size: 28,),
            ),
            Text(
              'Ten zasób już nie istnieje!',
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
