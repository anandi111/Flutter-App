import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:training_app/helpers/facebook_ad_helper.dart';

class FBMidRectangleView extends StatefulWidget {
  const FBMidRectangleView({Key? key}) : super(key: key);

  @override
  State<FBMidRectangleView> createState() => _FBMidRectangleViewState();
}

class _FBMidRectangleViewState extends State<FBMidRectangleView> {
  FacebookBannerAd? midRectangleAd;
  bool isLoaded = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      midRectangleAd = FacebookBannerAd(
        placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
        bannerSize: BannerSize.MEDIUM_RECTANGLE,
        listener: (result, value) {
          switch (result) {
            case BannerAdResult.LOADED:
              print("Loaded: $value");
              break;
            case BannerAdResult.ERROR:
              print("Error: $value");
              break;
            case BannerAdResult.CLICKED:
              print("Clicked: $value");
              break;
            case BannerAdResult.LOGGING_IMPRESSION:
              print("Logging Impression: $value");
              break;
          }
        },
      );

      setState(() {
        isLoaded = true;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? Container(
            height: 250,
            alignment: const Alignment(0.5, 1),
            child: midRectangleAd,
          )
        : Container(
            height: 250,
            alignment: Alignment.center,
            child: const Text(
              "Loading....",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
            ),
          );
  }
}
