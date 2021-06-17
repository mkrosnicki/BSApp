import 'dart:io';

import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_indicators/progress_indicators.dart';

class InitializationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !Platform.isIOS ? AppBar(
        toolbarHeight: 0.0,
        elevation: 0.0,
      ) : null,
      backgroundColor: MyColorsProvider.BLUE,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Image.asset(
                'assets/images/logo2.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: 10),
            JumpingDotsProgressIndicator(
              fontSize: 60.0,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
