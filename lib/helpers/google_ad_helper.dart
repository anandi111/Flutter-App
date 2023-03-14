import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdMobHelper {
  GoogleAdMobHelper._();

  static final GoogleAdMobHelper googleADMobHelper = GoogleAdMobHelper._();

  InterstitialAd? interstitialAd;
  InterstitialAd? interstitialVideoAd;
  RewardedAd? rewardedAd;
  RewardedInterstitialAd? rewardedInterstitialAd;

  interstitial() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          // Keep a reference to the ad so you can show it later.
          interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  interstitialVideo() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/8691691433',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          // Keep a reference to the ad so you can show it later.
          interstitialVideoAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  rewarded() {
    RewardedAd.load(
      request: AdRequest(),
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  rewardedInterstitial() {
    RewardedInterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5354046379',
      request: AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          print('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          rewardedInterstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedInterstitialAd failed to load: $error');
        },
      ),
    );
  }
}
