import 'package:BSApp/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostItemAdminActionsButton extends StatelessWidget {
  final PostModel post;

  const PostItemAdminActionsButton(this.post);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _openAdminActions(context),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: Icon(CupertinoIcons.ellipsis_vertical, size: 16, color: Colors.grey),
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
              _buildListTile('Usuń post', CupertinoIcons.clear, () {}),
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
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}
