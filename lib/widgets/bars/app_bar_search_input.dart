import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarSearchInput extends StatefulWidget {
  final Function onTapInputFunction;
  final Function onSubmitInputFunction;
  final TextEditingController searchInputController;

  AppBarSearchInput(
      {this.onTapInputFunction,
      this.onSubmitInputFunction,
      this.searchInputController});

  @override
  _AppBarSearchInputState createState() => _AppBarSearchInputState();
}

class _AppBarSearchInputState extends State<AppBarSearchInput> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        onTap: widget.onTapInputFunction,
        onSubmitted: widget.onSubmitInputFunction,
        controller: widget.searchInputController,
        keyboardType: TextInputType.text,
        autofocus: false,
        cursorColor: Colors.black87,
        style: TextStyle(
          color: Colors.black87,
        ),
        decoration: InputDecoration(
            prefixIcon: Icon(CupertinoIcons.search, color: Colors.black54,),
            prefixIconConstraints: BoxConstraints.tight(
              Size.square(25),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(8),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              gapPadding: 5,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              gapPadding: 5,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            hintText: 'Czego szukasz?',
            hintStyle: TextStyle(fontSize: 14,),
            isDense: true,
            filled: true,
            fillColor: Color.fromRGBO(240, 240, 240, 1),
            focusColor: Color.fromRGBO(227, 227, 227, 1),
        ),
      ),
    );
  }
}
