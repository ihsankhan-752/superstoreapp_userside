import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:superstore_app/controllers/cart_controller.dart';
import 'package:superstore_app/utils/styles/colors.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';
import 'package:superstore_app/views/payment_screen/widgets/order_placement_conditions.dart';

import '../../custom_widgets/buttons.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _groupValue = 1;
  late String orderId;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartController>(context);

    double total = provider.totalPrice;
    double orderTotal = total - 10.0;
    double shipmentCost = 10.0;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: ColorPallet.PRIMARY_BLACK,
        ),
        title: Text("Payment Screen", style: AppTextStyles.APPBAR_HEADING_STYLE),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Material(
              child: Center(
                child: Text("SomeThing went wrong!"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorPallet.PRIMARY_WHITE,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Total :${total.toStringAsFixed(2)}"),
                          Divider(thickness: 1),
                          SizedBox(height: 10),
                          Text("OrderTotal :${orderTotal.toStringAsFixed(2)}"),
                          SizedBox(height: 10),
                          Text("Shipment :${shipmentCost.toStringAsFixed(2)}"),
                        ],
                      ),
                    )),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorPallet.PRIMARY_WHITE,
                  ),
                  child: Column(
                    children: [
                      RadioListTile(
                        value: 1,
                        groupValue: _groupValue,
                        onChanged: (v) {
                          setState(() {
                            _groupValue = int.parse(v.toString());
                          });
                        },
                        title: Text("Cash On Delivery"),
                        subtitle: Text("Pay at Home"),
                      ),
                      RadioListTile(
                        value: 2,
                        groupValue: _groupValue,
                        onChanged: (v) {
                          setState(() {
                            _groupValue = int.parse(v.toString());
                          });
                        },
                        title: Text("Pay via Visa/ Master Card"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(FontAwesomeIcons.ccMastercard, color: Colors.blue),
                          ],
                        ),
                      ),
                      RadioListTile(
                        value: 3,
                        groupValue: _groupValue,
                        onChanged: (v) {
                          setState(() {
                            _groupValue = int.parse(v.toString());
                          });
                        },
                        title: Text("Cash Via Paypal"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(FontAwesomeIcons.paypal, color: Colors.blue),
                          ],
                        ),
                      ),
                      RadioListTile(
                        value: 4,
                        groupValue: _groupValue,
                        onChanged: (v) {
                          setState(() {
                            _groupValue = int.parse(v.toString());
                          });
                        },
                        title: Text("Cash Via JazzCash"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 30,
                              width: 60,
                              child: Image.asset("assets/images/png/jazzcash.png"),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.all(10),
                  child: PrimaryButton(
                    onTap: () {
                      orderPlacementConditions(
                        context: context,
                        groupVal: _groupValue,
                        data: data,
                      );
                    },
                    title: "Confirm ${provider.totalPrice.toStringAsFixed(2)} USD",
                  ),
                ),
                SizedBox(height: 20),
              ],
            );
          } else {
            return Center(
              child: SizedBox(),
            );
          }
        },
      ),
    );
  }
}
