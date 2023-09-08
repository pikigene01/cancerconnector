import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../json/json_app.dart';
import '../services/geo_locator_service.dart';
import '../services/product_service.dart';
import '../themes/styles.dart';

import '../widgets/bottombar.dart';
import '../widgets/contact_dev.dart';
import '../widgets/piki_app_ads.dart';
import '../widgets/product.dart';
import '../widgets/search_bar.dart';
import '../widgets/swiper.dart';
import 'chat_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeMenu = 0;
  bool isSearching = false;
  final _productService = ProductService();
  final geoloocationService = GeoLocationService();

  String? addressFromLocation = "";
  String? longitude = "";
  String? latitude = "";
  String? country = "";
  bool locating = false;

  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollcontroller = ScrollController();

  void geoLocInit() async {
    setState(() {
      locating = true;
    });
    var geolocationResults = await geoloocationService.getLocationCoordinates();
    if (geolocationResults!['error'] == true) {
      var msg = geolocationResults['msg'] ?? '';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg.toString()),
        ),
      );
    }
    setState(() {
      longitude = geolocationResults!['longitude'].toString();
      latitude = geolocationResults!['latitude'].toString();
      addressFromLocation = geolocationResults!['address'].toString();
      country = geolocationResults!['country'].toString().toUpperCase();
      locating = false;
    });
  }

  // This is what you're looking for!
  void _scrollDown() {
    _scrollcontroller.animateTo(
      _scrollcontroller.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: const BottomBar(
        index: 0,
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return ListView(
      controller: _scrollcontroller,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(menus.length, (index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        activeMenu = index;
                      });
                      if (menus[index]
                          .toString()
                          .toLowerCase()
                          .contains('delive')) {
                        setState(() {
                          isSearching = false;
                        });
                      } else if (menus[index]
                          .toString()
                          .toLowerCase()
                          .contains('search')) {
                        setState(() {
                          isSearching = true;
                        });
                      } else if (menus[index]
                          .toString()
                          .toLowerCase()
                          .contains('contact')) {
                        Get.to(() => const ContactGenePiki());
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: activeMenu == index
                              ? Colors.black
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            top: 8,
                            right: 15,
                            bottom: 8,
                          ),
                          child: Row(
                            children: [
                              Text(
                                menus[index],
                                style: activeMenu == index
                                    ? appStyleText
                                    : appStyleTextActive,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          !isSearching
              ? getSearchBar(size: size)
              : getSearchBarSearch(
                  size: size,
                  searchController: _searchController,
                  onTap: () {
                    setState(() {});
                  },
                ),
          const SizedBox(
            height: 10,
          ),
          const Center(child: PikiDeliveryAds()),
          !isSearching ? appBannerSwiper() : Container(),
          const SizedBox(
            height: 20,
          ),
          _buildProductssList(width: size.width),
        ])
      ],
    );
  }

  Widget getSearchBar({required size}) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15),
          height: 45,
          width: size.width - 70,
          decoration: BoxDecoration(
            color: appTextColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: InkWell(
                  onTap: () {
                    geoLocInit();
                  },
                  child: Row(
                    children: [
                      locating
                          ? const FaIcon(
                              FontAwesomeIcons.location,
                              color: Colors.blue,
                            )
                          : const FaIcon(FontAwesomeIcons.location),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        country!.isNotEmpty
                            ? country.toString().length > 10
                                ? country.toString().substring(0, 10)
                                : country.toString()
                            : "Zimbabwe",
                        style: appStyleTextActive,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: InkWell(
                      onTap: () {
                        _scrollDown();
                      },
                      child: const Row(
                        children: [
                          FaIcon(FontAwesomeIcons.clock),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Scroll",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(width: 8),
                          FaIcon(FontAwesomeIcons.arrowDown),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductssList({required width}) {
    return StreamBuilder(
      stream: _productService.getProducts(latitude: '', longitude: ''),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Messages Loading please wait..');
        }
        return Column(
          children: List.generate(snapshot.data!.docs.length, (index) {
            return snapshot.data!.docs[index]['name']
                    .toString()
                    .toLowerCase()
                    .contains(_searchController.text.toString().toLowerCase())
                ? productItem(
                    width: width,
                    data: snapshot.data!.docs[index],
                    from: 'home',
                    onTap: () {})
                : Container();
          }),
        );
      },
    );
  }
}
