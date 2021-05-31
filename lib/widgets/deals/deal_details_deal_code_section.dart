import 'package:BSApp/util/my_colors_provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DealDetailsDealCodeSection extends StatelessWidget {

  final String dealCode;

  const DealDetailsDealCodeSection(this.dealCode);

  @override
  Widget build(BuildContext context) {
    return dealCode != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: const Text(
                  'Kod rabatowy',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: dealCode));
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0),
                    dashPattern: const [5, 5],
                    child: Container(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          dealCode,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container();
  }
}
