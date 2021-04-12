import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'deal_details_screen.dart';

class DealItemImageSection extends StatelessWidget {
  final String dealId;

  DealItemImageSection(this.dealId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(DealDetailsScreen.routeName, arguments: dealId);
      },
      child: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            height: 130,
            width: double.infinity,
          ),
          Container(
            height: 130,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.0),
                bottomLeft: Radius.circular(4.0),
              ),
              child: Image.network(
                'https://cdn.arena.pl/7101c435b57786e6e21cb7939e95263f-product_lightbox.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Positioned(
          //   top: 0.0,
          //   left: 0.0,
          //   child: Container(
          //     clipBehavior: Clip.hardEdge,
          //     padding: EdgeInsets.all(4.0),
          //     // color: Theme.of(context).accentColor,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(20.0),
          //       border: Border.all(color: Colors.grey),
          //       color: Colors.black26,
          //     ),
          //     constraints: BoxConstraints(
          //       minWidth: 100,
          //       minHeight: 14,
          //     ),
          //     child: Center(child: Icon(CupertinoIcons.hand_thumbsup, size: 18.0, color: Colors.white,),),
          //   ),
          // ),
        ],
      ),
    );
  }
}
