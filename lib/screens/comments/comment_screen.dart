import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/models/deal_screen_arguments.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/deals/deal_details_screen.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatelessWidget {
  static const routeName = '/comment-screen';

  @override
  Widget build(BuildContext context) {
    final CommentScreenArguments commentScreenArguments =
        ModalRoute.of(context).settings.arguments as CommentScreenArguments;
    final String dealId = commentScreenArguments.dealId;
    final String commentToScrollId = commentScreenArguments.commentToScrollId;
    final CommentModel comment = commentScreenArguments.comment;

    return Scaffold(
      appBar: BaseAppBar(
        title: 'Odpowiedź na komentarz',
      ),
    );
  }

  void _navigateToDeal(BuildContext context, String dealId) {
    final dealsProvider = Provider.of<Deals>(context, listen: false);
    dealsProvider.fetchDeal(dealId).then((_) {
      final DealModel deal = dealsProvider.findById(dealId);
      Navigator.of(context).pushNamed(DealDetailsScreen.routeName, arguments: deal);
    });
  }
}
