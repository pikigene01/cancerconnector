import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import '../pages/product_view.dart';
import '../themes/styles.dart';
import 'app_fitted_text.dart';

Widget productRequestItem(
    {required double width, required data, required void Function()? onTap}) {
  final LocalStorage storage = LocalStorage('liked');
  final items = storage.getItem('liked');
  List itemsUpdated = [];
  // if (items.length > 0) {
  //   Map<String, dynamic> dataStorage = storage.getItem('liked');
  //   itemsUpdated.add(dataStorage);
  // }
  // Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  return SizedBox(
    width: width,
    child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: width,
                height: 160,
                child: data['img1'].toString() != "null" ||
                        data['img1'].toString().isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: data['img1'],
                        width: width,
                        fit: BoxFit.cover,
                      )
                    : Container(),
              ),
              Positioned(
                bottom: 15,
                right: 15,
                child: InkWell(
                  onTap: () {},
                  child: InkWell(
                    onTap: onTap,
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
          // PikiFittedText(
          //   text: Text(data['name'].toString()),
          // ),
          const SizedBox(
            height: 8,
          ),
          const Row(children: [
            PikiFittedText(
              text: Text('This is a request '),
            ),
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
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Row(
              children: [
                const PikiFittedText(
                  text: Text('Request coming from: '),
                ),
                PikiFittedText(
                  text: Text(
                    data['location'],
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
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
                      data['productStatus'],
                      style: appStyleTextActive,
                    ),
                  ),
                ),
              ),
            ],
          ),
          PikiFittedText(
              text: Text(
            'Contact Details',
            style: appBigTitle,
          )),
          const Divider(
            height: 10,
            color: primaryColor,
          ),
          PikiFittedText(
              text: Text(
            'Phone: ${data['userPhone']}',
          )),
          PikiFittedText(
              text: Text(
            'Email: ${data['userEmail']}',
          )),
          PikiFittedText(
              text: Text(
            'Requested User price to pay:\$ ${data['price']}',
          )),
          PikiFittedText(
              text: Text(
            'Time Requested :\$ ${data['timestamp'].toDate().toString()}',
          )),
          const PikiFittedText(
              text: Text(
            'End of this request',
          )),
          const Divider(
            height: 10,
            color: primaryColor,
          ),
        ],
      ),
    ),
  );
}
