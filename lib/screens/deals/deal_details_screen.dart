import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/deal_reply_state.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/authentication/login_registration_screen.dart';
import 'package:BSApp/screens/users/user_profile_screen.dart';
import 'package:BSApp/widgets/deals/deal_details_actions.dart';
import 'package:BSApp/widgets/deals/deal_details_comments.dart';
import 'package:BSApp/widgets/deals/deal_details_description.dart';
import 'package:BSApp/widgets/deals/deal_details_image.dart';
import 'package:BSApp/widgets/deals/detal_details_new_comment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealDetailsScreen extends StatefulWidget {
  static const routeName = '/deal-details';

  @override
  _DealDetailsScreenState createState() => _DealDetailsScreenState();
}

class _DealDetailsScreenState extends State<DealDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final dealId = ModalRoute.of(context).settings.arguments as String;
    final deal = Provider.of<Deals>(context, listen: false).findById(dealId);
    Provider.of<DealReplyState>(context, listen: false).resetLazy();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        padding: const EdgeInsets.all(0),
        // color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DealDetailsImage(dealId),
                    DealDetailsDescription(deal),
                    DealDetailsActions(deal),
                    DealDetailsComments(deal),
                  ],
                ),
              ),
            ),
            Consumer<DealReplyState>(
              builder: (context, replyState, child) {
                ReplyState currentReplyState = replyState.replyState;
                String commentId = replyState.commentId;
                return currentReplyState != ReplyState.NONE
                    ? DealDetailsNewComment(
                        dealId, currentReplyState, commentId)
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
