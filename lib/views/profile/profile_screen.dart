import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:superstore_app/services/auth_services.dart';
import 'package:superstore_app/utils/functions/functions.dart';
import 'package:superstore_app/utils/styles/app_text.dart';
import 'package:superstore_app/utils/styles/colors.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';
import 'package:superstore_app/views/address_screen/add_address_screen.dart';
import 'package:superstore_app/views/cart/cart_screen.dart';
import 'package:superstore_app/views/profile/edit_profile_screen.dart';
import 'package:superstore_app/views/profile/my_wishlist.dart';
import 'package:superstore_app/views/profile/order_history.dart';
import 'package:superstore_app/views/profile/widgets/custom_list_tile.dart';
import 'package:superstore_app/views/profile/widgets/profile_listtile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade100,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppText.ACCOUNT, style: AppTextStyles.APPBAR_HEADING_STYLE),
                  ],
                ),
              ),
              Divider(color: Colors.red, thickness: 0.7),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: StreamBuilder<DocumentSnapshot>(
                    stream:
                        FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                        return Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 35,
                              backgroundImage: NetworkImage(data['image']),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['userName'],
                                  style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                                    fontSize: 18,
                                    color: ColorPallet.PRIMARY_BLACK,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(data['email']),
                              ],
                            )
                          ],
                        );
                      }
                    }),
              ),
              Divider(color: Colors.red, thickness: 0.7),
              SizedBox(height: 20),
              ProfileListTileWidget(
                  onPressed: () => navigateToPageWithPush(context, OrderHistory()),
                  icon: FontAwesomeIcons.clockRotateLeft,
                  title: "Order History"),
              ProfileListTileWidget(
                  onPressed: () => navigateToPageWithPush(context, MyWishListScreen()),
                  icon: FontAwesomeIcons.heart,
                  title: "My Wishlist"),
              ProfileListTileWidget(
                  onPressed: () => navigateToPageWithPush(context, CartScreen()),
                  icon: FontAwesomeIcons.cartShopping,
                  title: "My Cart"),
              Text(
                "-----------Account Info------------",
                style: TextStyle(
                  fontSize: 20,
                  color: ColorPallet.GREY_COLOR,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                height: 300,
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                    return Column(
                      children: [
                        CustomListTile(
                          title: "Email",
                          subTitle: data['email'],
                          icon: Icons.email,
                        ),
                        CustomListTile(
                          title: "Phone Number",
                          subTitle: data['phone'] == "" ? "No Phone Number Found" : data['phone'],
                          icon: Icons.phone,
                        ),
                        CustomListTile(
                          onPressed: data['address'] == ""
                              ? () {
                                  navigateToPageWithPush(context, AddAddressScreen());
                                }
                              : () {},
                          title: "Address",
                          subTitle: data['address'] == "" ? "No Address Found Add?" : data['address'],
                          icon: Icons.location_on,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Text(
                "-----------Account Settings------------",
                style: TextStyle(
                  fontSize: 20,
                  color: ColorPallet.GREY_COLOR,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CustomListTile(
                onPressed: () {
                  navigateToPageWithPush(context, EditProfileScreen());
                },
                title: "Edit Profile",
                subTitle: "",
                icon: Icons.edit,
              ),
              CustomListTile(
                title: "Change Password",
                subTitle: "",
                icon: Icons.lock,
              ),
              CustomListTile(
                onPressed: (){
                  AuthServices.signOut(context);
                },
                title: "Log Out",
                subTitle: "",
                icon: Icons.logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
