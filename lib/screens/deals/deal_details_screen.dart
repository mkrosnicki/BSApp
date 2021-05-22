import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/models/deal_screen_arguments.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/deals/deal_details_actions.dart';
import 'package:BSApp/widgets/deals/deal_details_author.dart';
import 'package:BSApp/widgets/deals/deal_details_comments.dart';
import 'package:BSApp/widgets/deals/deal_details_description.dart';
import 'package:BSApp/widgets/deals/deal_details_image.dart';
import 'package:BSApp/widgets/deals/deal_screen_admin_actions_button.dart';
import 'package:BSApp/widgets/deals/detal_details_new_comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class DealDetailsScreen extends StatefulWidget {
  static const routeName = '/deal-details';

  @override
  _DealDetailsScreenState createState() => _DealDetailsScreenState();
}

class _DealDetailsScreenState extends State<DealDetailsScreen> with TickerProviderStateMixin {
  AnimationController _colorAnimationController;
  Animation<Color> _colorTween, _iconColorTween, _titleColorTween, _borderColorTween;

  final PublishSubject<CommentModel> _commentToReplySubject = PublishSubject<CommentModel>();

  @override
  void dispose() {
    _commentToReplySubject.close();
    super.dispose();
  }

  @override
  void initState() {
    _colorAnimationController = AnimationController(vsync: this, duration: Duration.zero);
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white).animate(_colorAnimationController);
    _iconColorTween = ColorTween(begin: Colors.white, end: Colors.black).animate(_colorAnimationController);
    _titleColorTween = ColorTween(begin: Colors.transparent, end: Colors.black).animate(_colorAnimationController);
    _borderColorTween = ColorTween(begin: Colors.transparent, end: MyColorsProvider.GREY_BORDER_COLOR)
        .animate(_colorAnimationController);
    super.initState();
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _colorAnimationController.animateTo(scrollInfo.metrics.pixels / 175);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final DealModel deal = ModalRoute.of(context).settings.arguments as DealModel;
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: _scrollListener,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DealDetailsImage(deal),
                          DealDetailsDescription(deal),
                          DealDetailsActions(deal),
                          DealDetailsAuthor(deal),
                          DealDetailsComments(deal, _commentToReplySubject),
                        ],
                      ),
                    ),
                  ),
                  DealDetailsNewComment(deal.id, _commentToReplySubject),
                ],
              ),
              AnimatedBuilder(
                animation: _colorAnimationController,
                builder: (context, child) {
                  return Container(
                    height: 70.0,
                    child: AppBar(
                      leading: AppBarBackButton(_iconColorTween.value),
                      automaticallyImplyLeading: false,
                      backgroundColor: _colorTween.value,
                      elevation: 0,
                      titleSpacing: 0.0,
                      centerTitle: true,
                      brightness: Brightness.light,
                      backwardsCompatibility: false,
                      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(4.0),
                        child: Container(
                          color: _borderColorTween.value,
                          height: 0.5,
                        ),
                      ),
                      actions: [
                        DealScreenAdminActionsButton(null, color: _iconColorTween.value),
                      ],
                      title: Text(
                        deal.title,
                        style: TextStyle(color: _titleColorTween.value, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      iconTheme: IconThemeData(
                        color: _iconColorTween.value,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
