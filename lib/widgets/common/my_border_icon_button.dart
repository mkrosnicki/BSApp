import 'package:flutter/material.dart';

class MyBorderIconButton extends StatelessWidget {
  final String label;
  final IconData iconData;
  final Function() function;
  final String trailing;
  final bool isActive;
  final bool showBorder;
  final double fontSize;
  final bool isBold;
  final Color color;
  final Color backgroundColor;

  const MyBorderIconButton({this.label, this.iconData, this.function, this.trailing, this.isActive = false, this.color, this.showBorder = true, this.fontSize = 11.0, this.isBold = false, this.backgroundColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    final borderColor = color != null && isActive ? color : const Color.fromRGBO(212, 227, 235, 1);
    final textColor = color != null && isActive ? color : Colors.grey;
    return SizedBox(
      height: 25,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          side: MaterialStateProperty.all<BorderSide>(
            showBorder ? BorderSide(color: borderColor) : const BorderSide(style: BorderStyle.none)
          ),
          elevation: MaterialStateProperty.all(0.0),
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0)),
          alignment: Alignment.center,
          minimumSize: MaterialStateProperty.all<Size>(const Size(10, 25)),
        ),
        onPressed: function,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (label != null)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  label,
                  style: TextStyle(
                      fontSize: fontSize, color: textColor, letterSpacing: 0.1, fontWeight: isBold ? FontWeight.w600 : FontWeight.w500),
                ),
              ),
            if (iconData != null)
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(iconData, size: 15, color: textColor),
              ),
            if (trailing != null)
              Padding(
                padding: const EdgeInsets.all(2.0),
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
