import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class MyBorderIconButton extends StatelessWidget {
  final String label;
  final IconData iconData;
  final Function function;
  final String trailing;
  final bool isActive;
  final Color color;

  MyBorderIconButton({this.label, this.iconData, this.function, this.trailing, this.isActive = false, this.color});

  @override
  Widget build(BuildContext context) {
    // var borderColor = isActive ? Colors.blue : Color.fromRGBO(212, 227, 235, 1);
    var borderColor = color != null && isActive ? color : Color.fromRGBO(212, 227, 235, 1);
    var textColor = color != null && isActive ? color : Colors.grey;
    // var textColor = Colors.blue;
    // Color.fromRGBO(40, 167, 69, 1)
    return SizedBox(
      height: 25,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(color: borderColor, width: 0.8, style: BorderStyle.solid)
          ),
          elevation: MaterialStateProperty.all(0.0),
          padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0)),
          alignment: Alignment.center,
          minimumSize: MaterialStateProperty.all<Size>(Size(10, 25)),
        ),
        onPressed: function,
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (label != null)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  label,
                  style: TextStyle(
                      fontSize: 11, color: textColor, letterSpacing: 0.1, fontWeight: FontWeight.w400),
                ),
              ),
            if (iconData != null)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(iconData, size: 12, color: textColor),
              ),
            if (trailing != null)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(trailing,
                    style: TextStyle(
                      fontSize: 11,
                      color: textColor,
                    )),
              ),
          ],
        ),
      ),
    );
  }
}
