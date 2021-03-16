import 'package:flutter/material.dart';

class FilterSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtry i sortowanie'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: RaisedButton(
                child: Text('Akceptuj'),
                onPressed: () => _acceptFilters(context),
              ),
            ),
          ),
          Card(
            elevation: 10,
            margin: EdgeInsets.zero,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: RaisedButton(
                child: Text('Filtruj'),
                onPressed: () => _acceptFilters(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _acceptFilters(BuildContext context) {
    Navigator.pop(context, 'jakas wartosc');
  }
}
