import 'package:BSApp/providers/comments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewComment extends StatefulWidget {

  final String dealId;

  NewComment(this.dealId);

  @override
  _NewCommentState createState() => _NewCommentState();
}

class _NewCommentState extends State<NewComment> {

  var _commentText = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: 'Co myślisz o tej ofercie?', fillColor: Colors.white, filled: true,),
                  onChanged: (value) {
                    setState(() {
                      _commentText = value;
                    });
                  },
                ),
              ),
              FlatButton(
                onPressed: _commentText.trim().isEmpty ? null : () {
                  _addCommentToDeal();
                },
                child: Text('Wyślij'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addCommentToDeal() async {
    await Provider.of<Comments>(context, listen: false).addCommentToDeal(widget.dealId, _commentText);
    setState(() {
      _commentText = '';
      FocusScope.of(context).requestFocus(new FocusNode());
    });
  }
}
