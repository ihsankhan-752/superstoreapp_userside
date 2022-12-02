import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:superstore_app/controllers/cart_controller.dart';
import 'package:superstore_app/custom_widgets/buttons.dart';
import 'package:superstore_app/utils/functions/functions.dart';
import 'package:superstore_app/utils/styles/colors.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';
import 'package:superstore_app/views/payment_screen/payment_screen.dart';

import '../address_screen/add_address_screen.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartController>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: ColorPallet.PRIMARY_BLACK,
        ),
        title: Text("Place Order", style: AppTextStyles.APPBAR_HEADING_STYLE),
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorPallet.PRIMARY_WHITE,
              ),
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                    return data['address'] == ""
                        ? Center(
                            child: InkWell(
                              onTap: () {
                                navigateToPageWithPush(context, AddAddressScreen());
                              },
                              child: Text(
                                "Please Enter Your Address First",
                                style: GoogleFonts.acme(
                                  fontSize: 20,
                                  color: ColorPallet.GREY_COLOR,
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Full Name: ${data['customerName']}"),
                                SizedBox(height: 10),
                                Text("Phone: ${data['phone']}"),
                                SizedBox(height: 10),
                                Text("Address: ${data['address']}"),
                              ],
                            ),
                          );
                  }
                },
              )),
          SizedBox(height: 20),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorPallet.PRIMARY_WHITE,
              ),
              child: ListView.builder(
                itemCount: provider.itemsLength,
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorPallet.PRIMARY_BLACK),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            child: Image.network(provider.items[index].imageUrl[0]),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(provider.items[index].name),
                                Text(provider.items[index].price.toStringAsFixed(2)),
                              ],
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text("x ${provider.items[index].quantity}"),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )),
        ],
      ),
      bottomSheet: Container(
        margin: EdgeInsets.all(10),
        child: PrimaryButton(
          onTap: () {
            navigateToPageWithPush(context, PaymentScreen());
          },
          title: "Confirm Payment: ${provider.totalPrice} USD",
        ),
      ),
    );
  }
}
