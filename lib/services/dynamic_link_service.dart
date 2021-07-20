import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/deals/deal_details_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:BSApp/screens/profile/no_resource_screen.dart';

class DynamicLinkService {
  Future<void> retrieveDynamicLink(BuildContext context) async {
    try {
      final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri deepLink = data?.link;

      DealModel deal;
      if (deepLink != null) {
        final String dealId = deepLink.queryParameters['dealId'];
        final dealsProvider = Provider.of<Deals>(context, listen: false);
        dealsProvider.fetchDeal(dealId).then((_) {
          deal = dealsProvider.findById(dealId);
          Navigator.of(context).pushNamed(DealDetailsScreen.routeName, arguments: deal);
        });
      }

      FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData dynamicLink) async {
        final String dealId = dynamicLink.link.queryParameters['dealId'];
        final dealProvider = Provider.of<Deals>(context, listen: false);
        dealProvider.fetchDeal(dealId).then((_) {
          try {
            final deal = dealProvider.findById(dealId);
            if (deal != null) {
              Navigator.of(context).pushNamed(DealDetailsScreen.routeName, arguments: deal);
            }
          } catch (e) {
            Navigator.of(context).pushNamed(NoResourceScreen.routeName);
          }
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Uri> createDynamicLink(final String id) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://bobify.page.link',
      link: Uri.parse('https://bobify.page.link/deal?dealId=$id'),
      androidParameters: AndroidParameters(
        packageName: 'com.mkrosnicki.bobify',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.mkrosnicki.bobify',
        minimumVersion: '1',
        appStoreId: '123456789',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
          title: 'Bobify',
          description: 'Zobacz okazję',
      ),
    );
    final Uri dynamicUrl = await parameters.buildUrl();
    final shortLink = await parameters.buildShortLink();
    return shortLink.shortUrl;
  }
}
