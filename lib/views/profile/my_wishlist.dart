import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:superstore_app/controllers/wishlist_controller.dart';
import 'package:superstore_app/utils/styles/colors.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';

class MyWishListScreen extends StatelessWidget {
  const MyWishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishListController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ColorPallet.PRIMARY_BLACK,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("My Wishlist", style: AppTextStyles.APPBAR_HEADING_STYLE),
      ),
      body: Column(
        children: [
          Divider(thickness: 0.7, color: Colors.red),
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.infinity,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount: wishlistProvider.wishListItems.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorPallet.PRIMARY_BLACK, width: 0.7),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                color: Colors.red,
                                child: Image.network(wishlistProvider.wishListItems[index].imageUrl[0], fit: BoxFit.cover),
                              ),
                              SizedBox(width: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      wishlistProvider.wishListItems[index].name,
                                      style: GoogleFonts.acme(
                                        fontSize: 18,
                                        letterSpacing: 0.6,
                                        color: ColorPallet.DARK_GREY_COLOR,
                                      ),
                                    ),
                                    Text(
                                      "${wishlistProvider.wishListItems[index].price.toStringAsFixed(2)} USD",
                                      style: GoogleFonts.acme(
                                        fontSize: 16,
                                        letterSpacing: 0.3,
                                        color: ColorPallet.DARK_GREY_COLOR,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.shopping_basket_outlined),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
