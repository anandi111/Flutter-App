import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class DynamicLinkServiceHelper {
  DynamicLinkServiceHelper._();
  static final DynamicLinkServiceHelper dynamicLinkServiceHelper = DynamicLinkServiceHelper._();

  Future<String> createLink() async {
    DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://weapplinse.page.link?ref=efcodd"),
      uriPrefix: "https://weapplinse.page.link",
      androidParameters: const AndroidParameters(packageName: "com.weapplinse.anandi.training_app"),
    );

    ShortDynamicLink dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
      dynamicLinkParams,
      shortLinkType: ShortDynamicLinkType.short,
    );

    return dynamicLink.shortUrl.toString();
  }

  Future<String> createPageLink() async {
    DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://weapplinse.page.link?page=week_9_page"),
      uriPrefix: "https://weapplinse.page.link",
      androidParameters: const AndroidParameters(packageName: "com.weapplinse.anandi.training_app"),
    );

    ShortDynamicLink dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
      dynamicLinkParams,
      shortLinkType: ShortDynamicLinkType.short,
    );

    return dynamicLink.shortUrl.toString();
  }

  Future<void> initialLink(BuildContext context) async {
    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      final Uri deepLink = initialLink.link;

      print(deepLink);

      if (deepLink.queryParameters["page"] == "week_9_page") {
        Navigator.of(context).pushNamed("week_9_page");
      }
    }
  }
}
