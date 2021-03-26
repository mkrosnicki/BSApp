import 'package:BSApp/providers/deal_reply_state.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/deals/deal_details_actions.dart';
import 'package:BSApp/widgets/deals/deal_details_comments.dart';
import 'package:BSApp/widgets/deals/deal_details_description.dart';
import 'package:BSApp/widgets/deals/deal_details_image.dart';
import 'package:BSApp/widgets/deals/detal_details_new_comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealDetailsScreen extends StatefulWidget {
  static const routeName = '/deal-details';

  @override
  _DealDetailsScreenState createState() => _DealDetailsScreenState();
}

class _DealDetailsScreenState extends State<DealDetailsScreen>
    with TickerProviderStateMixin {
  AnimationController _ColorAnimationController;
  AnimationController _TextAnimationController;
  Animation _colorTween, _iconColorTween, _borderColorTween;
  Animation<Offset> _transTween;

  @override
  void initState() {
    _ColorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_ColorAnimationController);
    _iconColorTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_ColorAnimationController);
    _borderColorTween = ColorTween(
            begin: Colors.transparent, end: MyColorsProvider.GREY_BORDER_COLOR)
        .animate(_ColorAnimationController);

    _TextAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));

    _transTween = Tween(begin: Offset(-10, 40), end: Offset(-10, 0))
        .animate(_TextAnimationController);

    super.initState();
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _ColorAnimationController.animateTo(scrollInfo.metrics.pixels / 175);

      _TextAnimationController.animateTo(
          (scrollInfo.metrics.pixels - 175) / 50);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dealId = ModalRoute.of(context).settings.arguments as String;
    final deal = Provider.of<Deals>(context, listen: false).findById(dealId);
    Provider.of<DealReplyState>(context, listen: false).resetLazy();
    return Scaffold(
      // appBar: AppBar(),
      body: NotificationListener<ScrollNotification>(
        onNotification: _scrollListener,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          padding: const EdgeInsets.all(0),
          // color: Colors.white,
          child: Stack(
            children: [
              Column(
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
              Container(
                height: 80,
                child: AnimatedBuilder(
                  animation: _ColorAnimationController,
                  builder: (context, child) => AppBar(
                    leading: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(CupertinoIcons.back),
                    ),
                    automaticallyImplyLeading: false,
                    backgroundColor: _colorTween.value,
                    elevation: 0,
                    titleSpacing: 0.0,
                    centerTitle: true,
                    bottom: PreferredSize(
                        child: Container(
                          color: _borderColorTween.value,
                          height: 0.5,
                        ),
                        preferredSize: Size.fromHeight(4.0)),
                    title: Transform.translate(
                      offset: _transTween.value,
                      child: Text(
                        'Szczegóły',
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    iconTheme: IconThemeData(
                      color: _iconColorTween.value,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
