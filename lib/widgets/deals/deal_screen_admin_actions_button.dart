import 'package:BSApp/models/deal_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DealScreenAdminActionsButton extends StatelessWidget {
  final DealModel deal;
  final Color color;

  const DealScreenAdminActionsButton(this.deal, {this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _openAdminActions(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          CupertinoIcons.ellipsis_vertical,
          size: 22,
          color: color ?? Colors.black,
        ),
      ),
    );
  }

  void _openAdminActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Akcje admina'),
              ),
              _buildListTile('Usuń okazję', CupertinoIcons.clear, () {}),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListTile(String title, IconData icon, Function() function) {
    return ListTile(
      leading: Icon(
        icon,
        size: 18,
      ),
      onTap: function,
      title: Text(
        title,
        style: TextStyle(fontSize: 13),
      ),
    );
  }
}
