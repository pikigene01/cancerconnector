import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../json/json_app.dart';

Widget appBannerSwiper() {
  return Swiper(
    itemBuilder: (BuildContext context, int index) {
      return Image.asset(
        menuSlides[index]["image"],
        fit: BoxFit.fill,
      );
    },
    itemCount: menuSlides.length,
    itemWidth: 300.0,
    itemHeight: 400.0,
    layout: SwiperLayout.TINDER,
  );
}
