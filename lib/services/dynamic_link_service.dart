import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService {

  Future<Uri> createDynamicLink() async {
    print('DUPA');
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://babybook.page.link',
      link: Uri.parse('https://babybook.page.link/deal'),
      androidParameters: AndroidParameters(
        packageName: 'com.mk.bb',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.mk.bb',
        minimumVersion: '1',
        appStoreId: '123456789',
      ),
    );
    print('DUPADUPADUPADUPADUPADUPA');
    var dynamicUrl = await parameters.buildShortLink();
    final Uri shortUrl = dynamicUrl.shortUrl;
    return shortUrl;
  }

}