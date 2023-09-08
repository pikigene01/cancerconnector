import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

import '../json/json_app.dart';
import '../themes/styles.dart';
import '../widgets/app_fitted_text.dart';
import '../widgets/app_icon.dart';
import '../widgets/my_custom_button.dart';
import '../widgets/piki_app_ads.dart';
import '../widgets/requestDeliveryWidget.dart';

class ProductViewPage extends StatefulWidget {
  final product;
  const ProductViewPage({super.key, required this.product});

  @override
  State<ProductViewPage> createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  final LocalStorage storage = LocalStorage('liked');
  bool isLikedByUser = false;

  void saveToStorage(items) {
    storage.setItem('liked', items);
  }

  checkItem({required data}) async {
    var result = getItemslocal();
    if (result.length > 0) {
      var value = await result.any((item) => item['name'] == data['name']);
      setState(() {
        isLikedByUser = value;
      });
      return value;
    } else {
      setState(() {
        isLikedByUser = false;
      });
      return false;
    }
  }

  addItem({required data}) async {
    final item = {
      'name': data['name'],
      'userPhone': data['userPhone'],
      'img1': data['img1'],
      'userEmail': data['userEmail'],
      'location': data['location'],
      'productDescription': data['productDescription'],
      'longitude': data['location'],
      'productStatus': data['productStatus'],
      'price': data['price'],
      'latitude': data['latitude'],
      'img2': data['img2'],
      'category': data['category'],
      'timestamp': 'null',
    };
    var cheintoList = await checkItem(data: data);
    if (cheintoList) {
      var items = storage.getItem('liked') ?? [];
      await items.removeWhere((item) => item['img1'] == data['img1']);
      setState(() {
        isLikedByUser = false;
      });
      return;
    }
    var items = storage.getItem('liked') ?? [];
    items.add(item);
    saveToStorage(items);
  }

  getItemslocal() {
    return storage.getItem('liked') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    checkItem(data: widget.product);
    return Scaffold(
      body: getProductViewBody(),
    );
  }

  Widget getProductViewBody() {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            width: size.width,
            height: size.height / 2.4,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image:
                  CachedNetworkImageProvider(widget.product['img1'].toString()),
            )),
          ),
        ),
        Positioned(
          top: 40,
          left: 12,
          right: 23,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: const AppIcon(
                  icon: Icons.arrow_back_ios,
                ),
              ),
              InkWell(
                onTap: () {
                  addItem(data: widget.product);
                },
                child: isLikedByUser
                    ? const AppIcon(
                        icon: Icons.shopping_cart_outlined,
                      )
                    : const AppIcon(
                        icon: Icons.shopping_cart_checkout,
                        backgroundColor: Colors.yellowAccent,
                      ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: size.height / 2.41,
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                widget.product['img2'].toString() != ""
                    ? Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              widget.product['img2'].toString()),
                        )),
                      )
                    : Container(),
                Row(
                  children: [
                    PikiFittedText(
                      text: Text(
                        widget.product['name'].toString(),
                        style: appBigTitle,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const PikiFittedText(text: Text('Description: ')),
                    PikiFittedText(
                      text: Text(
                        widget.product['productDescription'].toString(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const PikiFittedText(text: Text('Price: ')),
                    PikiFittedText(
                      text: Text(
                        widget.product['price'].toString(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const PikiFittedText(text: Text('Category: ')),
                    PikiFittedText(
                      text: Text(
                        widget.product['category'].toString(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const PikiFittedText(text: Text('Location: ')),
                    PikiFittedText(
                      text: Text(
                        widget.product['location'].toString().length > 30
                            ? widget.product['location']
                                .toString()
                                .substring(0, 30)
                            : widget.product['location'],
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const PikiFittedText(text: Text('Status: ')),
                    PikiFittedText(
                      text: Text(
                        widget.product['productStatus'].toString(),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const PikiFittedText(text: Text('Item Created: ')),
                    // PikiFittedText(text: Text(
                    //   readTimestamp(int.parse(widget.product['timestamp']
                    //       .toString()
                    //       .replaceAll(RegExp(r'[^0-9]'), ''))),
                    widget.product['timestamp'].toString() == 'null'
                        ? Container()
                        : PikiFittedText(
                            text: Text(DateTime.parse(widget
                                    .product['timestamp']
                                    .toDate()
                                    .toString())
                                .toString())),
                  ],
                ),
                MyCustomBtn(
                  buttonText: 'Request a delivery to your door steps',
                  onTap: () {
                    requestDelivery(product: widget.product);
                  },
                ),
                const Center(child: cancerconnectorAds()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void requestDelivery({required product}) {
    showModalBottomSheet(
        constraints: BoxConstraints.loose(Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.9)),
        isScrollControlled: true,
        context: context,
        builder: (context) => RequestDeliveryWidget(
              product: product,
            ),
        // builder: (context) => MyProfile(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ));
  }
}
