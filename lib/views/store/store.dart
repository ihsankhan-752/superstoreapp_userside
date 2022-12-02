import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:superstore_app/utils/functions/functions.dart';
import 'package:superstore_app/utils/styles/app_text.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';
import 'package:superstore_app/views/store/visit_store.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade100,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppText.STORES, style: AppTextStyles.APPBAR_HEADING_STYLE),
                ],
              ),
            ),
            Divider(color: Colors.red, thickness: 0.7),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("users").where('isSupplier', isEqualTo: true).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          navigateToPageWithPush(
                            context,
                            VisitStoreScreen(
                              supplierId: snapshot.data!.docs[index].id,
                              supplierName: snapshot.data!.docs[index]['userName'],
                              supplierEmail: snapshot.data!.docs[index]['email'],
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                                width: double.infinity,
                                child: Image.network(
                                  snapshot.data!.docs[index]['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                snapshot.data!.docs[index]['userName'],
                                style: GoogleFonts.acme(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  color: Colors.blueGrey,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
