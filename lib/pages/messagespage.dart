import 'package:cancerconnector/widgets/bottombar.dart';
import 'package:cancerconnector/widgets/topbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/_userBubble.dart';
import '../widgets/getSearch.dart';
import 'chat_view.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String searchValue = "";
  final _searchController = TextEditingController();
  void onTapFUnction() {
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomBar(index: 3),
      body: getBody(size: size),
    );
  }

  Widget getBody({required size}) {
    return SafeArea(
        child: Column(
      children: [
        topBar(pageTitle: "Messages", size: size),
        _buidUsers(),
      ],
    ));
  }

  Widget _buidUsers() {
    var size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading Users');
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: getSearchBarSearch(
                      size: size,
                      searchController: _searchController,
                      onTap: onTapFUnction),
                ),
                Column(
                  children: List.generate(snapshot.data!.docs.length, (index) {
                    return _builderUsersListItem(snapshot.data!.docs[index]);
                  }),
                ),
              ],
            ),
          );
        });
  }

  Widget _builderUsersListItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    var size = MediaQuery.of(context).size;

    //display all users except current user
    if (_auth.currentUser!.email != data['email']) {
      if (data['email'].toString().contains(searchValue)) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 9.0, bottom: 13, left: 10, right: 10),
                child: InkWell(
                  onTap: () {
                    Get.to(() => ChatViewPage(
                          receiverEmail: data['email'],
                          receiverUserId: data['uid'],
                        ));
                  },
                  child: userBubble(name: data['email'].toString(), size: size),
                ),
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }
}
