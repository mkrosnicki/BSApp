import 'package:BSApp/models/user_details_model.dart';
import 'package:BSApp/providers/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreenAdminActionsButton extends StatelessWidget {
  final UserDetailsModel user;
  final Function updateFunction;

  const UserScreenAdminActionsButton(this.user, this.updateFunction);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _openAdminActions(context),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(CupertinoIcons.ellipsis_vertical, size: 22, color: Colors.black),
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
              if (!user.isBanned) _buildListTile('Zablokuj na 24h', CupertinoIcons.lock_fill, () {
                _blockUserFor(context, const Duration(hours: 24));
              }),
              if (!user.isBanned) _buildListTile('Zablokuj na 72h', CupertinoIcons.lock_fill, () {
                _blockUserFor(context, const Duration(hours: 72));
              }),
              if (!user.isBanned) _buildListTile('Zablokuj na tydzień', CupertinoIcons.lock_fill, () {
                _blockUserFor(context, const Duration(days: 7));
              }),
              if (!user.isBanned) _buildListTile('Zablokuj na miesiąc', CupertinoIcons.lock_fill, () {
                _blockUserFor(context, const Duration(days: 30));
              }),
              if (user.isBanned) _buildListTile('Odblokuj', CupertinoIcons.lock_open_fill, () {
                _unblockUser(context);
              }),
            ],
          ),
        );
      },
    );
  }

  Future<void> _blockUserFor(final BuildContext context, final Duration duration) async {
    final DateTime bannedUntil = DateTime.now().add(duration).toUtc();
    await Provider.of<Users>(context, listen: false).updateUser(user.id, bannedUntil);
    Navigator.of(context).pop();
    updateFunction();
  }

  Future<void> _unblockUser(final BuildContext context) async {
    final DateTime bannedUntil = DateTime.now().subtract(const Duration(days: 1)).toUtc();
    await Provider.of<Users>(context, listen: false).updateUser(user.id, bannedUntil);
    Navigator.of(context).pop();
    updateFunction();
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
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}
