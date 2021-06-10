import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/form_field_divider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppScreen extends StatelessWidget {
  static const routeName = '/about-app';

  static const TextStyle titleStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black);
  static const TextStyle valueStyle =
      TextStyle(fontSize: 15, color: MyColorsProvider.DEEP_BLUE, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        leading: AppBarBackButton(Colors.black),
        title: 'O aplikacji',
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(12.0),
        width: double.infinity,
        child: Column(
          children: [
            const FormFieldDivider(),
            const Text(
              'Wersja aplikacji',
              style: titleStyle,
            ),
            const FormFieldDivider(),
            const Text(
              '0.9',
              style: valueStyle,
            ),
            const FormFieldDivider(),
            const FormFieldDivider(),
            const FormFieldDivider(),
            const Text(
              'Ikony pochodzą ze strony',
              style: titleStyle,
            ),
            const FormFieldDivider(),
            InkWell(
              onTap: () => _launchURL('https://www.pngrepo.com'),
              child: const Text(
                'PNG Repo',
                style: valueStyle,
              ),
            ),
          ],
        ),
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
