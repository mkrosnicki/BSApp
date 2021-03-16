import 'package:flutter/material.dart';

class NewComment extends StatefulWidget {
  @override
  _NewCommentState createState() => _NewCommentState();
}

class _NewCommentState extends State<NewComment> {

  var _enteredComment = '';

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
                  decoration: InputDecoration(labelText: 'Co myślisz o tej ofercie?', fillColor: Colors.white, filled: true,),
                  onChanged: (value) {
                    setState(() {
                      _enteredComment = value;
                    });
                  },
                ),
              ),
              FlatButton(
                onPressed: _enteredComment.trim().isEmpty ? null : () {

                },
                child: Text('Wyślij'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
