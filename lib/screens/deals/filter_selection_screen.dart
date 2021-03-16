import 'package:flutter/material.dart';

class FilterSelectionScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 10,),
      body: SafeArea(
        child: SingleChildScrollView(
          child: RaisedButton(
            child: Text('Akceptuj'),
            onPressed: () => _acceptFilters(context),
          ),
        ),
      ),
    );
  }

  _acceptFilters(BuildContext context) {
    Navigator.pop(context, 'jakas wartosc');
  }
}
