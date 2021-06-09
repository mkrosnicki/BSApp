import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DealDetailsLinkSection extends StatelessWidget {
  final String dealCode;

  const DealDetailsLinkSection(this.dealCode);

  @override
  Widget build(BuildContext context) {
    return dealCode != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: const Text(
                  'Link do okazji',
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
                  height: 30.0,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 3.0),
                  child: PrimaryButton(
                    'Skorzystaj',
                    () {},
                    fontSize: 13,
                  ),
                ),
                // child: Container(
                //   width: double.infinity,
                //   padding: const EdgeInsets.symmetric(
                //       vertical: 8.0, horizontal: 12.0),
                //   child: Center(
                //     child: Text(
                //       dealCode,
                //       style: const TextStyle(fontSize: 14),
                //     ),
                //   ),
                // ),
              ),
            ],
          )
        : Container();
  }
}
