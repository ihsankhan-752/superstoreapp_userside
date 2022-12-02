import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:superstore_app/services/notification_services.dart';
import 'package:superstore_app/utils/styles/colors.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';

class ChatScreen extends StatefulWidget {
  final String? supplierId;
  final String? supplierName;
  final String? supplierEmail;
  const ChatScreen({Key? key, this.supplierId, this.supplierName, this.supplierEmail}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();
  String enteredMsg = '';
  String? docId;
  String customerId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    if (customerId.hashCode > widget.supplierId.hashCode) {
      docId = customerId + widget.supplierId!;
    } else {
      docId = widget.supplierId! + customerId;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isMe = customerId;
    print(widget.supplierId);
    print(widget.supplierEmail);
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
        backgroundColor: Colors.blueGrey.shade100,
        title: Text(
          widget.supplierName!,
          style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: double.infinity,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("chat")
                    .doc(docId)
                    .collection("messages")
                    .orderBy("createdAt", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text("No Previous Chat Found with This Supplier"),
                    );
                  } else {
                    return ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        return Row(
                          mainAxisAlignment: data['uid'] == FirebaseAuth.instance.currentUser!.uid
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data['msg'],
                                  style: TextStyle(
                                    color: data['uid'] == customerId ? Colors.blue : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 60,
              width: double.infinity,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 05),
                  child: TextField(
                    controller: controller,
                    onChanged: (v) {
                      setState(() {
                        enteredMsg = v;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "type a message....",
                      suffixIcon: IconButton(
                        onPressed: () async {
                          try {
                            if ((await FirebaseFirestore.instance.collection("chat").doc(docId).get()).exists) {
                              FirebaseFirestore.instance.collection("chat").doc(docId).update({
                                "msg": enteredMsg,
                                // "ids": [widget.supplierId, customerId],
                              });
                            } else {
                              FirebaseFirestore.instance.collection("chat").doc(docId).set({
                                "msg": enteredMsg,
                                "ids": [widget.supplierId, customerId],
                              });
                            }
                            DocumentSnapshot user = await FirebaseFirestore.instance.collection("users").doc(customerId).get();
                            FirebaseFirestore.instance.collection("chat").doc(docId).collection("messages").add({
                              "createdAt": DateTime.now(),
                              "uid": FirebaseAuth.instance.currentUser!.uid,
                              // "customerId": customerId,
                              // "supplierId": widget.supplierId,
                              "msg": enteredMsg,
                              "customerName": user['userName'],
                              "customerImage": user['image'],
                              "customerPhone": user['phone'],
                            }).then((value) async {
                              controller.clear();
                              FocusScope.of(context).unfocus();
                            });
                          } catch (e) {
                            print(e);
                          }
                          DocumentSnapshot snap =
                              await FirebaseFirestore.instance.collection("tokens").doc(widget.supplierEmail).get();
                          String token = snap['token'];
                          print(token);
                          NotificationServices().sendPushNotification(token, "Hello", "You Have Recieved A Msg");
                        },
                        icon: Icon(Icons.send, size: 25, color: ColorPallet.PRIMARY_BLACK),
                      ),
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fillColor: Colors.black.withOpacity(0.3),
                      filled: true,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
