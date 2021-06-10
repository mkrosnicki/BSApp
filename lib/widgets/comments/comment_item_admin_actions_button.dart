import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentItemAdminActionsButton extends StatelessWidget {
  final CommentModel comment;

  const CommentItemAdminActionsButton(this.comment);

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
              _buildListTile('Usuń komentarz', CupertinoIcons.clear, () {
                _deleteComment(context);
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
      ),
      onTap: function,
      title: Text(
        title,
        style: const TextStyle(fontSize: 13),
      ),
    );
  }

  Future<void> _deleteComment(BuildContext context) async {
    await Provider.of<Comments>(context, listen: false).deleteComment(comment);
    Navigator.of(context).pop();
  }
}
