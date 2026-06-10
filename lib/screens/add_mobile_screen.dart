import 'package:expense_tracker/services/google_ad_services.dart';
import 'package:flutter/material.dart';

class AddMobileScreen extends StatefulWidget {
  final GoogleAdServices googleAdServices;
  const AddMobileScreen({super.key, required this.googleAdServices});

  @override
  State<AddMobileScreen> createState() => _AddMobileScreenState();
}

class _AddMobileScreenState extends State<AddMobileScreen> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      appBar: AppBar(title: Text("Add banner")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              if (widget.googleAdServices.rewardedAd != null) {
                widget.googleAdServices.rewardedAd?.show(onUserEarnedReward: (ad, reward) {});
              }
            },
            child: Text("reward"),
          ),
          ElevatedButton(
            onPressed: () {
              if (widget.googleAdServices.interstitialAd != null) {
                widget.googleAdServices.interstitialAd?.show();
              }
            },
            child: Text("interstitialAdd"),
          ),
          if (widget.googleAdServices.bannerAd != null) widget.googleAdServices.bannerAddwidget(),
        ],
      ),
    );
  }
}
