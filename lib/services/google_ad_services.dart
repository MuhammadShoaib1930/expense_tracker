import 'package:expense_tracker/core/helper/add_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdServices {
  GoogleAdServices() {
    _loadRewardedAd();
  }
  RewardedAd? rewardedAd;

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AddHelper.rewardedAdUnitId,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _loadRewardedAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint(error.message);
              ad.dispose();
              _loadRewardedAd();
            },
          );
        },
        onAdFailedToLoad: (error) {
          debugPrint(error.message);
        },
      ),

      request: AdRequest(),
    );
  }
}
