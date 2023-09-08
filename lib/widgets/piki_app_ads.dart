import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class PikiDeliveryAds extends StatefulWidget {
  const PikiDeliveryAds({super.key});

  @override
  State<PikiDeliveryAds> createState() => _PikiDeliveryAdsState();
}

class _PikiDeliveryAdsState extends State<PikiDeliveryAds> {
  var adUnit = "ca-app-pub-2647169021297696/6055440446"; //real ad unit
  late BannerAd bannerAd;
  bool isLoaded = false;
  // var adUnit = "ca-app-pub-3940256099942544/6300978111";//test ad unit

  initBannerAds() {
    bannerAd = BannerAd(
        size: AdSize.largeBanner,
        adUnitId: adUnit,
        listener: BannerAdListener(
          onAdClicked: (ad) {},
          onAdLoaded: (ad) {
            setState(() {
              isLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            print(error.toString());
          },
        ),
        request: const AdRequest());

    bannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    initBannerAds();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isLoaded
            ? SizedBox(
                height: bannerAd.size.height.toDouble(),
                width: bannerAd.size.width.toDouble(),
                child: isLoaded ? AdWidget(ad: bannerAd) : Container())
            : const SizedBox(),
      ],
    );
  }
}
