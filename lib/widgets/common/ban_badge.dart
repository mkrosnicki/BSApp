import 'package:flutter/material.dart';

class BanBadge extends StatelessWidget {

  const BanBadge();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 100),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: const Text(
          'Zablokowany',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
