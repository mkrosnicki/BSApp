
import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/comments/comment_with_replies_item.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealDetailsComments extends StatefulWidget {
  final String dealId;

  const DealDetailsComments(this.dealId);

  @override
  _DealDetailsCommentsState createState() => _DealDetailsCommentsState();
}

class _DealDetailsCommentsState extends State<DealDetailsComments> {

  bool _isLoading = true;
  List<CommentModel> _comments = [];

  Future<void> _initComments(BuildContext context) async {
    final Comments comments = Provider.of<Comments>(context, listen: false);
    await comments.fetchCommentsForDeal(widget.dealId);
    _comments = comments.parentComments;
    setState(() {
      _isLoading = false;
    });
  }


  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _initComments(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        height: 300,
        color: Colors.white,
        child: const Center(child: LoadingIndicator()),
      );
    } else {
      return Column(
        children: [
          Consumer<Comments>(
            builder: (context, commentsData, child) {
              if (_comments.isEmpty) {
                return _noOneAddedACommentSplash();
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: _comments.length + 1,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 12.0, bottom: 8.0, left: 12.0, right: 6.0),
                        margin: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Komentarze',
                          style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      );
                    } else {
                      final CommentModel parentComment = _comments[index - 1];
                      final List<CommentModel> subComments = Provider.of<Comments>(context, listen: false).getSubCommentsOf(parentComment.id);
                      return CommentWithRepliesItem(widget.dealId, parentComment, subComments);
                    }
                  },
                );
              }
            },
          ),
        ],
      );
    }
  }

  Widget _noOneAddedACommentSplash() {
    return Container(
      height: 200,
      color: Colors.white,
      child: const Center(
        child: Text(
          'Nikt jeszcze nie dodał komentarza',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: MyColorsProvider.LIGHT_GRAY),
        ),
      ),
    );
  }
}
