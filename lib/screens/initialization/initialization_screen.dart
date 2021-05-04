import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class InitializationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColorsProvider.BLUE,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ładowanie aplikacji',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 10),
              JumpingDotsProgressIndicator(
                fontSize: 60.0,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
