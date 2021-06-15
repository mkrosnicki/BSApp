import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String label;
  final Function() function;
  final double fontSize;
  final Color color;
  final IconData icon;

  const SocialButton(this.label, this.icon, this.color, this.function, {this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)),
        elevation: MaterialStateProperty.all(0.0),
      ),
      onPressed: function,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: fontSize ?? 22,
            // color: Colors.green,
            child: Center(
              child: Text(
                label,
                style: TextStyle(fontSize: fontSize ?? 13),
              ),
            ),
          ),
          Icon(
            icon,
            size: 22,
          ),
        ],
      ),
    );
  }
}
