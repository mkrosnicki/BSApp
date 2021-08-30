import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/services/dynamic_link_service.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class DealItemShareButton extends StatelessWidget {
  final DealModel deal;
  final double iconSize;

  const DealItemShareButton(this.deal, this.iconSize);

  @override
  Widget build(BuildContext context) {
    final DynamicLinkService dynamicLinkService = DynamicLinkService();
    return FutureBuilder<Uri>(
        future: dynamicLinkService.createDynamicLink(deal.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Uri uri = snapshot.data;
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => Share.share(uri.toString()),
              child: Icon(CupertinoIcons.share, size: iconSize, color: MyColorsProvider.DEEP_BLUE),
            );
          } else {
            return Icon(CupertinoIcons.share, size: iconSize, color: MyColorsProvider.DEEP_BLUE);
          }
        });
  }
}
