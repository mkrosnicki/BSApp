import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/deals/deal_item_heart_button.dart';
import 'package:BSApp/widgets/deals/deal_item_share_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DealDetailsImage extends StatelessWidget {
  final DealModel deal;

  const DealDetailsImage(this.deal);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final double imageHeight = screenHeight * 0.35;
    return Stack(
      children: [
        Container(
          color: Colors.white,
          height: imageHeight + 20,
          width: double.infinity,
        ),
        SizedBox(
          height: imageHeight,
          width: double.infinity,
          child: _getImage(),
        ),
        Positioned(
          bottom: 0,
          right: 10,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                  color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5),
            ),
            child: DealItemHeartButton(deal, 30),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 65,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                  color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5),
            ),
            child: DealItemShareButton(deal, 30),
          ),
        ),
      ],
    );
  }

  Image _getImage() {
    if (deal.image != null) {
      return deal.image;
    } else if (deal.imagePath != null) {
      return Image.network(
        deal.imagePath,
        fit: BoxFit.cover,
      );
    } else {
      return Image.network(
        'https://cdn.arena.pl/7101c435b57786e6e21cb7939e95263f-product_lightbox.jpg',
        fit: BoxFit.cover,
      );
    }
  }
}
