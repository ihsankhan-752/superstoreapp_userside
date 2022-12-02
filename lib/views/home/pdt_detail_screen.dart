import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:superstore_app/controllers/cart_controller.dart';
import 'package:superstore_app/controllers/wishlist_controller.dart';
import 'package:superstore_app/custom_widgets/buttons.dart';
import 'package:superstore_app/utils/functions/functions.dart';
import 'package:superstore_app/utils/styles/colors.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';
import 'package:superstore_app/views/cart/cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final dynamic productInfo;

  const ProductDetailScreen({this.productInfo});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartController>(context);
    final wishListProvider = Provider.of<WishListController>(context);
    final List<dynamic> imageList = productInfo['productImages'];
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.blueGrey.shade100,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: ColorPallet.PRIMARY_BLACK,
        ),
        centerTitle: true,
        title: Text(productInfo['pdtName']!, style: AppTextStyles.APPBAR_HEADING_STYLE),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: Swiper(
                      pagination: SwiperPagination(
                        builder: SwiperPagination.fraction,
                      ),
                      itemCount: imageList.length,
                      itemBuilder: (context, index) {
                        return Image(
                          image: NetworkImage(imageList[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                productInfo['pdtName']!,
                style: GoogleFonts.acme(
                    textStyle: TextStyle(
                  fontSize: 22,
                  color: Colors.blueGrey,
                )),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${productInfo['price']!.toStringAsFixed(2)} USD",
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorPallet.ORANGE_COLOR,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      wishListProvider.wishListItems.firstWhereOrNull((pdt) => pdt.docId == productInfo['pdtId']) != null
                          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Is Added To Cart")))
                          : wishListProvider.addToWishList(
                              productInfo['pdtName'],
                              productInfo['price'],
                              1,
                              productInfo['quantity'],
                              productInfo['pdtId'],
                              productInfo['productImages'],
                              productInfo['supplierId'],
                            );
                    },
                    child: Icon(Icons.favorite_border, color: ColorPallet.ORANGE_COLOR),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "${productInfo['quantity']} Pieces in Stock",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5,
                    width: 100,
                    color: ColorPallet.ORANGE_COLOR,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Item Description", style: AppTextStyles.APPBAR_HEADING_STYLE),
                  ),
                  Container(
                    height: 5,
                    width: 100,
                    color: ColorPallet.ORANGE_COLOR,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                productInfo['pdtDescription']!,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey.shade900,
                ),
              ),
              ExpansionTile(
                title: Text("Review",
                    style: AppTextStyles.FASHION_STYLE.copyWith(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: double.infinity,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("products")
                          .doc(productInfo["pdtId"])
                          .collection("review")
                          .snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.data!.docs.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Text(
                              "This Product is Not Review Yet",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                                fontSize: 22,
                                color: Colors.blueGrey,
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var userData = snapshot.data!.docs[index];
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(userData['customerImage']),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userData['customerName'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          userData['comment'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(Icons.grade, size: 20, color: Colors.yellow),
                                    Text(
                                      userData['rating'].toString(),
                                      style: TextStyle(
                                        color: Colors.yellowAccent,
                                      ),
                                    )
                                  ],
                                ),
                                Divider(color: Colors.red, thickness: 0.5),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 45,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.store),
              IconButton(
                icon: Badge(
                  showBadge: provider.items.isEmpty ? false : true,
                  badgeColor: Colors.yellow,
                  badgeContent: Text(
                    provider.itemsLength.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: Icon(Icons.shopping_cart),
                ),
                onPressed: () {
                  navigateToPageWithPush(context, CartScreen());
                },
              ),
              SizedBox(
                height: 35,
                width: MediaQuery.of(context).size.width * 0.4,
                child: PrimaryButton(
                  onTap: () {
                    var isItemExist = provider.items.firstWhereOrNull((product) => product.docId == productInfo['pdtId']);
                    if (isItemExist != null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Already Exist In Cart")));
                    } else {
                      provider.addItemToCart(
                        productInfo['pdtName'],
                        productInfo['price'],
                        1,
                        productInfo['quantity'],
                        productInfo['pdtId'],
                        productInfo['productImages'],
                        productInfo['supplierId'],
                      );
                    }
                  },
                  title: "Add To Cart",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
