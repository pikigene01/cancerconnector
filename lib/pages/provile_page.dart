import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../themes/styles.dart';
import '../widgets/bottombar.dart';
import '../widgets/piki_app_ads.dart';
import '../widgets/pikiapp_link.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isAbout = false;
  bool isService = false;
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Info..."),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: const FaIcon(FontAwesomeIcons.signOut),
          ),
        ],
      ),
      body: getProfileBody(),
      bottomNavigationBar: const BottomBar(
        index: 2,
      ),
    );
  }

  Widget getProfileBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Center(child: cancerconnectorAds()),
            const SizedBox(
              height: 10,
            ),
            pikiappLink(
              text: 'Welcome to cancerconnector',
              width: size.width,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isAbout = !isAbout;
                  isService = false;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: pikiappLink(
                        text: 'About cancerconnector',
                        width: size.width - 20,
                        alignment: CrossAxisAlignment.start,
                        style: const TextStyle(
                            color: primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                  ),
                  const FaIcon(
                    FontAwesomeIcons.arrowDownShortWide,
                  ),
                ],
              ),
            ),
            isAbout
                ? const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'A place where you can find all of your deliveries right to your door steps.'),
                      Text(
                          'Piki Delivery App designed and mantained by Gene Piki to help companies and small scale retailers to manage their shipping items from one place toanother across international wide.'),
                      Text(
                        'Why Choose Us?',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Text(
                          'All deliveries are private meaning only you and buyer can know items which you are delivering. (boxed)'),
                      Text(
                        'How to upload your products?',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Text(
                          'click on icon from your bottom right corner and it will take you to your products and add products.'),
                      Text(
                        'Requirements to upload items as a company?',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Text(
                          'We need your device location where the product you want to publish is. (this helps buyers to choose in between their preferences from the location they are.)'),
                    ],
                  )
                : const Text(''),
            InkWell(
              onTap: () {
                setState(() {
                  isService = !isService;
                  isAbout = false;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: pikiappLink(
                        text: 'Services cancerconnector',
                        width: size.width - 20,
                        alignment: CrossAxisAlignment.start,
                        style: const TextStyle(
                            color: primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                  ),
                  const FaIcon(
                    FontAwesomeIcons.arrowDownShortWide,
                  ),
                ],
              ),
            ),
            isService
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text("1) We Offer and take a transport fee ",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400)),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                      const Text(
                        "2) Track moving delivery",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      const Text("3) Advertising of products",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400)),
                      const Text("3) Free Posting of Items",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400)),
                    ],
                  )
                : const Text(''),

            // pikiappLink(
            //     text: 'Settings',
            //     width: size.width,
            //     alignment: CrossAxisAlignment.start,
            //     style: const TextStyle(
            //         color: primaryColor,
            //         fontSize: 15,
            //         fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
