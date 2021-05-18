import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/widgets/deals/deal_rate_bar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DealItemBottomSection extends StatelessWidget {
  final DealModel deal;

  const DealItemBottomSection(this.deal);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.bottomLeft,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: DealRateBar(deal.id),
          ),
          Flexible(
            child: (deal.link != null)
                ? InkWell(
                    onTap: () => _launchURL(deal.link),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: const Text(
                        'ZOBACZ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }

  Future _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(Uri.encodeFull(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
