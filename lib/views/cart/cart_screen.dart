import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superstore_app/controllers/cart_controller.dart';
import 'package:superstore_app/custom_widgets/alert_dilog.dart';
import 'package:superstore_app/custom_widgets/buttons.dart';
import 'package:superstore_app/utils/styles/colors.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';
import 'package:superstore_app/utils/functions/functions.dart';
import 'package:superstore_app/views/order_screen/place_order_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartController>(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.blueGrey.shade100,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: ColorPallet.PRIMARY_BLACK,
        ),
        actions: [
          IconButton(
              onPressed: () {
                customAlertDialogBox(
                    context: context,
                    title: "Wait !!",
                    content: "Do You Want To Clear Your Cart ?",
                    plusBtnClicked: () {
                      provider.clearCart();
                      Navigator.of(context).pop();
                    });
              },
              icon: Icon(Icons.delete_forever, color: Colors.red)),
        ],
        centerTitle: true,
        title: Text("My Cart", style: AppTextStyles.APPBAR_HEADING_STYLE),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView.builder(
          itemCount: provider.itemsLength,
          itemBuilder: (context, index) {
            return Card(
              elevation: 1.0,
              color: ColorPallet.PRIMARY_WHITE,
              child: Container(
                height: 80,
                child: ListTile(
                  contentPadding: EdgeInsets.only(top: 0, left: 10),
                  leading: Container(
                    clipBehavior: Clip.antiAlias,
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.network(provider.items[index].imageUrl[0],
                        fit: BoxFit.cover),
                  ),
                  title: Text(provider.items[index].name),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${provider.items[index].price.toString()} USD",
                        style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey.withOpacity(0.5),
                        ),
                        child: Row(
                          children: [
                            provider.items[index].quantity == 1
                                ? IconButton(
                                    onPressed: () {
                                      customAlertDialogBox(
                                          context: context,
                                          title: "Wait !!",
                                          content:
                                              "Do You Want To Delete this Item ?",
                                          plusBtnClicked: () {
                                            provider.removeItem(
                                                provider.items[index]);
                                            Navigator.of(context).pop();
                                          });
                                    },
                                    icon: Icon(
                                      Icons.delete_forever,
                                      size: 15,
                                      color: Colors.red,
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      provider.decrement(provider.items[index]);
                                    },
                                    icon: Icon(Icons.remove,
                                        size: 15,
                                        color: ColorPallet.PRIMARY_BLACK),
                                  ),
                            Text(
                              provider.items[index].quantity.toString(),
                              style:
                                  AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                                color: ColorPallet.PRIMARY_BLACK,
                                fontSize: 14,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                provider.increment(provider.items[index]);
                              },
                              icon: Icon(Icons.add,
                                  size: 15, color: ColorPallet.PRIMARY_BLACK),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomSheet: Card(
        color: ColorPallet.PRIMARY_WHITE,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Total: \$ ${provider.totalPrice.toStringAsFixed(2)}"),
              SizedBox(
                width: MediaQuery.of(context).size.width * .6,
                child: PrimaryButton(
                  onTap: () {
                    navigateToPageWithPush(context, PlaceOrderScreen());
                  },
                  title: "Proceed To Check Out",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
