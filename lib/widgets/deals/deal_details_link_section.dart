import 'package:BSApp/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DealDetailsLinkSection extends StatelessWidget {
  final String link;

  const DealDetailsLinkSection(this.link);

  @override
  Widget build(BuildContext context) {
    return link != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 24.0),
                child: const Text(
                  'Link do okazji',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 30.0,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 4.0),
                child: PrimaryButton(
                  'Skorzystaj',
                      () {
                    _launchURL(link);
                  },
                  fontSize: 13,
                ),
              ),
            ],
          )
        : Container();
  }

  Future _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(Uri.encodeFull(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
