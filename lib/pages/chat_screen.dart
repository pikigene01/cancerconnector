import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../pages/chat_view.dart';

import '../widgets/bottombar.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/search_bar.dart';

class ChatScreen extends StatefulWidget {
  final String? title;
  const ChatScreen({super.key, this.title});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();
  String searchValue = "";

  void onTapFUnction() {
    setState(() {
      searchValue = _searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Chats"),
        backgroundColor: Colors.black,
      ),
      body: _builderUserList(),
      bottomNavigationBar: const BottomBar(
        index: 3,
      ),
    );
  }

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.only(left: 5),
                onPressed: () {
                  Get.back();
                },
                icon: const FaIcon(FontAwesomeIcons.xmark),
                iconSize: 25,
              ),
              const Text(
                "Chat",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _builderUserList() {
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
                  child: ChatBubble(
                    message: data['email'].toString(),
                  ),
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
