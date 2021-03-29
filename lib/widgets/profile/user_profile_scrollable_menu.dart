import 'package:flutter/material.dart';

class UserProfileScrollableMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return                   Container(
      height: 40,
      color: Colors.white,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Dodane okazje'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Dodane komentarze'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Posty na forum'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Placeholder 1'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Placeholder 2'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
