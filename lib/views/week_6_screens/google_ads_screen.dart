import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:native_ads_flutter/native_ads.dart';
import 'package:training_app/helpers/google_ad_helper.dart';
import 'package:training_app/utils/appbar.dart';
import 'package:training_app/utils/buttons.dart';
import 'package:training_app/views/week_6_screens/google_ads/google_banner_ad.dart';
import 'package:training_app/views/week_6_screens/google_ads/google_native_ad.dart';
import 'package:training_app/views/week_6_screens/google_ads/google_native_video_ad.dart';

class GoogleAdsScreen extends StatefulWidget {
  const GoogleAdsScreen({Key? key}) : super(key: key);

  @override
  State<GoogleAdsScreen> createState() => _GoogleAdsScreenState();
}

class _GoogleAdsScreenState extends State<GoogleAdsScreen> {
  final nativeAdController = NativeAdmobController();
  int reward = 0;

  @override
  void initState() {
    GoogleAdMobHelper.googleADMobHelper.interstitial();
    GoogleAdMobHelper.googleADMobHelper.interstitialVideo();
    GoogleAdMobHelper.googleADMobHelper.rewarded();
    GoogleAdMobHelper.googleADMobHelper.rewardedInterstitial();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Google Ads"),
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
              // bannerAD,
              const GBannerView(),
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
                    if (GoogleAdMobHelper.googleADMobHelper.interstitialAd != null) {
                      GoogleAdMobHelper.googleADMobHelper.interstitial();
                      GoogleAdMobHelper.googleADMobHelper.interstitialAd!.show();
                    } else {
                      GoogleAdMobHelper.googleADMobHelper.interstitial();
                    }
                  }),
              MyButton(
                  label: "Interstitial Video AD",
                  callback: () {
                    if (GoogleAdMobHelper.googleADMobHelper.interstitialVideoAd != null) {
                      GoogleAdMobHelper.googleADMobHelper.interstitialVideo();
                      GoogleAdMobHelper.googleADMobHelper.interstitialVideoAd!.show();
                    } else {
                      GoogleAdMobHelper.googleADMobHelper.interstitialVideo();
                    }
                  }),
              const Divider(color: Colors.grey),
              const Text(
                "Rewarded Interstitial AD",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const Divider(color: Colors.grey),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Reward: $reward",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                  label: "Rewarded AD",
                  callback: () {
                    if (GoogleAdMobHelper.googleADMobHelper.rewardedAd != null) {
                      GoogleAdMobHelper.googleADMobHelper.rewarded();
                      GoogleAdMobHelper.googleADMobHelper.rewardedAd!.show(onUserEarnedReward: (val, _) {
                        setState(() {
                          if (_.amount.toInt() != null) {
                            reward = _.amount.toInt();
                            print(reward);
                          }
                        });
                      });
                    } else {
                      GoogleAdMobHelper.googleADMobHelper.rewarded();
                    }
                  }),
              // MyButton(
              //     label: "Rewarded Interstitial AD",
              //     callback: () {
              //       if (GoogleAdMobHelper.googleADMobHelper.rewardedInterstitialAd != null) {
              //         GoogleAdMobHelper.googleADMobHelper.rewardedInterstitial();
              //         GoogleAdMobHelper.googleADMobHelper.rewardedInterstitialAd!.show(onUserEarnedReward: (val, _) {});
              //       } else {
              //         GoogleAdMobHelper.googleADMobHelper.rewardedInterstitial();
              //       }
              //     }),
              const Divider(color: Colors.grey),
              const Text(
                "Native Advanced AD",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const Divider(color: Colors.grey),
              const SizedBox(
                height: 10,
              ),
              const GNativeView(),
              const SizedBox(
                height: 20,
              ),
              // const Divider(color: Colors.grey),
              // const Text(
              //   "Native Advanced Video AD",
              //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              // ),
              // const Divider(color: Colors.grey),
              // const SizedBox(
              //   height: 10,
              // ),
              // const GNativeVideoView(),
            ],
          ),
        ),
      ),
    );
  }
}
