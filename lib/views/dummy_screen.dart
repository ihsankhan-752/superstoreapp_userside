import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:superstore_app/services/notification_services.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  TextEditingController username = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  String myToken = "";
  @override
  void initState() {
    NotificationServices().getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Testing"),
      ),
      body: Column(
        children: [
          SizedBox(height: 200),
          TextField(
            controller: username,
          ),
          SizedBox(height: 20),
          TextField(
            controller: titleController,
          ),
          SizedBox(height: 20),
          TextField(
            controller: bodyController,
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              String name = username.text.trim();
              String title = titleController.text.trim();
              String body = bodyController.text.trim();
              if (name != "") {
                DocumentSnapshot snap = await FirebaseFirestore.instance.collection("tokens").doc(name).get();
                String token = snap['token'];
                print(token);
                NotificationServices().sendPushNotification(
                    "e_lSlroBRnqPopKF0E9Uzk:APA91bHSjPTPVSekZOFmmOChl-cG-xF2pwieE07STN6q2TNUXtMu0FTPAbfzSp6_2_FEbmKDT1ij5oeQYVsDvXuoN-fzWfkUYC8ETZBiNxzXZsnPhyz1Hu5qOm_1TLG3ub9jMi-m4imJ",
                    body,
                    title);
              }
            },
            child: Container(
              height: 45,
              width: 200,
              color: Colors.blueGrey,
              child: Center(child: Text("Send")),
            ),
          )
        ],
      ),
    );
  }
}
