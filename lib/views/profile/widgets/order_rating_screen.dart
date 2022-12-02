import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:superstore_app/custom_widgets/buttons.dart';

import '../../../utils/styles/text_field_decoration.dart';

class OrderRatingScreen extends StatefulWidget {
  final String? pdtId;
  const OrderRatingScreen({Key? key, this.pdtId}) : super(key: key);

  @override
  State<OrderRatingScreen> createState() => _OrderRatingScreenState();
}

class _OrderRatingScreenState extends State<OrderRatingScreen> {
  GlobalKey<FormState> _key = GlobalKey();
  String comment = "";
  double rating = 0.0;
  @override
  Widget build(BuildContext context) {
    print(widget.pdtId);
    return Scaffold(
      body: Form(
        key: _key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: RatingBar.builder(
                initialRating: 5,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rat) {
                  setState(() {
                    rating = rat;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                onSaved: (v) {
                  setState(() {
                    comment = v.toString();
                  });
                },
                maxLength: 50,
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Enter Comment";
                  } else {
                    return null;
                  }
                },
                decoration: inputDecoration.copyWith(
                  hintText: "Enter Your Comment",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: PrimaryButton(
                onTap: () async {
                  if (_key.currentState!.validate()) {
                    _key.currentState!.save();
                    DocumentSnapshot snapshot = await FirebaseFirestore.instance
                        .collection("customers")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get();
                    FirebaseFirestore.instance.collection("products").doc(widget.pdtId).collection("review").add(
                      {
                        "customerName": snapshot['customerName'],
                        "customerImage": snapshot['image'],
                        "customerUid": snapshot['uid'],
                        "rating": rating,
                        "comment": comment,
                      },
                    );
                    await ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Review Added Successfully!"),
                      ),
                    );
                    Navigator.of(context).pop();
                  } else {
                    print("Error");
                  }
                },
                title: "Save",
              ),
            )
          ],
        ),
      ),
    );
  }
}
