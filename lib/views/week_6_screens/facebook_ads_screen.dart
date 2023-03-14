import 'package:facebook_audience_network/ad/ad_banner.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:native_ads_flutter/native_ads.dart';
import 'package:training_app/helpers/facebook_ad_helper.dart';
import 'package:training_app/helpers/google_ad_helper.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:training_app/views/week_6_screens/facebook_ads/facebook_banner_ad.dart';
import 'package:training_app/views/week_6_screens/facebook_ads/facebook_mid_rect_ad.dart';

class FacebookAdsScreen extends StatefulWidget {
  const FacebookAdsScreen({Key? key}) : super(key: key);

  @override
  State<FacebookAdsScreen> createState() => _FacebookAdsScreenState();
}

class _FacebookAdsScreenState extends State<FacebookAdsScreen> {
  Widget bannerAD = const SizedBox(
    height: 50,
    width: double.infinity,
    child: Center(
        child: Text(
      "Loading....",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
    )),
  );
  Widget midRectangleAD = const SizedBox(
    height: 250,
    width: double.infinity,
    child: Center(
        child: Text(
      "Loading....",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
    )),
  );
  Widget nativeAD = const SizedBox(
    height: 300,
    width: double.infinity,
    child: Center(
        child: Text(
      "Loading....",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
    )),
  );

  getData() {
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FaceBookADHelper.faceBookADHelper.initFacebookAD();
      Future.delayed(const Duration(seconds: 1)).then((value) {
        bannerAD = FaceBookADHelper.faceBookADHelper.banner();
        getData();
      });
      Future.delayed(const Duration(seconds: 2)).then((value) {
        midRectangleAD = FaceBookADHelper.faceBookADHelper.bannerMidRectangle();
        getData();
      });
      Future.delayed(const Duration(seconds: 3)).then((value) {
        nativeAD = FaceBookADHelper.faceBookADHelper.native();
        getData();
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
    return Scaffold(
      appBar: MyAppBar(title: "Facebook Ads"),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Divider(color: Colors.grey),
              const Text(
                "Banner AD",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const Divider(color: Colors.grey),
              const SizedBox(
                height: 10,
              ),
              // FBBannerView(),
              bannerAD,
              // FaceBookADHelper.faceBookADHelper.banner(),
              const SizedBox(
                height: 10,
              ),
              const Divider(color: Colors.grey),
              const SizedBox(
                height: 10,
              ),
              // FBMidRectangleView(),
              midRectangleAD,
              const SizedBox(
                height: 20,
              ),
              const Divider(color: Colors.grey),
              const Text(
                "Interstitial AD",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const Divider(color: Colors.grey),
              const SizedBox(
                height: 10,
              ),
              MyButton(
                  label: "Interstitial AD",
                  callback: () {
                    FaceBookADHelper.faceBookADHelper.interstitial();
                  }),
              const SizedBox(
                height: 10,
              ),
              const Divider(color: Colors.grey),
              const Text(
                "Rewarded AD",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const Divider(color: Colors.grey),
              const SizedBox(
                height: 10,
              ),
              MyButton(
                  label: "Rewarded AD",
                  callback: () {
                    FaceBookADHelper.faceBookADHelper.rewardedVideo();
                  }),
              const SizedBox(
                height: 10,
              ),
              const Divider(color: Colors.grey),
              const Text(
                "Native Advanced AD",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const Divider(color: Colors.grey),
              const SizedBox(
                height: 10,
              ),
              nativeAD,
            ],
          ),
        ),
      ),
    );
  }
}
