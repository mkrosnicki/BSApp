import 'package:BSApp/providers/deal_reply_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealDetailsActions extends StatelessWidget {

  DealDetailsActions();

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
                _buildActionItem(
                  'Skomentuj',
                  Icons.mode_comment_outlined,
                  () => Provider.of<DealReplyState>(context, listen: false).startDealReply(),
                ),
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
            Icon(
              iconData,
              size: 18,
            ),
            Container(
              padding: EdgeInsets.only(left: 4.0),
              child: Text(title,
                  style: TextStyle(
                    fontSize: 14,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
