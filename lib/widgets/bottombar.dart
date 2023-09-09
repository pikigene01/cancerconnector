import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../json/json_app.dart';
import '../pages/home_page.dart';
import '../themes/styles.dart';

class BottomBar extends StatefulWidget {
  final int index;
  const BottomBar({super.key, required this.index});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int bottomBarindex = 2;
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: primaryColor,
      height: 60,
      index: widget.index,
      items: List.generate(menusRoutes.length, (index) {
        String menuIcon = menusRoutes[index]['icon'];
        Widget? icon;
        if (menuIcon.contains('solidCompass')) {
          icon = const FaIcon(
            FontAwesomeIcons.solidCompass,
            size: 27,
            color: Colors.white,
          );
        } else if (menuIcon.contains('heart')) {
          icon = const FaIcon(
            FontAwesomeIcons.heart,
            size: 27,
            color: Colors.white,
          );
        } else if (menuIcon.contains('user')) {
          icon = const FaIcon(
            FontAwesomeIcons.user,
            size: 27,
            color: Colors.white,
          );
        } else if (menuIcon.contains('Message')) {
          icon = const FaIcon(
            FontAwesomeIcons.solidMessage,
            size: 27,
            color: Colors.white,
          );
        } else if (menuIcon.contains('sliders')) {
          icon = const FaIcon(
            FontAwesomeIcons.sliders,
            size: 27,
            color: Colors.white,
          );
        }
        return Container(
          child: icon,
        );
      }),
      backgroundColor: Colors.transparent,
      animationDuration: const Duration(
        milliseconds: 200,
      ),
      animationCurve: Curves.bounceInOut,
      onTap: (index) {
        if (menusRoutes[index]['page'].toLowerCase().contains('messages')) {
          Get.to(() => null);
        } else if (menusRoutes[index]['page']
            .toLowerCase()
            .contains('location')) {
          Get.to(() => const HomePage());
        } else if (menusRoutes[index]['page'].toLowerCase().contains('liked')) {
          Get.to(() => null);
        } else if (menusRoutes[index]['page']
            .toLowerCase()
            .contains('profile')) {
          Get.to(() => null);
        } else if (menusRoutes[index]['page']
            .toLowerCase()
            .contains('settings')) {
          Get.to(() => null);
        }

        setState(() {
          bottomBarindex = widget.index;
        });
      },
    );
  }
}
