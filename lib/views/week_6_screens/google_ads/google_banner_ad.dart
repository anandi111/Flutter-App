import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GBannerView extends StatefulWidget {
  const GBannerView({Key? key}) : super(key: key);

  @override
  State<GBannerView> createState() => _GBannerViewState();
}

class _GBannerViewState extends State<GBannerView> {
  BannerAd? bannerAd;
  bool isLoaded = false;

  @override
  void initState() {
    bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          isLoaded = true;
        });
      }),
    );

    bannerAd!.load();
    super.initState();
  }

  @override
  void dispose() {
    bannerAd!.dispose().then((value) => null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 20.0),
            height: 60,
            child: AdWidget(ad: bannerAd!..load()),
          )
        : Container(
            height: 50,
            alignment: Alignment.center,
            child: const Text(
              "Loading....",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
            ),
          );
  }
}
