import 'package:BSApp/providers/notifications.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClearNotificationsButton extends StatelessWidget {

  Function(bool) setLoadingState;

  ClearNotificationsButton(this.setLoadingState);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showSortingTypeSelector(context),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          CupertinoIcons.ellipsis_vertical,
          color: Colors.black,
        ),
      ),
    );
  }

  void _clearNotifications(BuildContext context) async {
    setLoadingState(true);
    await Provider.of<Notifications>(context, listen: false).deleteMyNotifications();
    setLoadingState(false);
    Navigator.of(context).pop();
  }

  void _markAllAsRead(BuildContext context) async {
    setLoadingState(true);
    Provider.of<Notifications>(context, listen: false).updateAllClickedAt();
    setLoadingState(false);
    Navigator.of(context).pop();
  }

  void _showSortingTypeSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // const Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Text('Akcje admina'),
              // ),
              _buildListTile('Oznacz jako przeczytane', CupertinoIcons.checkmark, () {
                _markAllAsRead(context);
              }),
              _buildListTile('Usuń wszystkkie', CupertinoIcons.delete, () {
                _clearNotifications(context);
              }),
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
        color: MyColorsProvider.DEEP_BLUE,
      ),
      onTap: function,
      title: Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
