// ignore_for_file: unused_result

import 'dart:io';


import 'package:chat_gpt/provider/home_screen_provider.dart';
import 'package:chat_gpt/services/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/ad_helper.dart';
import 'database.dart';


class Admob {
  int? reward;
  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;
  static const AdRequest request = AdRequest(
    nonPersonalizedAds: true,
  );



  //Video ads
  void createRewardedAd() async{
    String rewardedId = AdHelper.rewardedAdUnitId;
    String? adId = await DataBase().retrieveString("admob");
    RewardedAd.load(
        adUnitId: adId ?? AdHelper.rewardedAdUnitId,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            print("slfdhnvikgfvsfd");
            if (_numRewardedLoadAttempts < 5) {
              createRewardedAd();
            }
          },
        ));
  }
  void showRewardedAd({required WidgetRef ref}) {
    if (_rewardedAd == null) {
      toast('Please wait till loaded');
      createRewardedAd();
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) {
        toast('Showing ads');
      },
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        ad.dispose();
        createRewardedAd();
      },
    );
    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) async{
          try{
            EasyLoading.show(status: 'Getting rewards');
            var response = await ApiService().addCredit('10', 'Admob Video Ads');
              EasyLoading.showSuccess(response.message ?? "Added");
              ref.refresh(profileProvider);
              ref.refresh(earnProvider);
            } catch(e){
            EasyLoading.showError(e.toString());
          }

        });
    _rewardedAd = null;
  }
}