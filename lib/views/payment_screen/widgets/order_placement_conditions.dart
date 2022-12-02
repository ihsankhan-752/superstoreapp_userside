import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superstore_app/custom_widgets/buttons.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';
import 'package:superstore_app/views/payment_screen/widgets/payment_through_stripe.dart';

import '../../../controllers/cart_controller.dart';
import 'cash_on_delivery_function.dart';

orderPlacementConditions({BuildContext? context, int? groupVal, dynamic data}) async {
  final provider = Provider.of<CartController>(context!, listen: false);
  if (groupVal == 1) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        )),
        context: context,
        builder: (_) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Pay At Home ${provider.totalPrice.toStringAsFixed(2)}",
                  style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                    color: Colors.blueGrey,
                    fontSize: 20,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PrimaryButton(
                    onTap: () async {
                      cashOnDelivery(context, data);
                    },
                    title: "Confirm ${provider.totalPrice.toStringAsFixed(2)}",
                  ),
                )
              ],
            ),
          );
        });
  } else if (groupVal == 2) {
    final provider = Provider.of<CartController>(context, listen: false);
    double totalAmount = provider.totalPrice + 10.0;
    int payment = totalAmount.round();
    int pay = payment * 100;

    await makePaymentWithCard(data, pay.toString(), context);
  } else if (groupVal == 3) {
    print("Paypal");
  } else {
    print("Jazz Cash");
  }
}
