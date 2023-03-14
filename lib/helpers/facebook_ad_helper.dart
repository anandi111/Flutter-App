import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';

class FaceBookADHelper {
  FaceBookADHelper._();
  static final FaceBookADHelper faceBookADHelper = FaceBookADHelper._();

  initFacebookAD() {
    FacebookAudienceNetwork.init(
      testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6",
    );
  }

  Widget banner() {
    return Container(
      height: 50,
      alignment: const Alignment(0.5, 1),
      child: FacebookBannerAd(
        placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
        bannerSize: BannerSize.STANDARD,
        listener: (result, value) {
          switch (result) {
            case BannerAdResult.ERROR:
              print("Error: $value");
              break;
            case BannerAdResult.LOADED:
              print("Loaded: $value");
              break;
            case BannerAdResult.CLICKED:
              print("Clicked: $value");
              break;
            case BannerAdResult.LOGGING_IMPRESSION:
              print("Logging Impression: $value");
              break;
          }
        },
      ),
    );
  }

  Widget bannerMidRectangle() {
    return Container(
      height: 250,
      alignment: const Alignment(0.5, 1),
      child: FacebookBannerAd(
        placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
        bannerSize: BannerSize.MEDIUM_RECTANGLE,
        listener: (result, value) {
          switch (result) {
            case BannerAdResult.ERROR:
              print("Error: $value");
              break;
            case BannerAdResult.LOADED:
              print("Loaded: $value");
              break;
            case BannerAdResult.CLICKED:
              print("Clicked: $value");
              break;
            case BannerAdResult.LOGGING_IMPRESSION:
              print("Logging Impression: $value");
              break;
          }
        },
      ),
    );
  }

  interstitial() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED) {
          print("Interstitial is loaded.....");
          FacebookInterstitialAd.showInterstitialAd();
        }
        if (result == InterstitialAdResult.DISMISSED) {
          print("Interstitial is dismissed.....");
        }
      },
    );
  }

  rewardedVideo() async {
    await FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "VID_HD_16_9_15S_LINK#YOUR_PLACEMENT_ID",
      listener: (result, value) {
        if (result == RewardedVideoAdResult.LOADED) {
          FacebookRewardedVideoAd.showRewardedVideoAd(delay: 50);
        }
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE) {
          print("Video completed");
        }
      },
    );
  }

  Widget native() {
    return SizedBox(
      height: 300,
      child: FacebookNativeAd(
        placementId: "CAROUSEL_IMG_SQUARE_APP_INSTALL#YOUR_PLACEMENT_ID",
        adType: NativeAdType.NATIVE_AD,
        width: double.infinity,
        height: 245,
        bannerAdSize: NativeBannerAdSize.HEIGHT_120,
        backgroundColor: Colors.blue,
        titleColor: Colors.white,
        descriptionColor: Colors.white,
        buttonColor: Colors.green,
        buttonTitleColor: Colors.white,
        buttonBorderColor: Colors.black,
        listener: (result, value) {
          print("Native Ad: $result --> $value");
        },
      ),
    );
  }
}
