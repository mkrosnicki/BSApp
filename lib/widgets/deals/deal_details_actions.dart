import 'package:BSApp/models/comment-mode.dart';
import 'package:flutter/material.dart';

class DealDetailsActions extends StatelessWidget {

  final Function setCommentModeFunction;

  DealDetailsActions(this.setCommentModeFunction);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionItem('Lubię to', Icons.thumb_up, () {}),
                _buildActionItem('Skomentuj', Icons.mode_comment_outlined, () => setCommentModeFunction(CommentMode.COMMENT_DEAL)),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  _buildActionItem(String title, IconData iconData, Function function) {
    return GestureDetector(
      onTap: function,
      child: Container(
        child: Row(
          children: [
            Icon(iconData, size: 18,),
            Container(
              padding: EdgeInsets.only(left: 4.0),
              child: Text(title, style: TextStyle(fontSize: 14,)),
            ),
          ],
        ),
      ),
    );
  }
}
