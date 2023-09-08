import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cancerconnector/services/chat_service.dart';

import '../widgets/chat_bubble.dart';
import '../widgets/piki_app_ads.dart';

class ChatViewPage extends StatefulWidget {
  final String? receiverEmail;
  final String? receiverUserId;
  const ChatViewPage(
      {super.key, required this.receiverEmail, required this.receiverUserId});

  @override
  State<ChatViewPage> createState() => _ChatViewPageState();
}

class _ChatViewPageState extends State<ChatViewPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ScrollController _scrollcontroller = ScrollController();

  // This is what you're looking for!
  void _scrollDown() {
    _scrollcontroller.animateTo(
      _scrollcontroller.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserId.toString(), _messageController.text);
      //clear message after sending message
      _messageController.clear();
      _scrollDown();
    }
  }

  @override
  Widget build(BuildContext context) {
    var receiverEmail = widget.receiverEmail;
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail.toString()),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              _scrollDown();
            },
            icon: const FaIcon(FontAwesomeIcons.arrowDown),
          ),
        ],
      ),
      body: getBody(),
      // bottomNavigationBar: bottomSendField(),
    );
  }

  Widget getBody() {
    return Column(
      children: [
        const Center(child: cancerconnectorAds()),
        const SizedBox(
          height: 4,
        ),
        Expanded(child: _buildMessagesList()),
        bottomSendField(),
      ],
    );
  }

  Widget bottomSendField() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: TextFormField(
        controller: _messageController,
        decoration: InputDecoration(
          hintText: 'message',
          prefixIcon: InkWell(
            onTap: () {
              sendMessage();
            },
            child: const Icon(Icons.send),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessagesList() {
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverUserId.toString(),
          _firebaseAuth.currentUser!.uid.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Messages Loading please wait..');
        }

        return ListView(
          controller: _scrollcontroller,
          children: snapshot.data!.docs
              .map((document) => _buildMessagesListItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessagesListItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    var aligment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: aligment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            const SizedBox(
              height: 5,
            ),
            ChatBubble(
              message: data['message'].toString(),
            ),
          ],
        ),
      ),
    );
  }
}
