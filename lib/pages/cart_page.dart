import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import 'package:cancerconnector/pages/provile_page.dart';
import 'package:cancerconnector/widgets/liked.dart';

import '../models/product_model.dart';
import '../themes/styles.dart';
import '../widgets/bottombar.dart';
import '../widgets/piki_app_ads.dart';
import '../widgets/product.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final LocalStorage storage = LocalStorage('liked');
  var items = [];

  getItemslocal() async {
    setState(() {
      items = storage.getItem('liked') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    getItemslocal();
    // Map<String, dynamic> data = storage.getItem('key');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liked Items"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const ProfilePage());
            },
            icon: const FaIcon(FontAwesomeIcons.home),
          ),
        ],
      ),
      body: getBody(items: items),
      bottomNavigationBar: const BottomBar(
        index: 1,
      ),
    );
  }

  Widget getBody({required items}) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: cancerconnectorAds()),
              const SizedBox(
                height: 20,
              ),
              items.length <= 0
                  ? Center(
                      child: Text('You haven\'t liked any item...',
                          style: appBigTitle),
                    )
                  : _buildProductssList(width: size.width, items: items),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductssList({required width, required items}) {
    if (items.length < 0) {
      return Center(
        child: Text('You haven\' liked any item...', style: appBigTitle),
      );
    } else {
      return Column(
        children: List.generate(items.length, (index) {
          return likedItem(
            width: width,
            data: items[index],
            onTap: () {
              items.removeWhere((item) => item['img1'] == items[index]['img1']);
              setState(() {
                getItemslocal();
              });
            },
          );
        }),
      );
    }
  }
}
