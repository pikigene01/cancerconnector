import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pikideliveryapp/widgets/piki_app_ads.dart';
import 'package:url_launcher/url_launcher.dart';

import '../themes/styles.dart';
import 'bottombar.dart';

class ContactGenePiki extends StatefulWidget {
  const ContactGenePiki({super.key});

  @override
  State<ContactGenePiki> createState() => _ContactGenePikiState();
}

class _ContactGenePikiState extends State<ContactGenePiki> {
  void openDialPad(String phoneNumber) async {
    Uri url = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Unable to open call ${phoneNumber.toString()}',
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact: pikideliveryapp@gmail.com"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.mailchimp),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(
        index: 2,
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child: PikiDeliveryAds()),
          const SizedBox(
            height: 10,
          ),
          InkWell(
              onTap: () {
                openDialPad('+263782954717');
              },
              child: Text(
                'Phone: +263 782 954 717',
                style: appStyleTextActive,
              )),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Email: pikideliveryapp@gmail.com',
            style: appStyleTextActive,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
