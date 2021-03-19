import 'package:flutter/material.dart';

class ErrorInfo extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.network('https://img.icons8.com/ios/150/000000/error--v3.png'),
          Text('Wystąpił błąd podczas komunikacji z serwerem!'),
        ],
      ),
    );
  }
}
