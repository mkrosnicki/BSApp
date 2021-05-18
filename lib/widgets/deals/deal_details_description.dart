import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/custom_snackbar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DealDetailsDescription extends StatelessWidget {
  static const statNameStyle = TextStyle(fontSize: 11, color: Colors.grey);
  static const activeMenuItemStyle = TextStyle(fontSize: 11, color: Colors.black);

  final DealModel deal;

  const DealDetailsDescription(this.deal);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 8,
                  child: Text(
                    deal.title,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Text(
                    DateUtil.timeAgoString(deal.addedAt),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                '${deal.currentPrice.toString()} zł ',
                style: const TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '${deal.regularPrice} zł',
                style: const TextStyle(fontSize: 15, color: Colors.black54, decoration: TextDecoration.lineThrough),
              ),
            ],
          ),
          // Container(
          //   margin: const EdgeInsets.symmetric(vertical: 8.0),
          //   child: Column(
          //     children: [
          //       _simpleTile('Intenetowa', CupertinoIcons.location_solid),
          //       _simpleTile('Intenetowa', CupertinoIcons.location_solid),
          //       _simpleTile('Intenetowa', CupertinoIcons.location_solid),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                    'Opis',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(deal.description),
              ],
            ),
          ),
          if (deal.code != null)
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: const Text(
                'Kod rabatowy',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          if (deal.code != null)
            InkWell(
              onTap: () {
                Clipboard.setData(ClipboardData(text: deal.code));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 1),
                    backgroundColor: MyColorsProvider.BLUE,
                    content: SizedBox(
                      height: 22.0,
                      child: Stack(
                        children: const [
                          Icon(Icons.check, color: Colors.white),
                          Center(child: Text('Skopiowano do schowka')),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 8.0),
                width: double.infinity,
                child: DottedBorder(
                  color: MyColorsProvider.LIGHT_GRAY,
                  // color: Colors.deepOrange,
                  strokeWidth: 2,
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  dashPattern: const [5, 5],
                  child: Container(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        deal.code,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Container(
            margin: const EdgeInsets.only(top: 16.0, bottom: 14.0),
            child: const Text(
              'Dodatkowe informacje',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          Wrap(
            direction: Axis.horizontal,
            children: [
              _buildTile(),
              _buildTile(),
              _buildTile(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoTile(String title, String text, bool borderLeft, bool borderRight) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(right: 8.0),
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        border: Border(
            left: borderLeft
                ? const BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR)
                : const BorderSide(style: BorderStyle.none),
            right: borderRight
                ? const BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR)
                : const BorderSide(style: BorderStyle.none)),
      ),
      child: Wrap(
        direction: Axis.vertical,
        spacing: 0.5,
        children: [
          Text(
            title,
            style: statNameStyle,
          ),
          Text(
            text,
            style: activeMenuItemStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildTile() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: const Icon(CupertinoIcons.clock),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ważna od',
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
              const Text(
                '12.02.2020 14.02.2020',
                style: const TextStyle(
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _simpleTile(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Icon(
              icon,
              size: 14,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
