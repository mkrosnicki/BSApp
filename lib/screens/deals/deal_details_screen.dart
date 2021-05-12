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
import 'package:BSApp/widgets/deals/detal_details_new_comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class DealDetailsScreen extends StatefulWidget {
  static const routeName = '/deal-details';

  @override
  _DealDetailsScreenState createState() => _DealDetailsScreenState();
}

class _DealDetailsScreenState extends State<DealDetailsScreen> with TickerProviderStateMixin {

  AnimationController _colorAnimationController;
  AnimationController _textAnimationController;
  Animation _colorTween, _iconColorTween, _borderColorTween;
  Animation<Offset> _transTween;

  final PublishSubject<CommentModel> _commentToReplySubject = PublishSubject<CommentModel>();

  @override
  void dispose() {
    _commentToReplySubject.close();
    super.dispose();
  }

  @override
  void initState() {
    _colorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_colorAnimationController);
    _iconColorTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_colorAnimationController);
    _borderColorTween = ColorTween(
            begin: Colors.transparent, end: MyColorsProvider.GREY_BORDER_COLOR)
        .animate(_colorAnimationController);

    _textAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));

    _transTween = Tween(begin: Offset(-10, 40), end: Offset(-10, 0))
        .animate(_textAnimationController);

    super.initState();
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _colorAnimationController.animateTo(scrollInfo.metrics.pixels / 175);

      _textAnimationController.animateTo(
          (scrollInfo.metrics.pixels - 175) / 50);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final DealScreenArguments dealScreenArguments = ModalRoute.of(context).settings.arguments as DealScreenArguments;
    final DealModel deal = dealScreenArguments.deal;
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
              Container(
                height: 80,
                child: AnimatedBuilder(
                  animation: _colorAnimationController,
                  builder: (context, child) => AppBar(
                    leading: const AppBarBackButton(Colors.white),
                    automaticallyImplyLeading: false,
                    backgroundColor: _colorTween.value,
                    elevation: 0,
                    titleSpacing: 0.0,
                    centerTitle: true,
                    bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(4.0),
                        child: Container(
                          color: _borderColorTween.value,
                          height: 0.5,
                        ),),
                    title: Transform.translate(
                      offset: _transTween.value,
                      child: const Text(
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
