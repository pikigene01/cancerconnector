import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import '../models/local_storage_product.dart';
import '../models/product_model.dart';
import '../pages/product_view.dart';
import '../themes/styles.dart';
import 'app_fitted_text.dart';

class likedItem extends StatefulWidget {
  final data;
  final void Function()? onTap;
  final double width;
  const likedItem(
      {super.key,
      required this.width,
      required this.data,
      required this.onTap});

  @override
  State<likedItem> createState() => _likedItemState();
}

class _likedItemState extends State<likedItem> {
  final LocalStorage storage = LocalStorage('liked');
  bool isLikedByUser = false;
  var items = [];

  List itemsUpdated = [];

  void saveToStorage(items) {
    storage.setItem('liked', items);
  }

  checkItem({required data}) {
    var result = getItemslocal();
    if (result.length > 0) {
      var value = result.any((item) => item['name'] == data['name']);
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
    var cheintoList = checkItem(data: data);
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
    return InkWell(
      onTap: () {
        Get.to(() => ProductViewPage(
              product: widget.data,
            ));
      },
      child: SizedBox(
        width: widget.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: widget.width,
                    height: 160,
                    child: widget.data['img1'].toString().isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: widget.data['img1'],
                            width: widget.width,
                            fit: BoxFit.cover,
                          )
                        : Container(),
                  ),
                  Positioned(
                    bottom: 15,
                    right: 15,
                    child: InkWell(
                      onTap: () {
                        // getItemslocal();
                        addItem(data: widget.data);
                        checkItem(data: widget.data);
                      },
                      child: InkWell(
                        onTap: widget.onTap,
                        child: const FaIcon(
                          FontAwesomeIcons.trash,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              PikiFittedText(text: Text(widget.data['name'].toString())),
              const SizedBox(
                height: 8,
              ),
              const Row(children: [
                PikiFittedText(text: Text('Sponsored')),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.info,
                  color: Colors.grey,
                ),
              ]),
              const SizedBox(
                height: 8,
              ),
              PikiFittedText(
                text: Text(
                  widget.data['location'],
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(3),
                      child: Icon(
                        Icons.hourglass_bottom,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: PikiFittedText(
                        text: Text(
                          widget.data['productStatus'],
                          style: appStyleTextActive,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
