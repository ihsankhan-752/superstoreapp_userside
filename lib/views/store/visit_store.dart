import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:superstore_app/custom_widgets/buttons.dart';
import 'package:superstore_app/utils/functions/functions.dart';
import 'package:superstore_app/utils/styles/colors.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';

import '../chat/chat_screen.dart';
import '../home/widgets/pdt_model.dart';

class VisitStoreScreen extends StatefulWidget {
  final String? supplierId;
  final String? supplierName;
  final String? supplierEmail;

  const VisitStoreScreen({Key? key, this.supplierId, this.supplierName, this.supplierEmail}) : super(key: key);

  @override
  State<VisitStoreScreen> createState() => _VisitStoreScreenState();
}

class _VisitStoreScreenState extends State<VisitStoreScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.supplierId);
    print(widget.supplierName);
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            color: Colors.blueGrey,
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection("users").doc(widget.supplierId).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Something Went Wrong"),
                    );
                  }
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.arrow_back, color: Colors.amber)),
                      SizedBox(width: 20),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.brown, width: 2),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Image.network(data['image'], fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(width: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data['userName'].toString().toUpperCase(),
                              style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                                fontSize: 18,
                                color: ColorPallet.PRIMARY_WHITE,
                                letterSpacing: 1.2,
                              ),
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                              height: 35,
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: PrimaryButton(
                                onTap: () {},
                                title: "Follow",
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          ),
          Container(
            height: 5,
            width: double.infinity,
            color: Colors.brown,
          ),
          Container(
            height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.22),
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("products").where("supplierId", isEqualTo: widget.supplierId).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text("No Data Found!!"),
                  );
                }
                return StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  crossAxisCount: 2,
                  itemBuilder: (context, index) {
                    return ProductModel(
                      products: snapshot.data!.docs[index],
                    );
                  },
                  staggeredTileBuilder: (context) => StaggeredTile.fit(1),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToPageWithPush(
              context,
              ChatScreen(
                supplierId: widget.supplierId,
                supplierName: widget.supplierName,
                supplierEmail: widget.supplierEmail,
              ));
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.textsms),
      ),
    );
  }
}
