import 'package:flutter/material.dart';

class VotingButton extends StatelessWidget {
  final IconData iconData;
  final Function() function;
  final String trailing;
  final bool isActive;
  final bool showBorder;
  final double fontSize;
  final bool isBold;
  final Color color;
  final Color backgroundColor;

  const VotingButton({this.iconData, this.function, this.trailing, this.isActive = false, this.color, this.showBorder = true, this.fontSize = 11.0, this.isBold = false, this.backgroundColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    final textColor = color != null && isActive ? Colors.black : Colors.grey;
    return SizedBox(
      height: 20,
      child: ElevatedButton(
        style: ButtonStyle(
          alignment: Alignment.center,
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          elevation: MaterialStateProperty.all(0.0),
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0)),
          minimumSize: MaterialStateProperty.all<Size>(const Size(4.0, 8.0)),
        ),
        onPressed: function,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Icon(iconData, size: 15, color: textColor),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(trailing,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: textColor,
                    )),
              ),
          ],
        ),
      ),
    );
  }
}
