import 'package:expense_tracker/core/helper/add_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdServices {
  GoogleAdServices() {
    _interstitialAd();
    _loadBannerAd();
    _loadRewardedAd();
  }
  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;
  void _loadBannerAd() {
    BannerAd(
      size: AdSize.banner,
      adUnitId: AddHelper.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAd = ad as BannerAd;
        },
        onAdFailedToLoad: (ad, error) {
          print(error.message.toString());
          ad.dispose();
        },
      ),
      request: AdRequest(),
    ).load();
  }

  Widget bannerAddwidget() {
    if (bannerAd == null) return SizedBox();
    return SizedBox(
      width: bannerAd!.size.width.toDouble(),
      height: bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: bannerAd!),
    );
  }

  void _interstitialAd() {
    InterstitialAd.load(
      adUnitId: AddHelper.interstitialAdUnitId,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitialAd();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _interstitialAd();
            },
          );
        },
        onAdFailedToLoad: (error) {
          print(error.message.toString());
        },
      ),
      request: AdRequest(),
    );
  }

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
              ad.dispose();
              _loadRewardedAd();
            },
          );
        },
        onAdFailedToLoad: (error) {
          print(error.message.toString());
        },
      ),

      request: AdRequest(),
    );
  }
}
