import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GNativeVideoView extends StatefulWidget {
  const GNativeVideoView({Key? key}) : super(key: key);

  @override
  State<GNativeVideoView> createState() => _GNativeVideoViewState();
}

class _GNativeVideoViewState extends State<GNativeVideoView> {
  NativeAd? nativeAd;
  bool isLoaded = false;

  @override
  void initState() {
    RequestConfiguration configuration = RequestConfiguration(testDeviceIds: ["33BE2250B43518CCDA7DE426D04EE231"]);
    MobileAds.instance.updateRequestConfiguration(configuration);

    nativeAd = NativeAd(
        adUnitId: "ca-app-pub-3940256099942544/1044960115",
        factoryId: "video",
        listener: NativeAdListener(
          onAdFailedToLoad: (Ad ad, _) {
            print(_);
            print("entered");
            print("entered");
            print("entered");
            print("entered");
            print("entered");
            print("entered");
            print("entered");
            print("entered");
            print("entered");
          },
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
            height: 200,
            child: AdWidget(ad: nativeAd!..load()),
          )
        : Container(
            height: 200,
            alignment: Alignment.center,
            child: const Text(
              "Loading....",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
            ),
          );
  }
}
