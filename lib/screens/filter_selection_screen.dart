import 'package:flutter/material.dart';

class FilterSelectionScreen extends StatelessWidget {

  _acceptFilters(BuildContext context) {
    Navigator.pop(context, 'jakas wartosc');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: RaisedButton(
            child: Text('ZWROC WARTOSC'),
            onPressed: () => _acceptFilters(context),
          ),
        ),
      ),
    );
  }
}
