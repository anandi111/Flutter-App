import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GNativeView extends StatefulWidget {
  const GNativeView({Key? key}) : super(key: key);

  @override
  State<GNativeView> createState() => _GNativeViewState();
}

class _GNativeViewState extends State<GNativeView> {
  NativeAd? nativeAd;
  bool isLoaded = false;

  @override
  void initState() {
    nativeAd = NativeAd(
        adUnitId: "ca-app-pub-3940256099942544/2247696110",
        factoryId: "listTile",
        listener: NativeAdListener(
          onAdLoaded: (Ad ad) {
            setState(() {
              isLoaded = true;
            });
          },
        ),
        request: const AdRequest());

    nativeAd!.load();
    super.initState();
  }

  @override
  void dispose() {
    nativeAd!.dispose().then((value) => null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 20.0),
            height: 70,
            child: AdWidget(ad: nativeAd!..load()),
          )
        : Container(
            height: 70,
            alignment: Alignment.center,
            child: const Text(
              "Loading....",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
            ),
          );
  }
}
