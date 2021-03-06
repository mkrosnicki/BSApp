import 'package:BSApp/util/my_styling_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarSearchInput extends StatefulWidget {
  final Function() onTapInputFunction;
  final Function(String) onSubmitInputFunction;
  final TextEditingController searchInputController;

  const AppBarSearchInput(
      {this.onTapInputFunction,
      this.onSubmitInputFunction,
      this.searchInputController});

  @override
  _AppBarSearchInputState createState() => _AppBarSearchInputState();
}

class _AppBarSearchInputState extends State<AppBarSearchInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        onTap: widget.onTapInputFunction,
        controller: widget.searchInputController,
        onSubmitted: widget.onSubmitInputFunction,
        keyboardType: TextInputType.text,
        style: const TextStyle(fontSize: 12),
        autofocus: true,
        decoration: MyStylingProvider.TEXT_FIELD_DECORATION.copyWith(
          hintText: 'Czego szukasz?',
          prefixIcon: const Padding(
            padding: EdgeInsets.all(0.0),
            child: Icon(
              CupertinoIcons.search,
              color: Colors.black87,
              size: 15,
            ),
          ),
          prefixIconConstraints: BoxConstraints.tight(
            const Size.square(30),
          ),
        ),
      ),
    );
  }
}
