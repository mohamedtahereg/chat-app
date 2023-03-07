import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do/model/message.dart';

import '../model/chatbuble.dart';
import '../model/textfield.dart';

class HomePage extends StatelessWidget {
  CollectionReference users = FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: users.orderBy("createdAt", descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJosn(snapshot.data!.docs[i]));
          }
          print(snapshot.data!.docs[1]['message']);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff274460),
              title: const Text("Scolar chat"),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? chat_bubble(
                              message: messagesList[index],
                            )
                          : chat_bubbleForFriend(message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      users.add({
                        "message": data,
                        "createdAt": DateTime.now(),
                        "id": email,
                      });
                      controller.clear();
                      _controller.animateTo(
                          _controller.position.minScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn);
                    },
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                    cursorColor: const Color(0xff274460),
                    decoration: InputDecoration(
                      focusColor: const Color(0xff274460),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xff274460),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xff274460),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xff274460),
                        ),
                      ),
                      label: const Text(
                        "chat",
                        style: TextStyle(fontSize: 17),
                      ),
                      labelStyle: const TextStyle(
                        color: Color(0xff274460),
                      ),
                      contentPadding:
                          const EdgeInsets.only(left: 35, top: 10, bottom: 10),
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(left: 25, right: 15),
                        child: Icon(Icons.send),
                      ),
                      suffixIconColor: const Color(0xff274460),
                    ),
                  ),
                ),
              ],
            ),

            // backgroundColor: const Color(0xff274460),
          );
        } else {
          return const Center(
            child: Text("Loading"),
          );
        }
      },
    );
  }
}
