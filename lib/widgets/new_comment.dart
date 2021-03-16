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

  TextEditingController _commentController = new TextEditingController(text: '');

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      child: Material(
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(labelText: 'Co myślisz o tej ofercie?', fillColor: Colors.white, filled: true,),
                  onChanged: (value) {
                    setState(() {
                      _commentController.text = value;
                    });
                  },
                ),
              ),
              FlatButton(
                onPressed: _commentController.text.trim().isEmpty ? null : () {
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
    await Provider.of<Comments>(context, listen: false).addCommentToDeal(widget.dealId, _commentController.text);
    setState(() {
      _commentController.text = '';
      FocusScope.of(context).requestFocus(new FocusNode());
    });
  }
}
