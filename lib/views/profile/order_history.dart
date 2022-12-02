import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:superstore_app/utils/functions/functions.dart';
import 'package:superstore_app/utils/styles/colors.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';
import 'package:superstore_app/views/profile/widgets/order_info_card.dart';
import 'package:superstore_app/views/profile/widgets/order_rating_screen.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ColorPallet.PRIMARY_BLACK,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("Order History", style: AppTextStyles.APPBAR_HEADING_STYLE),
      ),
      body: Column(
        children: [
          Divider(thickness: 0.7, color: Colors.red),
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("orders")
                  .where("customerId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      "Sorry ! No Active Order Found",
                      style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                        fontSize: 18,
                        color: Colors.blueGrey,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var orderInfo = snapshot.data!.docs[index];
                    return Container(
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.brown),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                height: 100,
                                width: 80,
                                child: Image.network(orderInfo['orderImage']),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(orderInfo['orderName']),
                                      Text("\$ ${orderInfo['orderPrice'].toString()}"),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(top: 60, right: 20),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text("x${orderInfo['orderQuantity']}"),
                                ),
                              )
                            ],
                          ),
                          ExpansionTile(
                            title: Text("See More"),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    OrderInfoCard(title: "Name", value: orderInfo['customerName']),
                                    OrderInfoCard(title: "Phone", value: orderInfo['customerPhone']),
                                    OrderInfoCard(title: "Email", value: orderInfo['customerEmail']),
                                    OrderInfoCard(title: "Address", value: orderInfo['customerAddress']),
                                    OrderInfoCard(title: "Payment Status", value: orderInfo['paymentStatus']),
                                    OrderInfoCard(title: "Order Status", value: orderInfo['orderStatus']),
                                    orderInfo['orderStatus'] == "deliver"
                                        ? InkWell(
                                            onTap: () async {
                                              navigateToPageWithPush(
                                                  context,
                                                  OrderRatingScreen(
                                                    pdtId: orderInfo['productId'],
                                                  ));
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Write Your Review",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Icon(Icons.grade, color: Colors.amber),
                                              ],
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
