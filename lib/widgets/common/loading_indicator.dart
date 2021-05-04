import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LoadingIndicator extends StatelessWidget {

  const LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return JumpingDotsProgressIndicator(
      fontSize: 60.0,
      color: MyColorsProvider.DEEP_BLUE,
    );
  }
}
