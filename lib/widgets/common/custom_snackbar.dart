import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {

  final String text;
  const CustomSnackBar(this.text);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: MyColorsProvider.BLUE,
      content: SizedBox(
        height: 22.0,
        child: Stack(
          children: [
            const Icon(Icons.check, color: Colors.white),
            Center(child: Text(text)),
          ],
        ),
      ),
    );
  }
}
