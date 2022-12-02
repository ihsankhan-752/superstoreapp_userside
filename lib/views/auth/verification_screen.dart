import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:superstore_app/custom_widgets/buttons.dart';

import 'package:superstore_app/utils/styles/colors.dart';
import 'package:superstore_app/utils/styles/text_styles.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_new)),
            Spacer(),
            Text("Sign up",
                style: AppTextStyles().subHeading.copyWith(
                    color: ColorPallet.Pink_COLOR,
                    fontSize: 16,
                    fontWeight: FontWeight.w400))
          ],
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Superstore",
              style:
                  AppTextStyles().H1.copyWith(color: ColorPallet.PRIMARY_BLACK),
            ),
            Text(
              "Fashion",
              style: AppTextStyles()
                  .subHeading
                  .copyWith(color: ColorPallet.PRIMARY_BLACK),
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: ColorPallet.GREY_COLOR,
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: CircleAvatar(
                        radius: 15, child: Center(child: Icon(Icons.add))))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Verification",
              style: AppTextStyles()
                  .H1
                  .copyWith(color: ColorPallet.PRIMARY_BLACK, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "A 5-Digit PIN has been sent to your\nemail. Enter it below to continue",
              style: AppTextStyles()
                  .subHeading
                  .copyWith(color: ColorPallet.PRIMARY_BLACK),
            ),
            SizedBox(
              height: 30,
            ),
            PinCodeTextField(
              appContext: context,
              length: 5,
              onChanged: (v) {},
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  fieldHeight: 45,
                  fieldWidth: 45,
                  borderRadius: BorderRadius.circular(10),
                  activeColor: ColorPallet.Pink_COLOR,
                  selectedColor: ColorPallet.GREY_COLOR,
                  inactiveColor: ColorPallet.GREY_COLOR),
            ),
            SizedBox(
              height: 20,
            ),
            PrimaryButton(
              title: 'CONTINUE',
            )
          ],
        ),
      ),
    );
  }
}
